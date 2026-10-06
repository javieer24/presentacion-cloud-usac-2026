# Comienza Aquí - Ecosistema Cloud 2026

Bienvenido a la presentación técnica **"Ecosistema Cloud 2026: Arquitectura y Estrategia Multicloud"**. Esta guía te ayudará a navegar los materiales disponibles.

---

## Por Dónde Empezar

### Si asististe a la presentación:
1. **Revisa la presentación interactiva** (disponible en Artifact Slides)
2. **Consulta el glosario técnico** si encuentras términos desconocidos
3. **Estudia el análisis de costos** para entender presupuestos reales
4. **Usa el checklist** para validar arquitecturas en tus proyectos

### Si eres estudiante de CYS y quieres profundizar:
1. Comienza con [**Glosario Técnico**](docs/glosario-tecnico.md) — Aprende 50+ términos AWS
2. Revisa [**Referencias & Recursos**](docs/referencias-recursos.md) — Cursos, libros, laboratorios
3. Estudia [**Checklist de Arquitectura**](docs/checklist-arquitectura.md) — Mejores prácticas
4. Analiza [**Análisis de Costos**](docs/analisis-costos.md) — Presupuestos y ROI

### Si eres profesional preparándote para SAA-C03:
1. Usa el glosario como referencia rápida
2. Realiza ejercicios prácticos (laboratorios hands-on)
3. Consulta referencias AWS oficial y cursos certificación
4. Practica con casos de uso reales (arquitectura FinTech)

---

## Documentación Oficial

| Recurso | Duración | Para Quién | Objetivo |
|---|---|---|---|
| **[Glosario Técnico](docs/glosario-tecnico.md)** | 30 min lectura | Todos | Comprender terminología AWS |
| **[Análisis de Costos](docs/analisis-costos.md)** | 45 min lectura | Arquitectos, Finance | Presupuesto y ROI |
| **[Checklist de Arquitectura](docs/checklist-arquitectura.md)** | 2 horas uso | Arquitectos, DevOps | Validar diseños |
| **[Referencias & Recursos](docs/referencias-recursos.md)** | 1 hora exploración | Estudiantes, Aspirantes cert. | Profundizar en temas |

---

## Temas Principales Cubiertos

### 1. Fundamentos Cloud
- ¿Qué es Cloud Computing?
- CAPEX vs OPEX (modelo de negocio)
- Características fundamentales (escalabilidad, elasticidad, automatización)

### 2. Modelos de Despliegue
- **Nube Pública**: AWS, Azure, GCP (compartida, bajo costo)
- **Nube Privada**: On-premise, dedicada (control total, costo alto)
- **Nube Híbrida**: Combinación (flexibilidad)
- **Multinube**: AWS + Azure + GCP (evitar lock-in)

### 3. Modelos de Servicio
| Modelo | Quién Gestiona | Ejemplo | Complejidad |
|---|---|---|---|
| **IaaS** | Cliente gestiona SO, app, datos | AWS EC2 | Alta |
| **PaaS** | Proveedor gestiona hasta runtime | Heroku, Beanstalk | Media |
| **SaaS** | Proveedor gestiona todo | Salesforce, Slack | Baja |

### 4. Comparativa Multicloud
| Aspecto | AWS | Azure | GCP |
|---|---|---|---|
| Market Share | 32% | 20% | 15% |
| Fortaleza | Catálogo, comunidad | Microsoft integration | AI/ML |
| Mejor para | Startups, escalabilidad | Enterprise .NET | Data Science |

### 5. Arquitectura de Redes (CRÍTICA)
- **VPC**: Red privada aislada
- **Subredes**: Públicas (IGW) vs Privadas (NAT)
- **Security Groups**: Firewall stateful por instancia
- **Route Tables**: Reglas de ruteo de tráfico
- **High Availability**: Multi-AZ redundancia

### 6. Caso Práctico: FinTech
**Arquitectura completa para procesamiento de pagos**:
- Frontend: ALB + WAF (subred pública)
- Aplicación: ASG (Auto Scaling) (subred privada)
- Base de datos: RDS Multi-AZ (subred privada)
- Almacenamiento: S3 + KMS encriptado
- Costo estimado: ~$450/mes (100 usuarios)

---

## Búsqueda Rápida por Tema

¿Necesitas información sobre...?

- **VPC** -> Glosario (VPC, Subnets, Route Table) o Checklist (Networking)
- **Costo de EC2** -> Análisis de Costos (sección Cómputo)
- **Seguridad en RDS** -> Checklist (sección Base de Datos)
- **Certificación AWS** -> Referencias (sección Certificaciones)
- **Cursos online** -> Referencias (sección Plataformas)
- **Mejores prácticas** -> Checklist (sección Alta Disponibilidad)

---

## Nivel de Dificultad por Documento

