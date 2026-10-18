workspace "San Camilo en Línea" "Modelo C4 unificado para la plataforma de pedidos multipuesto del Mercado San Camilo." {

    !identifiers hierarchical

    model {
        // Personas
        comprador = person "Comprador" "Cliente que realiza pedidos unificados a varios puestos del mercado."
        comerciante = person "Comerciante" "Vendedor de un puesto del Mercado San Camilo."
        repartidor = person "Repartidor" "Encargado de consolidar los paquetes y llevar el pedido al comprador."

        // Sistema Principal
        sancamilo = softwareSystem "San Camilo en Línea" "Plataforma de comercio electrónico que permite compras multipuesto con pago único." {
            
            pwa = container "Aplicación Web Progresiva" "Interfaz web y móvil para compradores, comerciantes y repartidores." "React + Service Worker" "Web Browser"
            
            api = container "API San Camilo" "Monolito modular que gestiona la lógica del negocio de pedidos multipuesto." "Python / Django REST Framework" {
                catalogo = component "Módulo Catálogo" "Gestión de puestos, catálogo de productos y reservas de stock." "Django app"
                pedidos = component "Módulo Pedidos" "Gestión del carrito unificado y ciclo de vida del pedido." "Django app"
                pagos = component "Módulo Pagos" "Procesa transacciones mediante el puerto PasarelaPago." "Django app"
                notificaciones = component "Módulo Notificaciones" "Genera avisos y los envía a la cola de eventos." "Django app"
                despacho = component "Módulo Despacho" "Coordinación de recojo en puestos y entrega final." "Django app"
            }
            
            worker = container "Worker de Tareas" "Procesador asíncrono para notificaciones y reintentos." "Celery"
            db = container "Base de Datos" "Almacenamiento persistente con esquemas aislados por módulo." "PostgreSQL 16" "Database"
            cola = container "Cola y Caché" "Gestor de tareas en segundo plano y caché de catálogo." "Redis" "Queue"
        }

        // Sistemas Externos
        pasarela = softwareSystem "Pasarela Yape / Plin" "Procesa cobros móviles con confirmación de pago." "Externo"
        whatsapp = softwareSystem "WhatsApp Business API" "Envía alertas de pedidos a comerciantes y compradores." "Externo"

        // Relaciones Nivel 1: Contexto
        comprador -> sancamilo "Realiza pedidos multipuesto y paga una sola vez"
        comerciante -> sancamilo "Gestiona catálogo y confirma productos listos"
        repartidor -> sancamilo "Consulta pedidos consolidados para entrega"
        sancamilo -> pasarela "Solicita cobro unificado" "HTTPS/JSON"
        sancamilo -> whatsapp "Envía notificaciones de pedidos" "HTTPS/JSON"

        // Relaciones Nivel 2: Contenedores
        comprador -> sancamilo.pwa "Usa para comprar" "HTTPS"
        comerciante -> sancamilo.pwa "Usa para recibir avisos" "HTTPS"
        repartidor -> sancamilo.pwa "Usa para despacho" "HTTPS"
        
        sancamilo.pwa -> sancamilo.api "Llama a endpoints REST" "HTTPS/JSON"
        sancamilo.api -> sancamilo.db "Lee y escribe datos" "SQL/TCP"
        sancamilo.api -> sancamilo.cola "Encola tareas y lee caché" "Redis protocol"
        sancamilo.worker -> sancamilo.cola "Consume tareas pendientes" "Redis protocol"
        sancamilo.worker -> whatsapp "Envía mensajes automatizados" "HTTPS/JSON"
        sancamilo.api -> pasarela "Solicita cobros" "HTTPS/JSON"

        // Relaciones Nivel 3: Componentes
        sancamilo.pwa -> sancamilo.api.catalogo "Consulta ofertas y puestos" "HTTPS/JSON"
        sancamilo.pwa -> sancamilo.api.pedidos "Crea y confirma pedidos" "HTTPS/JSON"
        sancamilo.pwa -> sancamilo.api.despacho "Consulta estado de entrega" "HTTPS/JSON"
        
        sancamilo.api.pedidos -> sancamilo.api.catalogo "Reserva stock en puestos"
        sancamilo.api.pedidos -> sancamilo.api.pagos "Solicita procesamiento de pago"
        sancamilo.api.pedidos -> sancamilo.api.notificaciones "Pide notificar cambio de estado"
        sancamilo.api.despacho -> sancamilo.api.pedidos "Consulta pedidos listos"
        sancamilo.api.pagos -> pasarela "Realiza el cobro con la API externa" "HTTPS/JSON"
        sancamilo.api.notificaciones -> sancamilo.cola "Encola mensajes de WhatsApp" "Redis protocol"
        
        sancamilo.api.catalogo -> sancamilo.db "Lee y escribe" "SQL"
        sancamilo.api.pedidos -> sancamilo.db "Lee y escribe" "SQL"

        // Entorno de Despliegue
        produccion = deploymentEnvironment "Producción" {
            deploymentNode "Celular del Cliente / Comerciante" "" "Android / iOS / Navegador Web" {
                containerInstance sancamilo.pwa
            }
            deploymentNode "Servidor Cloud VPS" "" "Ubuntu 24.04 LTS, 2 vCPU, 4 GB RAM" {
                deploymentNode "Docker Compose" "" "Docker Engine 27" {
                    containerInstance sancamilo.api
                    containerInstance sancamilo.worker
                    containerInstance sancamilo.db
                    containerInstance sancamilo.cola
                }
            }
        }
    }

    views {
        systemContext sancamilo "Contexto" "Nivel 1: Diagrama de Contexto de San Camilo en Línea." {
            include *
            autolayout lr
        }

        container sancamilo "Contenedores" "Nivel 2: Diagrama de Contenedores del sistema." {
            include *
            autolayout lr
        }

        component sancamilo.api "Componentes" "Nivel 3: Componentes internos del backend API." {
            include *
            autolayout lr
        }

        dynamic sancamilo.api "ConfirmarYPagar" "Flujo dinámico de confirmación y pago unificado." {
            sancamilo.pwa -> sancamilo.api.pedidos "1. POST /pedidos/{id}/pago"
            sancamilo.api.pedidos -> sancamilo.api.catalogo "2. Reserva stock en puestos"
            sancamilo.api.pedidos -> sancamilo.api.pagos "3. Solicita procesamiento del pago"
            sancamilo.api.pagos -> pasarela "4. Cobra importe unificado"
            sancamilo.api.pedidos -> sancamilo.api.notificaciones "5. Pide notificar pedido pagado"
            sancamilo.api.notificaciones -> sancamilo.cola "6. Encola mensaje para WhatsApp"
            autolayout lr
        }

        deployment sancamilo produccion "Despliegue" "Nivel de Despliegue en Producción (MVP)." {
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
