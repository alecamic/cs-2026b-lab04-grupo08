# ADR-001: Adopción de Monolito Modular para San Camilo en Línea
Estado: Aceptado
Fecha: 2026-10-03
Decisores: Integrantes del grupo 08

## Contexto
Necesitamos construir el MVP en 1 mes (R-01) para el Mercado San Camilo. Es crítico que los comerciantes publiquen productos en 3 toques desde celulares gama baja (QA-01) y no tenemos presupuesto ni equipo para administrar infraestructuras complejas (R-02, R-03).

## Alternativas consideradas
1. Monolito en capas (Puntaje: 3.60)
2. Monolito Modular (Puntaje: 4.10)
3. Microservicios (Puntaje: 3.05)

## Decisión
Decidimos implementar un Monolito Modular usando Django y PostgreSQL. Mantenemos el frontend como una PWA ligera desacoplada por módulos de negocio (Catálogo, Pedidos, Pagos, Notificaciones).

## Consecuencias
Positivas:
- Desarrollo rápido que se ajusta a nuestro plazo de 1 mes.
- Bajos costos de alojamiento (un solo servidor VPS económico).
- Despliegue y mantenimiento sencillos.

Negativas / Riesgos:
- Todo el equipo debe ser disciplinado para no mezclar las dependencias entre módulos.
