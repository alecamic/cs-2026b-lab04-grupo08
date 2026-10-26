from src.pedidos.externos import YapeSDK, PlinClient, LLMNormalizadorExterno

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
        self.estado = "BORRADOR"
        self.operacion = None

    def total(self) -> float:
        return sum(l.cantidad * l.precio for l in self.lineas)

class ServicioPedidos:
    def __init__(self, yape=None, plin=None, llm=None):
        self.yape = yape or YapeSDK()
        self.plin = plin or PlinClient()
        self.llm = llm or LLMNormalizadorExterno()
        self.eventos = []

    def confirmar_y_pagar(self, pedido: Pedido, medio: str) -> str:
        # Olor: Condicionales anidados de estado
        if pedido.estado != "BORRADOR":
            if pedido.estado == "CANCELADO":
                raise ValueError("El pedido está cancelado")
            elif pedido.estado == "PAGADO":
                raise ValueError("El pedido ya fue pagado")
            else:
                raise ValueError("Estado no válido")

        if not pedido.lineas:
            raise ValueError("El pedido no tiene líneas")

        total = pedido.total()
        pedido.estado = "CONFIRMADO"
        aprobado, operacion = False, None

        # Olor: if/elif por medio de pago + SDKs acoplados + Reintentos duplicados
        if medio == "YAPE":
            for intento in range(3):
                try:
                    r = self.yape.realizar_cobro(pedido.celular, total)
                    aprobado, operacion = r["ok"], r.get("operacion")
                    break
                except TimeoutError:
                    if intento == 2:
                        aprobado = False
        elif medio == "PLIN":
            for intento in range(3):
                try:
                    codigo, tx = self.plin.charge(int(round(total * 100)), pedido.celular)
                    aprobado, operacion = (codigo == 200), tx
                    break
                except TimeoutError:
                    if intento == 2:
                        aprobado = False
        else:
            raise ValueError(f"Medio de pago no soportado: {medio}")

        if aprobado:
            pedido.estado = "PAGADO"
            pedido.operacion = operacion
            # Olor: Notificaciones y reportes armados a mano
            self.eventos.append(f"whatsapp: {pedido.celular}: Pedido {pedido.id} pagado")
            self.eventos.append(f"reporte: {pedido.id}: {total:.2f}")
        else:
            pedido.estado = "CANCELADO"

        return pedido.estado

    def normalizar_producto_ia(self, texto: str) -> str:
        # Olor: Lógica de IA mezclada sin validaciones ni caché
        res = self.llm.consultar_llm(texto)
        return res
