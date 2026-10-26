# Bitácora de Interacciones con la IA

| # | Prompt | Propuesta IA | Verificación | Decisión del Equipo |
| :--- | :--- | :--- | :--- | :--- |
| 1 | "Detecta olores en `antes/servicio.py`..." | Propuso 6 patrones GoF y sugirió convertir la fábrica en Singleton. | Evaluación con `radon` y principios SOLID. | Aceptados 5 patrones. Rechazado Singleton por acoplamiento global. |
| 2 | "Aplica Decorator para reintentos de pago..." | La IA hizo que `ConReintentos` reintentara sobre cualquier fallo (incluso límite excedido). | `test_monto_sobre_limite_se_cancela` falló en las pruebas. | **Corrección aplicada**: Se ajustó para reintentar ÚNICAMENTE ante `TimeoutError`. |
| 3 | "Diseña State para Pedido..." | Propuso usar una tabla de diccionarios con lambdas. | Se comparó con el diagrama de máquina de estados del Lab 05. | Rechazado diccionario; aceptadas subclases con comportamientos específicos. |
| 4 | "Crea guardrails de salida de IA..." | Sugirió llamar a otro LLM para validar las salidas. | Se evaluó latencia y costos para el MVP. | Rechazada llamada extra a IA; se implementaron reglas deterministas con Chain of Responsibility. |
| 5 | "Genera código PlantUML de la arquitectura..." | Diagramó clases con nombres genéricos (`StrategyPatternClass`). | Inspección visual con PlantUML. | Aceptado tras renombrar clases a los nombres reales del código dominio. |
