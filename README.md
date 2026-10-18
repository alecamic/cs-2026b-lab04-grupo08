# San Camilo en Línea - Laboratorio 04, 05 y 06
**Asignatura:** Construcción de Software (EPIS-UNSA - 2026B)[cite: 43]

## Integrantes
- **Grupo 08**: Alejandra Choque (Redactora de ADRs, Diagramadora y Verificadora de IA)

---

## Caso Asignado
**Caso 07: San Camilo en Línea**  
Plataforma web/móvil para realizar pedidos a múltiples puestos del Mercado San Camilo de Arequipa, ofreciendo opciones de recojo o delivery[cite: 58]. El atributo de calidad más crítico es la **Capacidad de Interacción (Usabilidad)**, asegurando que los comerciantes con poca experiencia digital puedan publicar productos en 3 toques o menos desde sus celulares de gama baja.

---

## Arquitectura Elegida (Lab 04)
Elegimos un **Monolito Modular con Frontend PWA**[cite: 50]. A continuación se muestra la vista de componentes principales:

```mermaid
flowchart TB
    CL["Cliente (PWA Web)"]
    COM["Comerciante (PWA Simplificada)"]
    REP["Repartidor (App Móvil / PWA)"]

    subgraph APP ["San Camilo en Línea - Monolito Modular"]
        API["Capa de Presentación: API REST + PWA"]
        M1["Módulo Catálogo y Puestos"]
        M2["Módulo Pedidos Multipuesto"]
        M3["Módulo Pagos"]
        M4["Módulo Notificaciones"]
        INF["Capa de Infraestructura"]
    end

    DB[("PostgreSQL")]
    YP["Pasarela Yape / Plin"]
    WA["WhatsApp Business API"]

    CL & COM & REP --> API
    API --> M1 & M2 & M3 & M4
    M1 & M2 & M3 & M4 --> INF
    INF --> DB
    INF --> YP
    INF --> WA
