from src.pedidos.externos import YapeSDK, PlinClient, LLMNormalizadorExterno
from src.pedidos.pagos import FabricaPasarelas, YapeAdapter, PlinAdapter
from src.pedidos.estados import Borrador, EstadoPedido
from src.pedidos.eventos import PublicadorEventos, NotificadorWhatsApp, ActualizadorReportes
from src.pedidos.ia import (
    ClaudeAdapter, ConCacheLLM, SinPreciosGuardrail, 
    SinAfirmacionesProhibidasGuardrail, GeneradorDescripciones
)

class Linea:
    def __init__(self, producto: str, cantidad: int, precio: float):
        self.producto = producto
        self.cantidad = cantidad
        self.precio = precio

class Pedido:
    def __init__(self, id: int, celular: str, lineas: list[Linea]):
        self.id = id
        self.celular = celular
        self.lineas = lineas
        self._estado: EstadoPedido = Borrador()
        self.operacion = None

    @property
    def estado(self) -> str:
        return self._estado.nombre

    def cambiar_a(self, nuevo_estado: EstadoPedido):
        self._estado = nuevo_estado

    def total(self) -> float:
        return sum(l.cantidad * l.precio for l in self.lineas)

    def confirmar(self):
        self._estado.confirmar(self)

    def pagar(self, operacion: str):
        self._estado.pagar(self, operacion)

    def cancelar(self):
        self._estado.cancelar(self)

class ServicioPedidos:
    def __init__(self, yape=None, plin=None, llm=None):
        self.yape_sdk = yape or YapeSDK()
        self.plin_sdk = plin or PlinClient()
        self.llm_sdk = llm or LLMNormalizadorExterno()
        self.eventos = []

        # Configurar Factory de Pasarelas (Strategy + Adapter)
        self.fabrica = FabricaPasarelas()
        self.fabrica.registrar("YAPE", lambda: YapeAdapter(self.yape_sdk))
        self.fabrica.registrar("PLIN", lambda: PlinAdapter(self.plin_sdk))

        # Configurar Observer
        self.publicador = PublicadorEventos()
        self.publicador.suscribir("pedido_pagado", NotificadorWhatsApp(self.eventos))
        self.publicador.suscribir("pedido_pagado", ActualizadorReportes(self.eventos))

        # Configurar IA (Strategy + Adapter + Decorator + Chain of Resp.)
        adapter_llm = ClaudeAdapter(self.llm_sdk)
        self.llm_cached = ConCacheLLM(adapter_llm)
        guardrails = SinPreciosGuardrail(SinAfirmacionesProhibidasGuardrail())
        self.generador_ia = GeneradorDescripciones(self.llm_cached, guardrails)

    def confirmar_y_pagar(self, pedido: Pedido, medio: str) -> str:
        pasarela = self.fabrica.crear(medio)
        pedido.confirmar()
        resultado = pasarela.cobrar(pedido.total(), pedido.celular)
        
        if resultado.aprobado:
            pedido.pagar(resultado.operacion)
            self.publicador.publicar("pedido_pagado", {
                "id": pedido.id,
                "celular": pedido.celular,
                "total": pedido.total()
            })
        else:
            pedido.cancelar()

        return pedido.estado

    def normalizar_producto_ia(self, texto: str) -> str:
        return self.generador_ia.normalizar(texto)
