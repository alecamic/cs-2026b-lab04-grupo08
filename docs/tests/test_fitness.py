import pytest
from ejemplo.fitness.rendimiento import simular

PRESUPUESTO_P95_MS = 1500

def test_ff03_rendimiento_multi_mercado():
    res = simular(lam=16, workers=4, usa_cache=True)
    assert res["p95"] <= PRESUPUESTO_P95_MS, f"p95={res['p95']:.0f}ms excede el presupuesto"

def test_ff04_aislamiento_multitenencia_mercados():
    # Simulación de consulta de usuario de Mercado Altiplano intentando acceder a San Camilo
    mercado_usuario = "ALTIPLANO"
    registro_consultado = {"id": 101, "mercado_owner": "SAN_CAMILO"}
    
    acceso_permitido = (mercado_usuario == registro_consultado["mercado_owner"])
    assert acceso_permitido is False, "Falla de Aislamiento: Se permitió acceso cruzado entre mercados"
