# Reporte de Métricas y Análisis de Trade-Off

## 1. Tabla Comparativa (radon & SLOC)

| Métrica | Versión Antes | Versión Después |
| :--- | :---: | :---: |
| Complejidad `confirmar_y_pagar` | 15 (Grado C) | 2 (Grado A) |
| Complejidad Promedio del Sistema | 6.5 (Grado B) | 1.67 (Grado A) |
| Líneas de Código (SLOC Total) | 81 líneas | 207 líneas |
| Número de Archivos | 1 archivo | 6 archivos |

## 2. Análisis del Trade-Off (5 a 8 líneas)
El refactor redujo drásticamente la complejidad ciclomática del método principal `confirmar_y_pagar` de 15 a 2, eliminando acoplamientos y previniendo fallas al agregar nuevos medios de pago o reglas de negocio (cumpliendo OCP y SRP). Sin embargo, el costo radica en el incremento de líneas de código (de 81 a 207) y mayor indirección conceptual con 6 archivos. La versión "antes" habría sido suficiente si el sistema nunca fuera a añadir más medios de pago ni a incorporar componentes no deterministas de IA. Los patrones se justificaron plenamente ante los requisitos de extensibilidad y aislamiento de la IA.

## 3. Patrón Rechazado
Se rechazó el patrón **Singleton** para `FabricaPasarelas`. La IA sugirió crearlo como Singleton para centralizar el registro, pero el equipo lo descartó debido a que introduce estado global mutable, dificultando la ejecución paralela e independiente de pruebas unitarias.
