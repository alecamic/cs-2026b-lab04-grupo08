# Auditoría de Calidad del Modelo C4

| Vista | Pregunta de la Lista de Revisión | Cumple | Evidencia / Hallazgo | Corrección Aplicada |
| :--- | :--- | :---: | :--- | :--- |
| Contexto | ¿Cada elemento y relación describe su intención? | Sí | Las flechas indican "Hace pedidos y paga" y "Solicita cobros". | Ninguna, cumple con las reglas C4. |
| Contenedores | ¿Se especifican las tecnologías y protocolos exactos? | Sí | Se indica `HTTPS/JSON`, `SQL/TCP` y `Redis protocol`. | Ninguna, especificación completa. |
| Componentes | ¿Hay dependencias cíclicas entre componentes? | Sí | Todos los módulos dependen de Pedidos, sin ciclos. | Coincide con `paquetes.puml` del Lab 05. |
| Contexto | **[Falso Positivo de IA]** "Faltan protocolos en las relaciones con las Personas". | No | La IA reportó error por no tener protocolo entre el Comprador y el Sistema Contexto. | **Falso Positivo Descartado:** En el nivel 1 de contexto no se exigen protocolos tecnológicos para los usuarios humanos. |
| Despliegue | ¿Cada nodo especifica su infraestructura y SO? | Sí | Se indica VPS Ubuntu 24.04 LTS, Docker Engine 27 y Android/iOS. | Ninguna, cumple los requisitos. |
