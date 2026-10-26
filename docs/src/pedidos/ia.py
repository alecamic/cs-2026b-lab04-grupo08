from abc import ABC, abstractmethod

# 1. Strategy / Adapter para Proveedores de LLM
class ProveedorLLM(ABC):
    @abstractmethod
    def completar(self, prompt: str) -> str:
        pass

class ClaudeAdapter(ProveedorLLM):
    def __init__(self, sdk_externo):
        self._sdk = sdk_externo

    def completar(self, prompt: str) -> str:
        return self._sdk.consultar_llm(prompt)

# 2. Decorator: Caché de respuestas
class ConCacheLLM(ProveedorLLM):
    def __init__(self, interno: ProveedorLLM):
        self._interno = interno
        self._cache = {}

    def completar(self, prompt: str) -> str:
        if prompt not in self._cache:
            self._cache[prompt] = self._interno.completar(prompt)
        return self._cache[prompt]

# 3. Chain of Responsibility: Guardrails de salida
class Guardrail(ABC):
    def __init__(self, siguiente=None):
        self._siguiente = siguiente

    def validar(self, texto: str) -> str:
        texto_validado = self._aplicar(texto)
        if self._siguiente:
            return self._siguiente.validar(texto_validado)
        return texto_validado

    @abstractmethod
    def _aplicar(self, texto: str) -> str:
        pass

class SinPreciosGuardrail(Guardrail):
    def _aplicar(self, texto: str) -> str:
        if "S/" in texto or "soles" in texto.lower():
            raise ValueError("Guardrail IA: La respuesta contiene precios no permitidos")
        return texto

class SinAfirmacionesProhibidasGuardrail(Guardrail):
    PROHIBIDAS = ["orgánico certificado", "garantizado", "cura"]

    def _aplicar(self, texto: str) -> str:
        for p in self.PROHIBIDAS:
            if p in texto.lower():
                raise ValueError(f"Guardrail IA: Afirmación prohibida '{p}'")
        return texto

class GeneradorDescripciones:
    def __init__(self, proveedor: ProveedorLLM, guardrail: Guardrail):
        self.proveedor = proveedor
        self.guardrail = guardrail

    def normalizar(self, producto_raw: str) -> str:
        respuesta_raw = self.proveedor.completar(f"Normalizar: {producto_raw}")
        return self.guardrail.validar(respuesta_raw)
