# Ecosistema Cloud 2026 - Índice Oficial

Presentación técnica sobre arquitectura cloud, modelos de despliegue, servicios AWS y caso práctico de arquitectura FinTech.

---

## Información General

**Institución**: USAC - Facultad de Ingeniería, Escuela de Ciencias y Sistemas  
**Expositor**: Javier Andrés Monjes Solórzano  
**Nivel**: Intermedio a Avanzado  
**Requisitos**: Conocimientos básicos de redes y Linux (opcional)

---

## Cómo Usar Este Repositorio

### Paso 1: Lee Este Archivo (5 minutos)
Estás aquí. Este archivo explica la estructura y cómo navegar los recursos.

### Paso 2: Comienza Aquí (10 minutos)
Lee [docs/COMIENZA_AQUI.md](docs/COMIENZA_AQUI.md) para:
- Determinar tu perfil (estudiante, profesional, aspirante a certificación)
- Entender qué documentación es más relevante para ti
- Ver el nivel de dificultad de cada recurso

### Paso 3: Selecciona Tu Ruta

**Opción A: Solo Presentación**
1. Revisa la presentación 
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
|
├── README.md (este archivo - índice oficial)
├── .gitignore (configuración git segura)
|
├── docs/ (documentación oficial)
│   ├── COMIENZA_AQUI.md (guía de bienvenida)
│   ├── glosario-tecnico.md (50+ términos AWS)
│   ├── analisis-costos.md (desglose presupuestario)
│   ├── checklist-arquitectura.md (100+ puntos validación)
│   ├── referencias-recursos.md (cursos, libros, links)
│   ├── diagramas-arquitectura.md (10 diagramas Mermaid)
│   └── guion-orador.md (notas instructor)
|
├── backends/ (servicios funcionales)
│   ├── README.md (instrucciones setup)
│   ├── python/
│   │   ├── requirements.txt (dependencias)
│   │   └── app.py (API transacciones)
│   └── nodejs/
│       ├── package.json (dependencias)
│       └── server.js (API auditoría)
|
└── presentation-slides.md (referencia slides)
```

---

## Documentación Por Tipo

### Documentos para Aprender

| Archivo | Duración | Contenido | Para Quién |
|---------|----------|----------|-----------|
| docs/COMIENZA_AQUI.md | 10 min | Guía de navegación | Todos |
| docs/glosario-tecnico.md | 30 min | 50+ definiciones AWS | Principiantes |
| docs/diagramas-arquitectura.md | 45 min | 10 diagramas Mermaid | Visuales |
| docs/referencias-recursos.md | 1 hora | Cursos, libros, links | Autodidactas |

### Documentos para Profundizar

| Archivo | Duración | Contenido | Para Quién |
|---------|----------|----------|-----------|
| docs/analisis-costos.md | 45 min | Presupuestos AWS detallados | Arquitectos, Finance |
| docs/checklist-arquitectura.md | 2 horas | 100+ puntos validación | Arquitectos, DevOps |
| docs/diagramas-arquitectura.md | Referencia | Arquitectura visual | Técnicos |

---

## Quick Start

### Para Aprendizaje

```
1. Lee docs/COMIENZA_AQUI.md (tu guía de navegación)
2. Elige una de las 3 opciones de ruta
3. Sigue el flujo de aprendizaje sugerido
```

### Para Ejecutar Backends

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
  +---> docs/COMIENZA_AQUI.md (¿Quién eres?)
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
R: Sí. La documentación es autocontenida. Comienza con docs/COMIENZA_AQUI.md.

**P: ¿Cuánto tiempo debo dedicar?**  
R: Depende de tu nivel. Principiantes: 1-2 horas. Avanzado: 8-12 horas completas.

**P: ¿Necesito credenciales AWS reales?**  
R: Solo si quieres ejecutar los backends. Los documentos no requieren acceso AWS.

**P: ¿Hay ejercicios?**  
R: Sí. Ver docs/COMIENZA_AQUI.md sección "Ejercicios Prácticos".

**P: ¿Puedo usar esto para preparar SAA-C03?**  
R: Sí. Esta presentación cubre 70% del contenido. Complementa con cursos certificación.

---

## Contacto y Soporte

**Instructor**: Javier Andrés Monjes Solórzano  
**Especialidad**: Cloud Security, AWS Architecture  

Para preguntas:
1. Consulta primero docs/COMIENZA_AQUI.md
2. Busca en docs/glosario-tecnico.md
3. Revisa docs/referencias-recursos.md
4. Contacta con instructor

---
**Última actualización**: Octubre 2026  

