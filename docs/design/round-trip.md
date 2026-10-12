# Reporte de Round-Trip (Ingeniería Directa e Inversa)

## Comparación entre Diagrama de Diseño y Código Generado

| Diferencia observada | Causa | Acción tomada |
| :--- | :--- | :--- |
| Composición `PedidoPuesto` - `LineaPedido` figura como asociación de lista simple en ingeniería inversa. | `pyreverse` no infiere automáticamente composiciones fuertes desde tipos `list[...]`. | Ninguna (limitación conocida de la herramienta de ingeniería inversa). Se mantiene en el diseño[cite: 32]. |
| Nombres de métodos cambiaron de camelCase (`aceptarPreparacion`) a snake_case (`aceptar_preparacion`). | Convención de nombrado PEP 8 en lenguaje Python. | Aceptable. Se documenta la equivalencia entre ambos estándares (C5)[cite: 32]. |
| Ausencia de multiplicidades numéricas en el diagrama por ingeniería inversa. | El lenguaje de código fuente no expresa multiplicidades explícitamente en el sistema de tipos. | Se agregan validaciones en código (`ValueError`) para garantizar reglas de multiplicidad[cite: 32]. |