```
Glosario:         Nivel 1 (Principiante)
Referencias:      Nivel 2 (Principiante+)
Análisis Costos:  Nivel 3 (Intermedio)
Checklist:        Nivel 4 (Intermedio+)
Presentación:     Nivel 5 (Avanzado)
```

---

## Ejercicios Prácticos Recomendados

### Ejercicio 1: VPC Multi-AZ
**Objetivo**: Crear red privada con subredes públicas y privadas  
**Duración**: 1 hora  
**Herramienta**: AWS Console o Terraform  
**Validar con**: Checklist (sección Networking)

### Ejercicio 2: ASG + ALB
**Objetivo**: Escalado automático y distribución de carga  
**Duración**: 2 horas  
**Requisito**: Ejercicio 1 completado

### Ejercicio 3: RDS Multi-AZ + Failover
**Objetivo**: Verificar alta disponibilidad  
**Duración**: 2 horas  
**Requisito**: Ejercicio 2 completado

### Ejercicio 4: Arquitectura FinTech Completa
**Objetivo**: Integrar todos los servicios  
**Duración**: 4 horas  
**Requisito**: Ejercicios 1-3 completados  
**Validar con**: Checklist completo

---

## Herramientas que Necesitarás

| Herramienta | Para Qué | Costo | Descarga |
|---|---|---|---|
| **AWS Account** | Laboratorios prácticos | Gratis (12 meses) | [aws.amazon.com](https://aws.amazon.com/) |
| **Terraform** | IaC para AWS | Gratis | [terraform.io](https://www.terraform.io/) |
| **Draw.io** | Diagramar arquitecturas | Gratis | [draw.io](https://draw.io/) |
| **VS Code** | Editor de código | Gratis | [code.visualstudio.com](https://code.visualstudio.com/) |

---

## Ruta de Aprendizaje Sugerida (4 Semanas)

### Semana 1: Conceptos Fundamentales
- [ ] Lee Glosario Técnico (30 min)
- [ ] Mira presentación (100 min)
- [ ] Consulta Referencias (1 hora)
- [ ] Ejercicio 1: VPC básico (1 hora)

### Semana 2: Servicios Core
- [ ] Lee Análisis de Costos (1 hora)
- [ ] Estudia Checklist (1 hora)
- [ ] Ejercicio 2: ASG + ALB (2 horas)

### Semana 3: Base de Datos & Almacenamiento
- [ ] RDS Multi-AZ en Glosario
- [ ] Validar con Checklist (BD)
- [ ] Ejercicio 3: RDS Failover (2 horas)

### Semana 4: Integración & Seguridad
- [ ] Revisa sección Seguridad en Checklist
- [ ] Ejercicio 4: FinTech completa (4 horas)
- [ ] Valida con Checklist al 100%

---

## Preguntas Frecuentes

**P: ¿Necesito experiencia previa en AWS?**  
R: No, la presentación comienza desde conceptos básicos. Sí ayuda conocer redes básicas (IP, TCP/UDP).

**P: ¿Cuánto cuesta los laboratorios?**  
R: AWS ofrece 12 meses gratis ($300 en créditos). Los ejercicios se pueden hacer dentro del free tier.

**P: ¿Debo memorizar todo el glosario?**  
R: No, es una referencia. Memoriza conceptos clave: VPC, Security Group, EC2, RDS, Multi-AZ.

**P: ¿Después puedo preparar SAA-C03?**  
R: Sí, esta presentación cubre 70% del contenido SAA-C03. Completa con cursos especializados (ver Referencias).

**P: ¿Hay código Terraform disponible?**  
R: Sí, ejemplos en la carpeta `src/terraform/` (en desarrollo).

---

## Contacto y Soporte

**Instructor**: Javier Andrés Monjes Solórzano  
**Rol**: SOC Analyst & Blue Team Consultant  
**Especialidad**: Cloud Security, AWS Architecture  

Para preguntas específicas sobre los materiales:
- Consulta primero el Glosario o Referencias
- Revisa el Checklist para validaciones
- Contacta durante horarios de oficina (a confirmar)

---

## Checklist Para Completar Curso

- [ ] Leí el Glosario Técnico
- [ ] Ví la presentación completa (100 min)
- [ ] Revisé Análisis de Costos
- [ ] Estudié Checklist de Arquitectura
- [ ] Consulté Referencias para profundizar
- [ ] Realicé Ejercicio 1 (VPC)
- [ ] Realicé Ejercicio 2 (ASG + ALB)
- [ ] Realicé Ejercicio 3 (RDS Failover)
- [ ] Realicé Ejercicio 4 (FinTech completa)
- [ ] Validé mi arquitectura con Checklist al 100%
- [ ] Respondí preguntas de autoevaluación

---

**¡Bienvenido! Que disfrutes aprendiendo sobre Cloud Computing.**

---

*Última actualización: Octubre 2026*  
*Versión: 1.0 - Oficial*
