from diagrams import Diagram, Cluster, Edge
from diagrams.generic.device import Mobile
from diagrams.onprem.network import Nginx
from diagrams.programming.framework import Django
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.inmemory import Redis
from diagrams.onprem.queue import Celery
from diagrams.onprem.network import Internet

graph_attr = {"fontsize": "18", "bgcolor": "white", "pad": "0.5"}

with Diagram("San Camilo en Línea - Vista de Despliegue", filename="docs/architecture/diagramas/img/despliegue", show=False, direction="LR", graph_attr=graph_attr):
    
    comerciante = Mobile("Comerciante\n(PWA Gama Baja)")
    cliente = Mobile("Cliente\n(Navegador/PWA)")
    
    with Cluster("Servidor VPS Cloud (Económico)"):
        proxy = Nginx("Nginx Proxy\n(HTTPS)")
        
        with Cluster("Monolito Modular"):
            app = Django("Django API\n(4 Módulos)")
            worker = Celery("Tareas Asíncronas")
        
        cache = Redis("Redis\n(Cola Notificaciones)")
        db = PostgreSQL("PostgreSQL\n(Esquemas Módulos)")
        
        [comerciante, cliente] >> proxy >> app
        app >> db
        app >> Edge(label="encola aviso") >> cache >> worker

    worker >> Edge(label="API REST", style="dashed") >> Internet("WhatsApp API\n(Confirmaciones)")
