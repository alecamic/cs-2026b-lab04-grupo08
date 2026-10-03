# Bitácora de uso de IA - San Camilo en Línea

| # | Fecha | Herramienta | Prompt (resumen) | Qué propuso la IA | Qué verificamos o corregimos | Decisión |
|---|---|---|---|---|---|---|
| 1 | 2026-10-01 | ChatGPT | Propuesta de 3 estilos arquitectónicos para el caso San Camilo en Línea | Sugirió Microservicios con Kubernetes y RabbitMQ como la mejor opción. | Verificamos que era absurdo para un equipo pequeño con 1 mes de plazo (R-01) y bajo presupuesto (R-03). | Rechazada |
| 2 | 2026-10-01 | ChatGPT | Crítica adversarial contra el Monolito Modular | Indicó riesgo de lentitud con imágenes pesadas subidas por comerciantes. | Corregimos agregando compresión automática de fotos en el frontend PWA antes de subir. | Corregida |
| 3 | 2026-10-02 | Claude | Generación de código Mermaid de la arquitectura elegida | Generó el diagrama completo pero incluyó conexiones directas entre módulos sin pasar por la capa de infraestructura. | Corregimos el código Mermaid conectando los módulos a la capa de infraestructura. | Corregida |
| 4 | 2026-10-02 | Claude | Borrador para el ADR-003 de notificaciones por WhatsApp | Propuso enviar SMS tradicionales como alternativa de respaldo. | Lo rechazamos porque los SMS tienen costo extra alto por envío y no se ajusta al presupuesto. | Corregida |
| 5 | 2026-10-03 | Gemini | Script de Python Diagrams para la vista de despliegue | Código inicial para representar la infraestructura. | Corregimos la ruta de salida de las imágenes para que se guarde dentro de `diagramas/img/`. | Corregida |

## Anexo: Prompts completos

### Prompt 1 - Propuesta de Alternativas
> "Actúa como arquitecto de software senior. Diseña la arquitectura para 'San Camilo en Línea', una plataforma de pedidos para el Mercado San Camilo en Arequipa. Comerciantes publican desde celulares de gama baja en ≤ 3 toques. Restricciones: MVP en 1 mes, presupuesto muy bajo, equipo de estudiantes. Propón 3 estilos arquitectónicos en tabla comparativa."

### Prompt 2 - Crítica Adversarial
> "Actúa como abogado del diablo. Critica duramente la arquitectura Monolito Modular con PWA para San Camilo en Línea. ¿Qué puede fallar cuando los comerciantes suban fotos desde el mercado con señal 3G débil? Dame los riesgos y tácticas de mitigación."
