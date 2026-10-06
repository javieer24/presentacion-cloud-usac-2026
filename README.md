# Ecosistema Cloud 2026: Arquitectura y Estrategia Multicloud

**Presentación técnica para USAC - Facultad de Ingeniería (CYS)**

Panorama completo: desde conceptos fundamentales de Cloud Computing hasta arquitecturas FinTech escalables en AWS. Incluye modelos de despliegue, servicios IaaS/PaaS/SaaS, comparativa multicloud (AWS vs Azure vs GCP), redes avanzadas (VPC, Direct Connect, Transit Gateway) y caso práctico real con seguridad multicapa, alta disponibilidad y análisis de costos.

## 📋 Detalles

- **Instructor**: Javier Andrés Monjes Solórzano
- **Rol**: SOC Analyst & Blue Team Consultant
- **Duración**: 1 hora 40 minutos (100 minutos)
- **Fecha**: 26 de septiembre 2026
- **Horario**: 10:30 - 12:10 AM
- **Ubicación**: USAC, T3-412
- **Público**: Estudiantes de Ingeniería en Ciencias y Sistemas + profesionales
- **Marco**: SAA-C03 Blueprint Edition

## 📁 Estructura del Proyecto

```
presentacion-cloud-usac-2026/
├── README.md
├── index.html (presentación interactiva)
├── assets/
│   ├── css/style.css
│   ├── js/presentation.js
│   └── images/
├── docs/
│   ├── guion-orador.md
│   ├── referencias.md
│   └── checklist-seguridad.md
└── src/
    ├── terraform/
    └── diagrams/
```

## 🎯 Módulos de Contenido

1. **Intro + Presentador** (5 min)
2. **¿Qué es Cloud Computing?** (5 min)
3. **Modelos de Despliegue** (7 min) - Pública, Privada, Híbrida, Multinube
4. **Modelos de Servicio** (8 min) - IaaS, PaaS, SaaS, Responsabilidad Compartida
5. **Comparativa Multicloud** (10 min) - AWS vs Azure vs GCP, tabla equivalencias
6. **Arquitectura Redes AWS** (15 min) - VPC, Seguridad, Conectividad privada
7. **Caso Práctico: FinTech** (20 min) - Escenario real, Multi-AZ, costos
8. **Conclusiones + Q&A** (15 min)

## 🎨 Diseño Visual

- **Inspiración**: AWS SAA-C03 Architecture Blueprint
- **Paleta**: Naranja USAC + Gris/Negro + Azul Cielo
- **Tipografía**: Inter, Segoe UI, Roboto Mono
- **Elementos**: Geometría, iconografía técnica, diagramas interactivos
- **Animaciones**: Progresivas, no distractoras

## 📊 Timeline

```
Total: 100 minutos
├─ 00:00 - 05:00 Intro (Presentación personal + Cloud fundamentals)
├─ 05:00 - 12:00 Modelos Despliegue
├─ 12:00 - 20:00 IaaS/PaaS/SaaS
├─ 20:00 - 30:00 Comparativa Multicloud
├─ 30:00 - 45:00 Redes AWS (CRÍTICA)
├─ 45:00 - 65:00 Caso FinTech (PRINCIPAL)
├─ 65:00 - 80:00 Arquitectura Híbrida + Endpoints
└─ 80:00 - 100:00 Conclusiones + Preguntas
```

## 🚀 Cómo Usar

```bash
# Visualizar presentación
open index.html

# O desde terminal
python -m http.server 8000
# Luego ir a http://localhost:8000
```

## 📚 Documentación Oficial para Estudiantes

### Guías Técnicas
- **[Glosario Técnico](docs/glosario-tecnico.md)** — Definiciones de 50+ términos AWS (VPC, EC2, RDS, Security Groups, etc.)
- **[Análisis de Costos](docs/analisis-costos.md)** — Desglose detallado de presupuesto por componente, escenarios de crecimiento, optimizaciones
- **[Checklist de Arquitectura](docs/checklist-arquitectura.md)** — Lista de verificación de 100+ puntos para validar arquitecturas seguras y escalables

### Referencias & Recursos
- **[Referencias Bibliográficas](docs/referencias-recursos.md)** — Documentación AWS oficial, cursos certificación, laboratorios hands-on, libros, blogs especializados

### Apoyo del Instructor
- **[Guión del Orador](docs/guion-orador.md)** — Notas detalladas con timings, explicaciones por sección, respuestas a preguntas frecuentes (para instructor)

---

**Estado**: En desarrollo 🚀  
**Última actualización**: Octubre 6, 2026  
**Autor**: Javier Andrés Monjes Solórzano  
**Institución**: USAC - Facultad de Ingeniería
