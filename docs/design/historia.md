# Historia de Usuario - San Camilo en Línea

## HU-07: Pedido a varios puestos con pago único

**Como** comprador del Mercado San Camilo,  
**Quiero** realizar un pedido seleccionando productos de diferentes puestos y realizar un único pago,  
**Para** no tener que hacer múltiples transacciones ni pagar comisiones individuales por cada comerciante.

### Criterios de Aceptación

#### Criterio 1: Confirmación de pago exitoso y distribución
- **Dado** un pedido multipuesto en estado `BORRADOR` con stock disponible en todos los puestos seleccionados,
- **Cuando** el comprador confirma el pedido y completa el pago único a través de la pasarela (Yape/Plin),
- **Entonces** el pedido general pasa al estado `PAGADO`, se generan los subpedidos (`PedidoPuesto`) para cada comerciante en estado `RECIBIDO`, y se notifica automáticamente a cada comerciante por WhatsApp.

#### Criterio 2: Rechazo por pago fallido o falta de stock
- **Dado** un pedido multipuesto confirmado,
- **Cuando** la pasarela rechaza el pago o se agota el tiempo de espera (15 minutos),
- **Entonces** el pedido queda en estado `CANCELADO` y se libera el stock reservado temporalmente en todos los puestos involucrados.
