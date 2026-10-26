from abc import ABC, abstractmethod

class Suscriptor(ABC):
    @abstractmethod
    def actualizar(self, evento: str, datos: dict):
        pass

class PublicadorEventos:
    def __init__(self):
        self._suscriptores = {}

    def suscribir(self, evento: str, suscriptor: Suscriptor):
        self._suscriptores.setdefault(evento, []).append(suscriptor)

    def publicar(self, evento: str, datos: dict):
        for s in self._suscriptores.get(evento, []):
            s.actualizar(evento, datos)

class NotificadorWhatsApp(Suscriptor):
    def __init__(self, bandeja: list):
        self._bandeja = bandeja

    def actualizar(self, evento: str, datos: dict):
        self._bandeja.append(f"whatsapp: {datos['celular']}: Pedido {datos['id']} pagado")

class ActualizadorReportes(Suscriptor):
    def __init__(self, bandeja: list):
        self._bandeja = bandeja

    def actualizar(self, evento: str, datos: dict):
        self._bandeja.append(f"reporte: {datos['id']}: {datos['total']:.2f}")
