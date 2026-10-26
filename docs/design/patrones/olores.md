# Tabla de Olores de Código y Patrones Propuestos

| Olor detectado | Patrón propuesto por IA | Principio SOLID | Decisión del equipo |
| :--- | :--- | :--- | :--- |
| `if/elif` según el medio de pago en `confirmar_y_pagar` | Strategy + Factory | Abierto/Cerrado (OCP) | **Aceptado**: Permite agregar nuevos medios de pago sin modificar el servicio. |
| El servicio conoce los métodos específicos de cada SDK (`realizar_cobro` vs `charge`) | Adapter | Inversión de Dependencias (DIP) | **Aceptado**: Traduce SDKs heterogéneos a una interfaz común `PasarelaPago`. |
| Bloques de reintentos por `TimeoutError` duplicados para Yape y Plin | Decorator | Responsabilidad Única (SRP) | **Aceptado**: Encapsula la lógica de reintentos en `ConReintentos`. |
| Condicionales anidados sobre `pedido.estado` | State | Sustitución de Liskov (LSP) | **Aceptado**: Implementa la máquina de estados del Lab 05. |
| Creación explícita de strings de WhatsApp y Reportes dentro del flujo de pago | Observer | Responsabilidad Única (SRP) | **Aceptado**: Desacopla las notificaciones mediante suscriptores de eventos. |
| "FabricaPasarelas debería ser Singleton" | Singleton | Ninguno (Anti-patrón aquí) | **Rechazado**: Introduce estado global e impide inyectar pasarelas simuladas en las pruebas. |
