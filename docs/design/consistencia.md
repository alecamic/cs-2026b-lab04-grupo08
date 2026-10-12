# Reporte de Consistencia C1-C5

| Regla | Elemento analizado | Hallazgo de la IA | Verificación del Equipo / Decisión |
| :--- | :--- | :--- | :--- |
| **C1** | Mensaje `notificarComerciante` | La interfaz `NotificadorWhatsApp` no poseía el método expuesto en la secuencia. | **Correcto**: Se añadió el método `notificarComerciante()` a la interfaz. |
| **C2** | Transición `PREPARANDO -> LISTO` | Provocada por la operación `marcarListo()`. | **Correcto**: Existe coincidencia exacta en la clase `PedidoPuesto`. |
| **C3** | Multiplicidad `PedidoPuesto` - `LineaPedido` | Se sugirió que un pedido podía existir sin líneas. | **Correcto**: Se corrigió a `1..*` (al menos una línea por puesto). |
| **C4** | Dependencia `pagos -> pedidos` | La IA reportó ciclo entre el paquete `pagos` y `pedidos`. | **Falso Positivo**: La IA interpretó erróneamente el sentido de la flecha `PED ..> PAG`. `pagos` no depende de `pedidos`. Se rechaza el hallazgo. |
| **C5** | Nombres del Dominio | Uso de términos neutros como `Item` en lugar de `PedidoPuesto`. | **Correcto**: Se renombró para reflejar el lenguaje ubícuo del Mercado San Camilo. |
