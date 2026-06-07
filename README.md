# <img src="https://www.escom.ipn.mx/images/conocenos/escudoESCOM.png" width="45" align="center"> Sistema de Gestión de Contratos de Obras Públicas (SGCOP)

Analizador y gestor de contratos alineado a la **Ley de Obras Públicas y Servicios Relacionados con las Mismas (LOPSRM)**.

![Python](https://img.shields.io/badge/Python-3.14.5-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Django](https://img.shields.io/badge/Django-5.2-092E20?style=for-the-badge&logo=django&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![React](https://img.shields.io/badge/React-2026-61DAFB?style=for-the-badge&logo=react&logoColor=black)
![Vite](https://img.shields.io/badge/Vite-⚡-646CFF?style=for-the-badge)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)
![License](https://img.shields.io/badge/License-GPL%20v3-red?style=for-the-badge)

---

## Contexto Académico
* **Institución:** Escuela Superior de Cómputo (ESCOM - IPN)
* **Unidad de Aprendizaje:** Formulación y Evaluación de Proyectos Informáticos
* **Estado:** 🚧 En Desarrollo (`Comenzando`)

---

## Descripción del Proyecto

El **SGCOP** es una plataforma web desarrollada como prototipo funcional para automatizar y centralizar el flujo de información de los contratos de obra pública en México, tomando como referencia los lineamientos de la **LOPSRM**. 

El objetivo principal es sustituir el control tradicional en archivos de Excel por una aplicación web interactiva que permita mitigar errores humanos en el seguimiento del proyecto mediante flujos básicos de validación.

### Alcance del Prototipo (Módulos a Implementar):
* **Módulo de Contratos y Documentación:** Registro de datos generales de contratos y carga de archivos de soporte (catálogo de conceptos, finanzas y programa de obra en formato PDF/Excel).
* **Módulo de Bitácora Digital:** Registro cronológico de notas técnicas (instrucciones, acuerdos u observaciones) clasificadas por autor, simulando el funcionamiento de una bitácora electrónica.
* **Módulo de Estimaciones y Convenios:** Captura de avances de obra por periodos, revisión de los mismos mediante un sistema de estados básico (`Aceptada` / `Rechazada`) y registro de solicitudes de modificaciones contractuales.
* **Módulo de Visualización Operativa:** Consultas gráficas sencillas (Curva S) e indicadores visuales de semaforización para detectar desfases entre el avance real y el programado.
---

## Arquitectura del Sistema

El proyecto está dividido en una arquitectura desacoplada (Client-Server):

* **Backend:** API REST construida con **Django 5.2** y Django REST Framework (DRF), utilizando **Python 3.14.5**.
* **Frontend:** SPA (Single Page Application) fluida construida con **React**, empaquetada con **Vite** y estilizada con **Bootstrap**.
* **Base de Datos:** Relacional y robusta sobre **PostgreSQL 18**.

---

## Instalación y Configuración

*(Sección en construcción a medida que avance el desarrollo)*

### Requisitos Previos
* Python 3.14.5
* Node.js (versión LTS recomendada para React/Vite)
* Servidor PostgreSQL 18 activo
