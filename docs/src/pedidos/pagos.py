from abc import ABC, abstractmethod
from dataclasses import dataclass

@dataclass(frozen=True)
class ResultadoPago:
    aprobado: bool
    operacion: str | None = None

class PasarelaPago(ABC):
    """Puerto / Strategy."""
    @abstractmethod
    def cobrar(self, monto: float, celular: str) -> ResultadoPago:
        pass

class YapeAdapter(PasarelaPago):
    def __init__(self, sdk):
        self._sdk = sdk

    def cobrar(self, monto: float, celular: str) -> ResultadoPago:
        res = self._sdk.realizar_cobro(celular, monto)
        return ResultadoPago(res["ok"], res.get("operacion"))

class PlinAdapter(PasarelaPago):
    def __init__(self, client):
        self._client = client

    def cobrar(self, monto: float, celular: str) -> ResultadoPago:
        codigo, tx = self._client.charge(int(round(monto * 100)), celular)
        return ResultadoPago(codigo == 200, tx if codigo == 200 else None)

class ConReintentos(PasarelaPago):
    """Decorator para reintentos transparentes."""
    def __init__(self, interna: PasarelaPago, intentos: int = 3):
        self._interna = interna
        self._intentos = intentos

    def cobrar(self, monto: float, celular: str) -> ResultadoPago:
        for intento in range(self._intentos):
            try:
                return self._interna.cobrar(monto, celular)
            except TimeoutError:
                if intento == self._intentos - 1:
                    return ResultadoPago(False)
        return ResultadoPago(False)

class FabricaPasarelas:
    def __init__(self):
        self._creadores = {}

    def registrar(self, medio: str, creador):
        self._creadores[medio] = creador

    def crear(self, medio: str) -> PasarelaPago:
        if medio not in self._creadores:
            raise ValueError(f"Medio de pago no soportado: {medio}")
        return ConReintentos(self._creadores[medio]())
