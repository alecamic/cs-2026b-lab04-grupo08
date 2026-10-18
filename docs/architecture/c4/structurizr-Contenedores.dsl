workspace "San Camilo en Línea - Contenedores" "Vista Nivel 2" {

    !identifiers hierarchical

    model {
        comprador = person "Comprador" "Cliente que realiza pedidos unificados a varios puestos."
        comerciante = person "Comerciante" "Vendedor de un puesto del Mercado San Camilo."
        repartidor = person "Repartidor" "Encargado de consolidar paquetes y realizar la entrega."

        sancamilo = softwareSystem "San Camilo en Línea" "Plataforma de comercio electrónico con pago único." {
            pwa = container "Aplicación Web Progresiva" "Interfaz para compradores, comerciantes y repartidores." "React + Service Worker" "Web Browser"
            api = container "API San Camilo" "Monolito modular que gestiona la lógica de pedidos multipuesto." "Python / Django REST Framework"
            worker = container "Worker de Tareas" "Procesador asíncrono para notificaciones y reintentos." "Celery"
            db = container "Base de Datos" "Almacenamiento persistente con esquemas aislados por módulo." "PostgreSQL 16" "Database"
            cola = container "Cola y Caché" "Gestor de tareas en segundo plano y caché del catálogo." "Redis" "Queue"
        }

        pasarela = softwareSystem "Pasarela Yape / Plin" "Procesa cobros móviles con confirmación de pago." "Externo"
        whatsapp = softwareSystem "WhatsApp Business API" "Envía alertas de pedidos a comerciantes y compradores." "Externo"

        comprador -> sancamilo.pwa "Usa para comprar" "HTTPS"
        comerciante -> sancamilo.pwa "Usa para recibir avisos" "HTTPS"
        repartidor -> sancamilo.pwa "Usa para despacho" "HTTPS"

        sancamilo.pwa -> sancamilo.api "Llama a endpoints REST" "HTTPS/JSON"
        sancamilo.api -> sancamilo.db "Lee y escribe datos" "SQL/TCP"
        sancamilo.api -> sancamilo.cola "Encola tareas y lee caché" "Redis protocol"
        sancamilo.worker -> sancamilo.cola "Consume tareas pendientes" "Redis protocol"
        sancamilo.worker -> whatsapp "Envía mensajes automatizados" "HTTPS/JSON"
        sancamilo.api -> pasarela "Solicita cobros" "HTTPS/JSON"
    }

    views {
        container sancamilo "Contenedores" "Nivel 2: Diagrama de Contenedores de San Camilo en Línea." {
            include *
            autolayout lr
        }

        styles {
            element "Person" {
                shape person
                background #08427B
                color #ffffff
            }
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
