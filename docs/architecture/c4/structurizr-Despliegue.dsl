workspace "San Camilo en Línea - Despliegue" "Vista de Despliegue en Producción" {

    !identifiers hierarchical

    model {
        sancamilo = softwareSystem "San Camilo en Línea" "Plataforma de comercio electrónico." {
            pwa = container "Aplicación Web Progresiva" "Interfaz cliente." "React + Service Worker" "Web Browser"
            api = container "API San Camilo" "Monolito modular de backend." "Python / Django REST"
            worker = container "Worker de Tareas" "Procesador de notificaciones." "Celery"
            db = container "Base de Datos" "Persistencia PostgreSQL." "PostgreSQL 16" "Database"
            cola = container "Cola y Caché" "Gestión de tareas y caché." "Redis" "Queue"
        }

        sancamilo.pwa -> sancamilo.api "Llama a endpoints REST" "HTTPS/JSON"
        sancamilo.api -> sancamilo.db "Lee y escribe datos" "SQL/TCP"
        sancamilo.api -> sancamilo.cola "Encola tareas y lee caché" "Redis protocol"
        sancamilo.worker -> sancamilo.cola "Consume tareas" "Redis protocol"

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
        deployment sancamilo produccion "Despliegue" "Vista de despliegue en el entorno de producción (MVP)." {
            include *
            autolayout lr
        }

        styles {
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
            element "WebBrowser" {
                shape WebBrowser
            }
        }
    }
}
