import importlib
import pytest

@pytest.fixture(params=["src.pedidos.antes.servicio", "src.pedidos.servicio"])
def m(request):
    return importlib.import_module(request.param)

def crear_pedido(m, precio=3.50, cantidad=20):
    linea = m.Linea("papa amarila", cantidad, precio)
    return m.Pedido(id=1, celular="959000111", lineas=[linea])

def test_pago_yape_aprobado_publica_eventos(m):
    s = m.ServicioPedidos()
    assert s.confirmar_y_pagar(crear_pedido(m), "YAPE") == "PAGADO"
    assert s.eventos == ["whatsapp: 959000111: Pedido 1 pagado", "reporte: 1: 70.00"]

def test_pago_plin_aprobado(m):
    s = m.ServicioPedidos()
    assert s.confirmar_y_pagar(crear_pedido(m), "PLIN") == "PAGADO"

def test_reintenta_tras_dos_timeouts_yape(m):
    from src.pedidos.externos import YapeSDK
    yape = YapeSDK(fallas=2)
    s = m.ServicioPedidos(yape=yape)
    assert s.confirmar_y_pagar(crear_pedido(m), "YAPE") == "PAGADO"
    assert yape.llamadas == 3

def test_monto_sobre_limite_se_cancela(m):
    s = m.ServicioPedidos()
    p = crear_pedido(m, precio=100.0, cantidad=10) # 1000 soles
    assert s.confirmar_y_pagar(p, "YAPE") == "CANCELADO"
    assert s.eventos == []

def test_pedido_sin_lineas_lanza_excepcion(m):
    s = m.ServicioPedidos()
    p = m.Pedido(id=2, celular="959000111", lineas=[])
    with pytest.raises(ValueError, match="El pedido no tiene líneas"):
        s.confirmar_y_pagar(p, "YAPE")

def test_transicion_invalidas_desde_pagado(m):
    s = m.ServicioPedidos()
    p = crear_pedido(m)
    s.confirmar_y_pagar(p, "YAPE")
    with pytest.raises(ValueError):
        s.confirmar_y_pagar(p, "YAPE")

def test_transicion_invalidas_desde_cancelado(m):
    s = m.ServicioPedidos()
    p = crear_pedido(m, precio=100.0, cantidad=10)
    s.confirmar_y_pagar(p, "YAPE")
    with pytest.raises(ValueError):
        s.confirmar_y_pagar(p, "YAPE")

def test_medio_no_soportado(m):
    s = m.ServicioPedidos()
    with pytest.raises(ValueError, match="Medio de pago no soportado"):
        s.confirmar_y_pagar(crear_pedido(m), "BITCOIN")
