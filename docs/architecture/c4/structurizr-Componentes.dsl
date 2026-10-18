workspace "San Camilo en Línea - Componentes" "Vista Nivel 3" {

    !identifiers hierarchical

    model {
        sancamilo = softwareSystem "San Camilo en Línea" "Plataforma de comercio electrónico." {
            pwa = container "Aplicación Web Progresiva" "Interfaz web y móvil para usuarios." "React" "Web Browser"
            
            api = container "API San Camilo" "Monolito modular de backend." "Django REST Framework" {
                catalogo = component "Módulo Catálogo" "Gestión de puestos, productos y reservas de stock." "Django app"
                pedidos = component "Módulo Pedidos" "Gestión del carrito unificado y ciclo de vida del pedido." "Django app"
                pagos = component "Módulo Pagos" "Procesa transacciones con PasarelaPago." "Django app"
                notificaciones = component "Módulo Notificaciones" "Genera avisos y gestiona cola de mensajes." "Django app"
                despacho = component "Módulo Despacho" "Coordinación de acopio y entrega final." "Django app"
            }
            
            db = container "Base de Datos" "Persistencia relacional." "PostgreSQL 16" "Database"
            cola = container "Cola y Caché" "Gestión de colas y eventos." "Redis" "Queue"
        }

        pasarela = softwareSystem "Pasarela Yape / Plin" "Procesador de pagos." "Externo"

        sancamilo.pwa -> sancamilo.api.catalogo "Consulta catálogo y puestos" "HTTPS/JSON"
        sancamilo.pwa -> sancamilo.api.pedidos "Crea y confirma pedidos" "HTTPS/JSON"
        sancamilo.pwa -> sancamilo.api.despacho "Consulta estado de entrega" "HTTPS/JSON"

        sancamilo.api.pedidos -> sancamilo.api.catalogo "Reserva stock en puestos"
        sancamilo.api.pedidos -> sancamilo.api.pagos "Solicita procesamiento de pago"
        sancamilo.api.pedidos -> sancamilo.api.notificaciones "Pide notificar cambio de estado"
        sancamilo.api.despacho -> sancamilo.api.pedidos "Consulta pedidos listos para acopio"
        
        sancamilo.api.pagos -> pasarela "Realiza el cobro unificado" "HTTPS/JSON"
        sancamilo.api.notificaciones -> sancamilo.cola "Encola mensajes para WhatsApp" "Redis protocol"
        
        sancamilo.api.catalogo -> sancamilo.db "Lee y escribe" "SQL"
        sancamilo.api.pedidos -> sancamilo.db "Lee y escribe" "SQL"
    }

    views {
        component sancamilo.api "Componentes" "Nivel 3: Componentes internos de la API San Camilo." {
            include *
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
            element "Database" {
                shape cylinder
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
