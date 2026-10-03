# ADR-002: Uso de PostgreSQL con esquemas separados por módulo
Estado: Aceptado
Fecha: 2026-10-03
Decisores: Integrantes del grupo 08

## Contexto
Necesitamos almacenar transacciones de compras, catálogos de productos y pagos de forma confiable. El driver QA-02 exige modificabilidad y queremos evitar que las tablas de pedidos se mezclen de forma caótica con los datos de los comerciantes.

## Alternativas consideradas
1. MongoDB (Base de datos documental)
2. PostgreSQL con un esquema relacional unificado
3. PostgreSQL con esquemas aislados por módulo (Elegido)

## Decisión
Usaremos PostgreSQL definiendo esquemas independientes para cada módulo (`catalogo`, `pedidos`, `pagos`). Esto evita relaciones directas entre módulos a nivel de base de datos.

## Consecuencias
Positivas:
- Garantizamos la integridad de los datos financieros de las compras.
- Facilita la futura migración de algún módulo a un microservicio independiente si el sistema crece.

Negativas / Riesgos:
- No podemos hacer JOINs directos entre tablas de distintos módulos; la comunicación debe ser por código.
