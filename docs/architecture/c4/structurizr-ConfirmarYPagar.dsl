workspace "San Camilo en Línea - Vista Dinámica" "Confirmar y Pagar" {

    !identifiers hierarchical

    model {
        sancamilo = softwareSystem "San Camilo en Línea" "Plataforma de comercio electrónico." {
            pwa = container "Aplicación Web Progresiva" "Interfaz cliente." "React" "Web Browser"
            
            api = container "API San Camilo" "Backend monolítico modular." "Django REST Framework" {
                catalogo = component "Módulo Catálogo" "Gestión de stock." "Django app"
                pedidos = component "Módulo Pedidos" "Gestión de pedidos." "Django app"
                pagos = component "Módulo Pagos" "Gestión de pagos." "Django app"
                notificaciones = component "Módulo Notificaciones" "Generación de notificaciones." "Django app"
            }
            
            cola = container "Cola y Caché" "Gestión de colas de eventos." "Redis" "Queue"
        }

        pasarela = softwareSystem "Pasarela Yape / Plin" "Procesador externo de pagos." "Externo"

        sancamilo.pwa -> sancamilo.api.pedidos "POST /pedidos/{id}/pago"
        sancamilo.api.pedidos -> sancamilo.api.catalogo "Reserva stock en puestos"
        sancamilo.api.pedidos -> sancamilo.api.pagos "Solicita procesamiento del pago"
        sancamilo.api.pagos -> pasarela "Cobra importe unificado"
        sancamilo.api.pedidos -> sancamilo.api.notificaciones "Pide notificar pedido pagado"
        sancamilo.api.notificaciones -> sancamilo.cola "Encola mensaje para WhatsApp"
    }

    views {
        dynamic sancamilo.api "ConfirmarYPagar" "Flujo dinámico de confirmación y pago unificado de un pedido multipuesto." {
            sancamilo.pwa -> sancamilo.api.pedidos "1. POST /pedidos/{id}/pago"
            sancamilo.api.pedidos -> sancamilo.api.catalogo "2. Reserva stock en puestos"
            sancamilo.api.pedidos -> sancamilo.api.pagos "3. Solicita procesamiento del pago"
            sancamilo.api.pagos -> pasarela "4. Cobra importe unificado"
            sancamilo.api.pedidos -> sancamilo.api.notificaciones "5. Pide notificar pedido pagado"
            sancamilo.api.notificaciones -> sancamilo.cola "6. Encola mensaje para WhatsApp"
            autolayout lr
        }

        styles {
            element "Software System" {
                background #1168BD
                color #ffffff
            }
            element "Externo" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438DD5
                color #ffffff
            }
            element "Component" {
                background #85BBF0
                color #000000
            }
            element "Queue" {
                shape pipe
            }
            element "Web Browser" {
                shape WebBrowser
            }
        }
    }
}
