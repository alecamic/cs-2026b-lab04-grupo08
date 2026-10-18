# Bitácora de Interacciones con la Inteligencia Artificial

- **Interacción 1 (13/10/2026):**
  - **Prompt:** "Genera un borrador en Structurizr DSL para el sistema San Camilo en Línea a partir de este inventario..."
  - **Propuesta IA:** La IA incluyó un contenedor interno llamado "Docker Compose".
  - **Verificación:** Se revisó la guía del Lab 06 (un contenedor Docker es nodo de despliegue, no contenedor C4).
  - **Decisión:** Se movió Docker Compose a la vista de despliegue y se dejó la API como contenedor C4.

- **Interacción 2 (14/10/2026):**
  - **Prompt:** "Agrega los componentes de la API San Camilo en el Structurizr DSL..."
  - **Propuesta IA:** Creó un componente llamado "ServicioNotificacionesKafka".
  - **Verificación:** Se comparó con el ADR-001 y el catálogo de paquetes del Lab 05.
  - **Decisión:** Rechazado. Se reemplazó por el Módulo Notificaciones con Celery y Redis para respetar el MVP.

- **Interacción 3 (14/10/2026):**
  - **Prompt:** "Genera la vista dinámica de confirmación y pago de pedido..."
  - **Propuesta IA:** Creó 8 pasos que saltaban directamente entre la PWA y la base de datos PostgreSQL.
  - **Verificación:** Rompía el principio de encapsulamiento del nivel de componentes.
  - **Decisión:** Se corrigió para que la PWA llame al Módulo de Pedidos y este coordine con Pagos y Catálogo.

- **Interacción 4 (15/10/2026):**
  - **Prompt:** "Audita las 5 vistas C4 usando la lista de revisión oficial de Simon Brown..."
  - **Propuesta IA:** Reportó un error afirmando que las Personas en el Diagrama de Contexto debían llevar el protocolo "HTTPS".
  - **Verificación:** Se revisó la norma c4model.com.
  - **Decisión:** Marcado como falso positivo y descartado. La comunicación humana no requiere protocolo.

- **Interacción 5 (15/10/2026):**
  - **Prompt:** "Redacta un texto explicativo del diagrama de contexto para el presidente de la asociación del mercado en menos de 120 palabras..."
  - **Propuesta IA:** Explicación técnica usando términos como "Endpoints REST", "Worker Celery" y "PostgreSQL".
  - **Verificación:** No era apto para un público no técnico.
  - **Decisión:** Se reescribió eliminando la jerga técnica y enfocándolo en el beneficio comercial del pago único.
