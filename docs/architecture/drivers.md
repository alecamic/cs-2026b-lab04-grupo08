# Drivers arquitectónicos - San Camilo en Línea

## 1. Requisitos funcionales clave
| ID | Requisito | Actor | Prioridad |
|---|---|---|---|
| RF-01 | Explorar catálogo organizado por puestos del Mercado San Camilo | Cliente | Alta |
| RF-02 | Armar un pedido consolidado comprando a múltiples puestos a la vez | Cliente | Alta |
| RF-03 | Realizar el pago del pedido mediante la pasarela de Yape | Cliente | Alta |
| RF-04 | Enviar confirmación e itinerario del pedido por WhatsApp | Comerciante / Repartidor | Alta |
| RF-05 | Publicar o actualizar productos en el catálogo en menos de 3 toques | Comerciante | Alta |

## 2. Atributos de calidad (ordenados por prioridad)
1. **Capacidad de interacción (Usabilidad):** Es la más crítica de nuestro sistema. Los comerciantes del mercado tienen muy poca experiencia digital y usan teléfonos de gama baja, por lo que la interfaz para publicar productos debe ser hiper simple.
2. **Modificabilidad:** Necesitamos añadir nuevas reglas de comisión o nuevas pasarelas de pago más adelante sin romper la aplicación.
3. **Disponibilidad:** El sistema debe responder bien en las horas punta de compras de mercado (10:00 a. m. - 1:00 p. m.).
4. **Rendimiento:** Las pantallas deben cargar rápido incluso con conexiones 3G débiles dentro del mercado.

## 3. Restricciones
| ID | Tipo | Restricción |
|---|---|---|
| R-01 | Plazo | Debemos lanzar el MVP a producción en máximo 1 mes. |
| R-02 | Equipo | Somos un equipo reducido de estudiantes con experiencia en tecnologías web básicas (Python/Django, HTML/JS). |
| R-03 | Presupuesto | Presupuesto muy bajo. Solo podemos gastar en un VPS económico. |
| R-04 | Tecnología | Los comerciantes usan celulares gama baja con pantallas pequeñas y conexión móvil 3G e intermitente. |

## 4. Escenarios de atributos de calidad
| ID | Atributo | Fuente | Estímulo | Entorno | Artefacto | Respuesta | Medida |
|---|---|---|---|---|---|---|---|
| QA-01 | Capacidad de interacción | Comerciante de fruta del mercado | Desea publicar un nuevo producto con foto y precio | Desde su puesto con celular gama baja y señal 3G | Interfaz PWA del comerciante | Permite completar la publicación guardando datos localmente si falla la red | Publicación en ≤ 3 toques |
| QA-02 | Modificabilidad | Desarrolladores del equipo | Solicitud para agregar cobro por tarjeta además de Yape | Durante mantenimiento planificado | Módulo de Pagos | Se agrega el nuevo adaptador de pago sin modificar los módulos de puestos ni pedidos | ≤ 2 días-persona de trabajo |
| QA-03 | Rendimiento | 200 clientes en simultáneo | Consultan catálogos de varios puestos entre 11:00 a.m. y 12:00 p.m. | Hora pico de compra del almuerzo | Módulo de Catálogo / API REST | Devuelve la lista de productos optimizada con imágenes comprimidas | p95 del tiempo de respuesta ≤ 2.5 s |
