# Matriz de decisión - San Camilo en Línea

## Alternativas de Arquitectura
**A. Monolito en capas:** Estructura clásica en 3 capas (Presentación, Negocio, Datos). Es muy fácil de arrancar, pero todo el código suele acoplarse con el tiempo.
**B. Monolito modular (PWA + Django):** Un único proyecto dividido internamente en módulos claros por dominio (Puestos, Pedidos, Pagos, Notificaciones). Usamos una PWA simple para el frontend.
**C. Microservicios + Broker de eventos:** Separar el sistema en 5 servicios independientes con sus propias bases de datos y comunicación por RabbitMQ.

## Criterios y pesos (Suman 100%)
| Criterio | Peso | Justificación (driver relacionado) |
|---|---|---|
| Tiempo de entrega | 25% | R-01: El MVP debe salir obligatoriamente en 1 mes |
| Capacidad de interacción / Usabilidad | 25% | QA-01: Atributo crítico para comerciantes con gama baja |
| Costo y simplicidad operativa | 20% | R-02 y R-03: Somos pocos desarrolladores y tenemos presupuesto bajo |
| Modificabilidad | 15% | QA-02: Facilidad para cambiar o extender módulos a futuro |
| Escalabilidad | 15% | QA-03: Soportar picos moderados a la hora del almuerzo |

## Matriz de Evaluación (Puntaje 1 al 5)
| Criterio (peso) | Monolito en Capas | Monolito Modular (Elegido) | Microservicios |
|---|---|---|---|
| Tiempo de entrega (25%) | 5 | 4 | 2 |
| Capacidad de interacción (25%) | 3 | 5 | 4 |
| Costo y simplicidad operativa (20%) | 5 | 4 | 1 |
| Modificabilidad (15%) | 2 | 4 | 5 |
| Escalabilidad (15%) | 2 | 3 | 5 |
| **Total ponderado** | **3.60** | **4.10** | **3.05** |

## Conclusión
Elegimos la opción de **Monolito Modular con PWA**, ya que nos da el puntaje más alto (4.10). Nos permite salir a producción en el mes acordado, ofrece una gran experiencia para los comerciantes con celulares viejos mediante PWA y no nos complica la vida con la infraestructura. Consulta los detalles en [ADR-001](adr/001-estilo-arquitectonico.md).
