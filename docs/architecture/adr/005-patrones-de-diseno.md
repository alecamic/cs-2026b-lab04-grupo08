# ADR-005: Refactorización a Patrones de Diseño GoF en el Módulo Pedidos

**Estado:** Aceptado (24/10/2026)[cite: 65, 79]

## Contexto
El método `confirmar_y_pagar()` presentaba una complejidad ciclomática de 15[cite: 70, 79]. Agregar nuevos medios de pago o integrar funciones de IA no deterministas obligaba a modificar directamente el servicio central, violando el principio Abierto/Cerrado[cite: 67, 79].

## Decisión
1. Implementar **Strategy + Adapter + Factory** para el procesamiento desacoplado de pasarelas de pago[cite: 71, 79].
2. Encapsular la lógica de reintentos mediante **Decorator**[cite: 71, 79].
3. Modelar el ciclo de vida del pedido con el patrón **State** (derivado del Lab 05)[cite: 73, 79].
4. Emitir avisos mediante **Observer**[cite: 74, 79].
5. Aislar la IA detrás de **Strategy/Adapter**, **Decorator (Caché)** y **Chain of Responsibility (Guardrails)**[cite: 75, 76, 79].

## Consecuencias
- **Positivas:** Reducción de la complejidad máxima a 2; desacoplamiento total de SDKs externos; aislamiento de fallas de IA[cite: 78, 79].
- **Negativas:** Incremento en las líneas de código (de 81 a 207) e indirección de archivos[cite: 78, 79].
