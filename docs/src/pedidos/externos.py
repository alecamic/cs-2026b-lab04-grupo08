class YapeSDK:
    def __init__(self, fallas=0):
        self.fallas = fallas
        self.llamadas = 0

    def realizar_cobro(self, telefono: str, soles: float) -> dict:
        self.llamadas += 1
        if self.llamadas <= self.fallas:
            raise TimeoutError("Error de conexión con Yape")
        if soles > 500:
            return {"ok": False, "operacion": None}
        return {"ok": True, "operacion": f"YAPE-{self.llamadas:04d}"}


class PlinClient:
    def __init__(self, fallas=0):
        self.fallas = fallas
        self.llamadas = 0

    def charge(self, amount_cents: int, phone: str) -> tuple[int, str]:
        self.llamadas += 1
        if self.llamadas <= self.fallas:
            raise TimeoutError("Error de conexión con Plin")
        if amount_cents > 50000:
            return 400, "EXCEEDED_LIMIT"
        return 200, f"PLIN-{self.llamadas:04d}"


class LLMNormalizadorExterno:
    """Simulación de proveedor de IA (Claude/OpenAI)."""
    def consultar_llm(self, texto: str) -> str:
        t = texto.lower()
        if "amarila" in t:
            return "papa amarilla S/ 3.50 oferta"
        if "palta" in t:
            return "palta fuerte orgánica garantizada"
        return texto.strip().capitalize()
