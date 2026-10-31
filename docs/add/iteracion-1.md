# Iteración 1: Rendimiento en el Catálogo Multi-Mercado (QA-01)

## 1. Objetivo
Garantizar la latencia máxima permitida en horas de alta demanda para el escenario de crecimiento multi-mercado.
* **Escenario / Atributo:** QA-01 (Rendimiento).
* **Métrica objetivo:** Carga de 50 000 consultas/hora en hora punta con un tiempo de respuesta $p95 \le 1.5\text{ s}$.

## 2. Conceptos de Diseño Evaluados

### Opción 1: Arquitectura de Microservicios por Mercado (Rechazado)
* **Descripción:** Desplegar una instancia independiente de API y base de datos por cada mercado (San Camilo, Altiplano, Río Seco).
* **Motivo de rechazo:** Exceso de costos de infraestructura y alta complejidad operativa para el equipo actual, superando los recursos disponibles en el VPS único.

### Opción 2: Monolito Modular con Índice DB + Cache Redis (Aceptado)
* **Descripción:** Implementación de índices compuestos en PostgreSQL combinados con una capa de almacenamiento en caché en Redis con TTL de 30 segundos para las consultas del catálogo.
* **Resultado / Justificación:** En las pruebas de simulación $M/G/c$, el tiempo de respuesta $p95$ pasa de **16.8 s** (sin optimización) a **122 ms**, cumpliendo holgadamente con el presupuesto de latencia de $1.5\text{ s}$.

## 3. Decisiones Asociadas
* Creación de `docs/architecture/adr/006-cache-catalogo.md`.
