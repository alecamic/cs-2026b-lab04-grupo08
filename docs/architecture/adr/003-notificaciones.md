# ADR-003: Uso de PWA e integración con WhatsApp para avisos
Estado: Aceptado
Fecha: 2026-10-03
Decisores: Integrantes del grupo 08

## Contexto
El driver QA-01 pide que comerciantes con poca experiencia digital reciban y publiquen pedidos fácil en celulares de gama baja con internet lento. Además, los comerciantes ya saben usar WhatsApp diariamente.

## Alternativas consideradas
1. Desarrollar una App Nativa Android/iOS.
2. Aplicación Web tradicional con alertas por correo.
3. Aplicación Web Progresiva (PWA) + Notificaciones directas a WhatsApp (Elegido).

## Decisión
Usaremos una PWA para que el comerciante instale la app directamente desde el navegador sin pasar por la Play Store, y enviaremos las alertas de nuevos pedidos a su WhatsApp mediante la API de WhatsApp Business.

## Consecuencias
Positivas:
- Carga súper rápida en redes 3G y funciona casi sin consumir almacenamiento del celular gama baja.
- El comerciante responde rápido porque recibe el pedido directo en su WhatsApp habitual.

Negativas / Riesgos:
- Dependemos de la disponibilidad y tarifas del servicio externo de WhatsApp.
