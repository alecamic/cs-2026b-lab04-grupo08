# Bitácora de Interacciones con IA

| N° | Fecha | Herramienta | Prompt Resume | Propuesta IA | Verificación y Decisión |
| :---: | :---: | :---: | :--- | :--- | :--- |
| 1 | 06/10/2026 | ChatGPT / Claude | Promt para diagrama de clases de San Camilo | Generó clases con tarjetas de crédito | **Rechazado**: En San Camilo solo se usa Yape/Plin. Se eliminó pago con tarjeta[cite: 23]. |
| 2 | 06/10/2026 | ChatGPT / Claude | Definir relaciones entre Pedido y Puestos | Propuso asociación simple | **Corregido**: Se cambió a composición `1` a `1..*` con `PedidoPuesto`. |
| 3 | 07/10/2026 | ChatGPT / Claude | Generar código esqueleto Python 3.10 | Generó dataclasses y Enum | **Aceptado**: Código integrado en `src/pedidos/dominio.py`. |
| 4 | 07/10/2026 | ChatGPT / Claude | Auditar consistencia C1-C5 | Detectó falta de método en puerto notificador | **Aceptado**: Se añadió el método al puerto `NotificadorWhatsApp`. |
| 5 | 07/10/2026 | ChatGPT / Claude | Revisión de dependencias de paquetes | Afirmó que existía dependencia cíclica | **Rechazado**: Falso positivo en lectura de flechas PlantUML. |
