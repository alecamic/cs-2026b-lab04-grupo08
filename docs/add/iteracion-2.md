# Iteración 2: Aislamiento Multitenencia entre Mercados (QA-04)

## 1. Objetivo
Asegurar el aislamiento absoluto de la información comercial entre los distintos mercados que comparten la plataforma.
* **Escenario / Atributo:** QA-04 (Seguridad y Aislamiento).
* **Métrica objetivo:** 0 accesos no autorizados a datos entre comerciantes de San Camilo, Altiplano y Río Seco.

## 2. Conceptos de Diseño Evaluados

### Opción 1: Base de Datos Separada por Mercado (Rechazado)
* **Descripción:** Crear esquemas o bases de datos físicas independientes para cada inquilino (tenant).
* **Motivo de rechazo:** Sobrecosto y sobrecarga en la administración de recursos dentro del VPS único asignado al proyecto.

### Opción 2: Columna `mercado_id` + Row-Level Security (RLS) + Claim JWT (Aceptado)
* **Descripción:** Uso de una base de datos compartida con la columna `mercado_id` en las tablas multitenant. Se aplica Row-Level Security (RLS) a nivel de PostgreSQL y se valida la identidad mediante el `claim` del `mercado_id` codificado en el token JWT del usuario.
* **Resultado / Justificación:** Garantiza aislamiento a nivel de motor de base de datos sin requerir infraestructura adicional.

## 3. Decisiones Asociadas
* Creación de `docs/architecture/adr/008-multitenencia-rls.md`.
