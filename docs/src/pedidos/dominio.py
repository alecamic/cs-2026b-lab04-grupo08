from dataclasses import dataclass, field
from enum import Enum
from typing import List, Optional
from uuid import UUID, uuid4
from abc import ABC, abstractmethod
from decimal import Decimal

class EstadoPedidoPuesto(Enum):
    RECIBIDO = "RECIBIDO"
    PREPARANDO = "PREPARANDO"
    LISTO = "LISTO"
    RECOGIDO = "RECOGIDO"
    ENTREGADO = "ENTREGADO"
    RECHAZADO = "RECHAZADO"
    CANCELADO = "CANCELADO"

class MedioPago(Enum):
    YAPE = "YAPE"
    PLIN = "PLIN"

@dataclass
class Producto:
    id: UUID
    nombre: str
    precio_unitario: Decimal
    stock_disponible: int

    def reservar(self, cantidad: int) -> None:
        if self.stock_disponible < cantidad:
            raise ValueError("Stock insuficiente")
        self.stock_disponible -= cantidad

    def liberar(self, cantidad: int) -> None:
        self.stock_disponible += cantidad

@dataclass
class LineaPedido:
    cantidad: int
    precio_unitario: Decimal
    producto: Producto

    def subtotal(self) -> Decimal:
        return self.cantidad * self.precio_unitario

@dataclass
class Pago:
    id: UUID
    monto: Decimal
    medio: MedioPago
    codigo_operacion: str
    aprobado: bool

@dataclass
class PedidoPuesto:
    id: UUID = field(default_factory=uuid4)
    lineas: List[LineaPedido] = field(default_factory=list)
    estado: EstadoPedidoPuesto = EstadoPedidoPuesto.RECIBIDO
    subtotal: Decimal = Decimal("0.00")

    def aceptar_preparacion(self) -> None:
        self.estado = EstadoPedidoPuesto.PREPARANDO

    def marcar_listo(self) -> None:
        self.estado = EstadoPedidoPuesto.LISTO

    def cancelar(self, motivo: str) -> None:
        self.estado = EstadoPedidoPuesto.CANCELADO
        for linea in self.lineas:
            linea.producto.liberar(linea.cantidad)

class PasarelaPago(ABC):
    @abstractmethod
    def cobrar(self, monto: Decimal, celular: str) -> Pago:
        pass

class YapeAdapter(PasarelaPago):
    def cobrar(self, monto: Decimal, celular: str) -> Pago:
        raise NotImplementedError("Integración con pasarela Yape")
