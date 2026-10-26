from abc import ABC

class EstadoPedido(ABC):
    nombre = "?"

    def confirmar(self, pedido):
        raise ValueError(f"No se puede confirmar un pedido en estado {self.nombre}")

    def pagar(self, pedido, operacion):
        raise ValueError(f"No se puede pagar un pedido en estado {self.nombre}")

    def cancelar(self, pedido):
        raise ValueError(f"No se puede cancelar un pedido en estado {self.nombre}")


class Borrador(EstadoPedido):
    nombre = "BORRADOR"

    def confirmar(self, pedido):
        if not pedido.lineas:
            raise ValueError("El pedido no tiene líneas")
        pedido.cambiar_a(Confirmado())

    def cancelar(self, pedido):
        pedido.cambiar_a(Cancelado())


class Confirmado(EstadoPedido):
    nombre = "CONFIRMADO"

    def pagar(self, pedido, operacion):
        pedido.operacion = operacion
        pedido.cambiar_a(Pagado())

    def cancelar(self, pedido):
        pedido.cambiar_a(Cancelado())


class Pagado(EstadoPedido):
    nombre = "PAGADO"


class Cancelado(EstadoPedido):
    nombre = "CANCELADO"
