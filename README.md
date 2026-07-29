# Análisis Encuesta de Salud de España (ESdE) 2023

Proyecto de portfolio de análisis de datos aplicado a la [Encuesta de Salud de España (ESdE) 2023](https://www.sanidad.gob.es/), del Ministerio de Sanidad.

## Objetivo

*(Describe aquí en 2-3 frases qué pregunta(s) quieres responder con los datos: p. ej. patrones de consumo de alcohol según sexo, edad, clase social, país de nacimiento y CCAA.)*

## Datos

- **Fuente**: Ministerio de Sanidad — ESdE 2023, cuestionario adulto.
- **Diseño de registro**: `dr_ESdEadulto_2023.xlsx` (hoja "Diseño" con variables/posiciones/longitudes; hojas "Tablas1-4" con diccionarios de códigos).
- Los datos crudos y procesados **no están incluidos en el repositorio** (ver `.gitignore`). Para reproducir el análisis:
  1. Descarga los microdatos desde la web del Ministerio de Sanidad.
  2. Colócalos en `data/raw/`.
  3. Ejecuta los scripts en orden (ver abajo).

## Estructura del proyecto

```
esde-2023-analisis/
├── data/
│   ├── raw/          # Datos originales (no versionados)
│   └── processed/    # Datos recodificados (no versionados)
├── scripts/           # Scripts de R del pipeline
├── docs/              # Informes, gráficos, notas
├── .gitignore
└── README.md
```

## Pipeline de procesamiento

1. Carga de `df_micro` (microdatos en formato ancho) y del diseño de registro.
2. Transformación a formato largo (`pivot_longer`).
3. Cruce único con los diccionarios de códigos (`left_join`).
4. Vuelta a formato ancho (`pivot_wider`).
5. Fijado de tipos de variable (numérica/factor) según metadatos.
6. Verificación: comparación de NAs y conteos entre datos crudos y recodificados.
7. Análisis exploratorio y visualización.

## Cómo reproducirlo

```bash
# Clona el repo
git clone <url-del-repo>
cd esde-2023-analisis

# Instala dependencias de R (si usas renv)
Rscript -e "renv::restore()"

# Ejecuta el pipeline
Rscript scripts/01_recodificacion.R
Rscript scripts/02_analisis.R
```

## Resultados

*(Añade aquí, a medida que avances, los hallazgos principales y enlaces a gráficos/informes en `docs/`.)*

## Autora

Alejandra — [enlace a LinkedIn / portfolio, si quieres incluirlo]
