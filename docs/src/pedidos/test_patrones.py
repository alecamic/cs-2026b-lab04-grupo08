import pytest
from src.pedidos.servicio import ServicioPedidos, Linea, Pedido
from src.pedidos.pagos import FabricaPasarelas, PasarelaPago, ResultadoPago
from src.pedidos.ia import ProveedorLLM, SinPreciosGuardrail, SinAfirmacionesProhibidasGuardrail

def test_open_closed_nuevo_medio_sin_modificar_servicio():
    class PagoEfectivo(PasarelaPago):
        def cobrar(self, monto, celular):
            return ResultadoPago(True, "EFECTIVO-001")

    s = ServicioPedidos()
    s.fabrica.registrar("EFECTIVO", lambda: PagoEfectivo())
    
    p = Pedido(1, "959000111", [Linea("papa", 2, 5.0)])
    assert s.confirmar_y_pagar(p, "EFECTIVO") == "PAGADO"

def test_guardrail_bloquea_precios_inventados():
    g = SinPreciosGuardrail()
    with pytest.raises(ValueError, match="precios no permitidos"):
        g.validar("papa amarilla S/ 3.50")

def test_guardrail_bloquea_afirmaciones_prohibidas():
    g = SinAfirmacionesProhibidasGuardrail()
    with pytest.raises(ValueError, match="Afirmación prohibida"):
        g.validar("palta fuerte orgánica garantizada")
