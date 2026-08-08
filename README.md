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

**Perfil sociodemográfico:** la muestra se concentra en el grupo de 45-64 años (35.3%), 
con ligera mayoría de mujeres (54%) y nivel educativo medio-alto. El 87.5% nació en España.

**Perfil laboral:** predomina la ocupación (47%) con contrato indefinido (59.9%), 
en el sector servicios (75.2%), reflejando la estructura económica terciarizada del país.

**Salud percibida:** cerca del 80% valora su salud como buena o muy buena; solo un 3.9% 
la califica como mala o muy mala. Un 28.7% presenta alguna dificultad funcional relevante.

**Tabaquismo:** el 53.2% nunca ha fumado habitualmente, frente a un 22.1% que fuma a diario. 
El vapeo es marginal (6.5%).

**Análisis bivariante (chi-cuadrado, p < 0.001):**
- Los hombres fuman a diario en mayor proporción que las mujeres (21% vs. 13.6%)
- Patrón generacional claro: el consumo diario aumenta hasta los 45-64 años y cae 
  drásticamente tras los 65 (posible efecto de supervivencia en grandes fumadores)
- A más años de residencia en España, más se aproxima el hábito tabáquico al de la 
  población general (efecto de aculturación)
- Peor percepción de salud se asocia a mayor tasa de tabaquismo diario, aunque la 
  relación es descriptiva y no permite establecer causalidad
- Las personas con enfermedad crónica muestran una tasa de exfumadores notablemente 
  mayor (27.3% vs. 16.3%), sugiriendo abandono del hábito tras el diagnóstico

**Análisis multivariante (MCA):** las dos primeras dimensiones explican un 17.6% de la 
inercia acumulada, un resultado esperable con variables categóricas de múltiples niveles. 
Las categorías minoritarias (ej. "no sabe leer o escribir", "75+") son las que más 
estructuran el mapa de asociaciones, mientras que las mayoritarias se concentran cerca 
del centro.

📄 Informe completo con gráficos: [`docs/Código_Encuesta_Salud.html`](docs/Código_Encuesta_Salud.html)
## Autora

Alejandra — [www.linkedin.com/in/alejandra-villar-perdomo-ab041b110]
