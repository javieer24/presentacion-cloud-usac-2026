# Ecosistema Cloud 2026 - Índice Oficial

Presentación técnica sobre arquitectura cloud, modelos de despliegue, servicios AWS y caso práctico de arquitectura FinTech.

---

## Información General

**Institución**: USAC - Facultad de Ingeniería, Escuela de Ciencias y Sistemas (CYS)  
**Expositor**: Javier Andrés Monjes Solórzano   
**Requisitos**: Conocimientos básicos de redes y Linux (opcional)

---

## Cómo Usar Este Repositorio

### Paso 1: Lee Este Archivo (5 minutos)
Estás aquí. Este archivo explica la estructura y cómo navegar los recursos.

### Paso 2: Comienza Aquí (10 minutos)
Lee [COMIENZA_AQUI.md](COMIENZA_AQUI.md) para:
- Determinar tu perfil (estudiante, profesional, aspirante a certificación)
- Entender qué documentación es más relevante para ti
- Ver el nivel de dificultad de cada recurso

### Paso 3: Selecciona Tu Ruta

**Opción A: Solo Presentación**
1. Revisa la presentación interactiva (disponible en Artifact Slides)
2. Consulta el glosario técnico si encuentras términos desconocidos
3. Listo

**Opción B: Aprendizaje Completo**
1. Lee [Glosario Técnico](docs/glosario-tecnico.md) - 30 minutos
2. Estudia [Análisis de Costos](docs/analisis-costos.md) - 45 minutos
3. Usa [Checklist de Arquitectura](docs/checklist-arquitectura.md) - 2 horas
4. Consulta [Referencias y Recursos](docs/referencias-recursos.md) - 1 hora
5. Realiza ejercicios prácticos con los backends

**Opción C: Preparación para SAA-C03**
1. Glosario Técnico (referencia rápida)
2. Diagramas de Arquitectura (comprensión visual)
3. Referencias y Recursos (cursos certificación)
4. Ejercicios con backends (casos reales)

---

## Estructura del Repositorio

```
presentacion-cloud-usac-2026/
│
├── INDEX.md (este archivo)
├── COMIENZA_AQUI.md (guía de bienvenida)
├── README.md (descripción general)
├── .gitignore (configuración git)
│
├── docs/ (documentación oficial)
│   ├── glosario-tecnico.md (50+ términos AWS)
│   ├── analisis-costos.md (desglose presupuestario)
│   ├── checklist-arquitectura.md (100+ puntos validación)
│   ├── referencias-recursos.md (cursos, libros, links)
│   ├── diagramas-arquitectura.md (10 diagramas Mermaid)
│   └── guion-orador.md (notas instructor)
│
├── backends/ (servicios funcionales)
│   ├── README.md (instrucciones setup)
│   ├── python/
│   │   ├── requirements.txt (dependencias)
│   │   └── app.py (API transacciones)
│   └── nodejs/
│       ├── package.json (dependencias)
│       └── server.js (API auditoría)
│
└── presentation-slides.md (referencia slides)
```

---

## Documentación Por Tipo

### Documentos para Aprender

| Archivo | Duración | Contenido | Para Quién |
|---------|----------|----------|-----------|
| COMIENZA_AQUI.md | 10 min | Guía de navegación | Todos |
| glosario-tecnico.md | 30 min | 50+ definiciones AWS | Principiantes |
| diagramas-arquitectura.md | 45 min | 10 diagramas Mermaid | Visuales |
| referencias-recursos.md | 1 hora | Cursos, libros, links | Autodidactas |

### Documentos para Profundizar

| Archivo | Duración | Contenido | Para Quién |
|---------|----------|----------|-----------|
| analisis-costos.md | 45 min | Presupuestos AWS detallados | Arquitectos, Finance |
| checklist-arquitectura.md | 2 horas | 100+ puntos validación | Arquitectos, DevOps |
| diagramas-arquitectura.md | Referencia | Arquitectura visual | Técnicos |

### Documentos de Referencia

| Archivo | Contenido | Para Quién |
|---------|----------|-----------|
| guion-orador.md | Notas detalladas instructor | Instructores |
| backends/README.md | Setup backends Python/Node | Desarrolladores |

---

## Guía Paso a Paso por Nivel

### Nivel 1: Principiante Absoluto

**Objetivo**: Entender conceptos básicos cloud  
**Tiempo**: 1-2 horas  
**Pasos**:

1. Lee COMIENZA_AQUI.md
2. Lee glosario-tecnico.md (enfoque en: VPC, EC2, RDS, S3)
3. Mira diagramas-arquitectura.md (enfoque en diagramas 1-3)
4. Consulta referencias-recursos.md (sección "Conceptos Fundamentales")

### Nivel 2: Intermedio

**Objetivo**: Comprender arquitecturas escalables  
**Tiempo**: 4-6 horas  
**Pasos**:

1. Completa Nivel 1
2. Estudia analisis-costos.md (sección "Supuestos Base")
3. Revisa checklist-arquitectura.md (sección "Networking")
4. Mira diagramas 4-7 en diagramas-arquitectura.md
5. Intenta ejercicios básicos con backends

### Nivel 3: Avanzado

**Objetivo**: Diseñar y validar arquitecturas  
**Tiempo**: 8-12 horas  
**Pasos**:

1. Completa Niveles 1-2
2. Domina analisis-costos.md (todas las secciones)
3. Domina checklist-arquitectura.md (todas las secciones)
4. Revisa todos los diagramas (1-10)
5. Implementa backends completos (Python + Node.js)
6. Crea tu propia arquitectura y valida con checklist

---

## Usando los Backends

### Requisitos

- Python 3.9+ (para backend Python)
- Node.js 16+ (para backend Node.js)
- Credenciales AWS (sin hardcode, usar ~/.aws/credentials)

### Quick Start

```bash
# Backend Python (Terminal 1)
cd backends/python
pip install -r requirements.txt
python app.py

# Backend Node.js (Terminal 2)
cd backends/nodejs
npm install
npm start
```

Ver [backends/README.md](backends/README.md) para instrucciones completas.

---

## Flujo de Aprendizaje Recomendado

```
Inicio
  |
  +---> COMIENZA_AQUI.md (¿Quién eres?)
  |
  +---> Glosario Técnico (Conceptos)
  |
  +---> Diagramas (Visualización)
  |
  +---> Análisis Costos (Presupuesto)
  |
  +---> Checklist (Validación)
  |
  +---> Backends (Práctica)
  |
  +---> Referencias (Profundización)
  |
  v
Fin
```

---

## Temas Cubiertos

1. **Fundamentos Cloud**
   - Qué es Cloud Computing
   - CAPEX vs OPEX
   - Características fundamentales

2. **Modelos de Despliegue**
   - Nube Pública
   - Nube Privada
   - Nube Híbrida
   - Multinube

3. **Modelos de Servicio**
   - IaaS (Infraestructura)
   - PaaS (Plataforma)
   - SaaS (Software)

4. **Comparativa Multicloud**
   - AWS vs Azure vs GCP
   - Equivalencias de servicios
   - Cuándo usar cada uno

5. **Arquitectura de Redes AWS**
   - VPC y subredes
   - Security Groups y NACLs
   - Routing y NAT
   - Alta disponibilidad Multi-AZ

6. **Caso Práctico: FinTech**
   - Arquitectura completa
   - Seguridad multicapa
   - Escalabilidad automática
   - Análisis de costos

---

## Preguntas Frecuentes

**P: ¿Puedo leer esto sin haber asistido a la presentación?**  
R: Sí. La documentación es autocontenida. Comienza con COMIENZA_AQUI.md.

**P: ¿Cuánto tiempo debo dedicar?**  
R: Depende de tu nivel. Principiantes: 1-2 horas. Avanzado: 8-12 horas completas.

**P: ¿Necesito credenciales AWS reales?**  
R: Solo si quieres ejecutar los backends. Los documentos no requieren acceso AWS.

**P: ¿Hay ejercicios?**  
R: Sí. Ver COMIENZA_AQUI.md sección "Ejercicios Prácticos".

**P: ¿Puedo usar esto para preparar SAA-C03?**  
R: Sí. Esta presentación cubre 70% del contenido. Complementa con cursos certificación.

---

## Convenciones del Documento

- **Negrita**: Términos o conceptos importantes
- `Código`: Comandos, variables, rutas
- [Enlaces]: Referencias a otros documentos
- Tablas: Comparativas y referencias rápidas
- Sin emojis: Formato profesional técnico

---

## Contacto y Soporte

**Instructor**: Javier Andrés Monjes Solórzano  
**Especialidad**: Cloud Security, AWS Architecture  
**Email**: javiermonjesnuevo@gmail.com

Para preguntas:
1. Consulta primero COMIENZA_AQUI.md
2. Busca en glosario-tecnico.md
3. Revisa referencias-recursos.md
4. Contacta con instructor

---

## Roadmap de Actualización

- Version 1.0: Documentación oficial y backends
- Próximas: Ejercicios adicionales, videos, webinars

---

**Última actualización**: Octubre 2026  
**Versión**: 1.0 - Oficial  
**Estado**: Listo para uso en producción académica
