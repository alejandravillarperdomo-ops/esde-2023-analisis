load("C:/Users/aleja/OneDrive/Documentos/PORTFOLIO/PRÁCTICAS/ESdEadulto_2023.RData")
head(df_meta)
names(df_micro)
str(df_micro
str(df_micro)
str(df_micro[,1:10])
summary(df_micro)
str(df_meta)
head(df_meta)
attributes(df_micro$SEXOa)
attr(df_micro$SEXOa, "labels")
library(readxl)
install.packages("readxl")
library(readxl)
library(dplyr)
library(purrr)
library(readxl)
library(dplyr)
library(purrr)
# 1. Extraer todos los diccionarios de código->etiqueta de las hojas Tablas1-4
extraer_diccionario <- function(hoja) {
raw <- read_excel("dr_ESdEadulto_2023.xlsx", sheet = hoja, col_names = FALSE)
inicios <- which(!is.na(raw[[3]]) & is.na(raw[[1]]))  # filas "NombreDicc *** variable"
map_dfr(seq_along(inicios), function(i) {
fila_ini <- inicios[i] + 2  # saltamos la fila de cabecera "Código/Descripción"
fila_fin <- if (i < length(inicios)) inicios[i + 1] - 1 else nrow(raw)
dicc_nombre <- raw[[1]][inicios[i]]
bloque <- raw[fila_ini:fila_fin, 1:2] %>% filter(!is.na(.[[1]]))
tibble(diccionario = dicc_nombre, codigo = as.character(bloque[[1]]), etiqueta = bloque[[2]])
})
}
diccionarios <- bind_rows(
extraer_diccionario("Tablas1"),
extraer_diccionario("Tablas2"),
extraer_diccionario("Tablas3"),
extraer_diccionario("Tablas4")
)
# 2. Función para recodificar UNA variable, usando df_meta para saber qué diccionario le toca
recodificar_var <- function(var, nombre_var, meta, dicc) {
dicc_var <- meta$Diccionario.de.la.variable[meta$Variable == nombre_var]
if (length(dicc_var) == 0 || is.na(dicc_var)) return(var)  # sin diccionario -> se deja igual
tabla <- dicc %>% filter(diccionario == dicc_var)
if (nrow(tabla) == 0) return(var)
factor(var, levels = tabla$codigo, labels = tabla$etiqueta)
}
# 3. Aplicarlo a TODO df_micro de golpe, columna por columna
df_micro_factor <- df_micro
for (v in names(df_micro_factor)) {
df_micro_factor[[v]] <- recodificar_var(df_micro_factor[[v]], v, df_meta, diccionarios)
}
extraer_diccionario <- function(hoja) {
raw <- read_excel("dr_ESdEadulto_2023.xlsx", sheet = hoja, col_names = FALSE)
inicios <- which(!is.na(raw[[3]]) & is.na(raw[[1]]))
map_dfr(seq_along(inicios), function(i) {
fila_ini <- inicios[i] + 2  # saltamos la fila de cabecera "Código/Descripción"
fila_fin <- if (i < length(inicios)) inicios[i + 1] - 1 else nrow(raw)
dicc_nombre <- raw[[1]][inicios[i]]
bloque <- raw[fila_ini:fila_fin, 1:2] %>% filter(!is.na(.[[1]]))
tibble(diccionario = dicc_nombre, codigo = as.character(bloque[[1]]), etiqueta = bloque[[2]])
})
}
diccionarios <- bind_rows(
extraer_diccionario("Tablas1"),
extraer_diccionario("Tablas2"),
extraer_diccionario("Tablas3"),
extraer_diccionario("Tablas4")
)
recodificar_var <- function(var, nombre_var, meta, dicc) {
dicc_var <- meta$Diccionario.de.la.variable[meta$Variable == nombre_var]
if (length(dicc_var) == 0 || is.na(dicc_var)) return(var)
tabla <- dicc %>% filter(diccionario == dicc_var)
if (nrow(tabla) == 0) return(var)
factor(var, levels = tabla$codigo, labels = tabla$etiqueta)
}
df_micro_factor <- df_micro
for (v in names(df_micro_factor)) {
df_micro_factor[[v]] <- recodificar_var(df_micro_factor[[v]], v, df_meta, diccionarios)
}
table(df_micro_factor$SEXOa)
table(df_micro_factor$CCAA)
meta_sexo <- df_meta$Diccionario.de.la.variable[df_meta$Variable == "SEXOa"]
print(meta_sexo)
nchar(meta_sexo)
unique(diccionarios$diccionario)[grepl("SEXO", unique(diccionarios$diccionario))]
extraer_diccionario <- function(hoja) {
raw <- read_excel("dr_ESdEadulto_2023.xlsx", sheet = hoja, col_names = FALSE)
inicios <- which(!is.na(raw[[3]]))   # <- quitamos la condición de col1
map_dfr(seq_along(inicios), function(i) {
fila_ini <- inicios[i] + 2
fila_fin <- if (i < length(inicios)) inicios[i + 1] - 1 else nrow(raw)
dicc_nombre <- trimws(raw[[1]][inicios[i]])
bloque <- raw[fila_ini:fila_fin, 1:2] %>% filter(!is.na(.[[1]]))
tibble(diccionario = dicc_nombre,
codigo = trimws(as.character(bloque[[1]])),
etiqueta = bloque[[2]])
})
}
# Reconstruir con la función corregida
diccionarios <- bind_rows(
extraer_diccionario("Tablas1"),
extraer_diccionario("Tablas2"),
extraer_diccionario("Tablas3"),
extraer_diccionario("Tablas4")
)
# Verifica que ahora sí aparece
unique(diccionarios$diccionario)[grepl("SEXO", unique(diccionarios$diccionario))]
# debería devolver "TSEXO"
diccionarios <- bind_rows(
extraer_diccionario("Tablas1"),
extraer_diccionario("Tablas2"),
extraer_diccionario("Tablas3"),
extraer_diccionario("Tablas4")
)
unique(diccionarios$diccionario)[grepl("SEXO", unique(diccionarios$diccionario))]
df_micro_factor <- df_micro
for (v in names(df_micro_factor)) {
df_micro_factor[[v]] <- recodificar_var(df_micro_factor[[v]], v, df_meta, diccionarios)
}
table(df_micro_factor$SEXOa)
table(df_micro_factor$CCAA)
load("C:/Users/aleja/OneDrive/Documentos/PORTFOLIO/PRÁCTICAS/ESdEadulto_2023.RData")
library(readxl)
library(dplyr)
library(tidyr)
library(purrr)
extraer_diccionario <- function(hoja) {
raw <- read_excel("dr_ESdEadulto_2023.xlsx", sheet = hoja, col_names = FALSE)
inicios <- which(!is.na(raw[[1]]) & !is.na(raw[[3]]))
map_dfr(seq_along(inicios), function(i) {
fila_ini <- inicios[i] + 2  # saltamos la fila "Código/Descripción"
fila_fin <- if (i < length(inicios)) inicios[i + 1] - 1 else nrow(raw)
dicc_nombre <- trimws(as.character(raw[[1]][inicios[i]]))
bloque <- raw[fila_ini:fila_fin, 1:2]
bloque <- bloque[!is.na(bloque[[1]]), ]
if (nrow(bloque) == 0) return(NULL)
tibble(diccionario = dicc_nombre,
codigo = trimws(as.character(bloque[[1]])),
etiqueta = as.character(bloque[[2]]))
})
}
diccionarios <- map_dfr(c("Tablas1","Tablas2","Tablas3","Tablas4"), extraer_diccionario)
# 2. Pasar los datos a formato largo (todo a texto para poder apilar
#    columnas numericas y de texto juntas)
datos_largo <- df_micro %>%
mutate(across(-IDENTHOGAR, as.character)) %>%
pivot_longer(-IDENTHOGAR, names_to = "Variable", values_to = "codigo") %>%
mutate(codigo = trimws(codigo))
# 3. Traer el diccionario que le toca a cada variable
datos_largo <- datos_largo %>%
left_join(df_meta %>% select(Variable, diccionario = Diccionario.de.la.variable),
by = "Variable")
# 4. Un unico join con los diccionarios para traducir el codigo
datos_largo <- datos_largo %>%
left_join(diccionarios, by = c("diccionario", "codigo"))
# 5. CLAVE: si no hay traduccion (no hay diccionario, o el codigo no aparece
#    en el, p.ej. valores numericos reales como la edad), CONSERVAMOS el
#    codigo original en vez de perderlo como NA
datos_largo <- datos_largo %>%
mutate(valor_final = coalesce(etiqueta, codigo))
# 6. Volver a formato ancho
df_final <- datos_largo %>%
select(IDENTHOGAR, Variable, valor_final) %>%
pivot_wider(names_from = Variable, values_from = valor_final)
save(df_micro, df_meta, diccionarios, df_final, file = "ESdEadulto_2023_recodificado.RData")
Ajusta las rutas de load(...) y read_excel(...) a donde tengas guardados tus dos archivos localmente. Ya lo tienes también como archivo descargable en el mensaje anterior (recodificar_ESdE.R) por si prefieres abrirlo directamente en RStudio.
class(df_final$EDADa)   # ahora mismo será "character" (ej. "48"), no numero
class(df_final$SEXOa)   # tambien "character" (ej. "Hombre"), no factor
class(df_final$H3)      # "character", mezcla numeros y texto
table(df_final$SEXOa, useNA = "always")
sum(is.na(df_final)) == sum(is.na(df_micro))   # deberian coincidir (ya cuadraba bien antes del paso 7)
tipos <- df_meta %>% select(Variable, Tipo) %>% filter(Variable != "IDENTHOGAR")
fijar_formato <- function(df, tipos) {
for (i in seq_len(nrow(tipos))) {
var <- tipos$Variable[i]
tipo <- tipos$Tipo[i]
if (!(var %in% names(df))) next
if (is.na(tipo)) next
if (tipo == "N") {
original <- df[[var]]
na_antes <- sum(is.na(original))
numerico <- suppressWarnings(as.numeric(original))
na_despues <- sum(is.na(numerico))
# si convertir a numero genera NAs nuevos, es que hay etiquetas de
# texto reales (ej. "Muy estresante") mezcladas con codigos -> factor
if (na_despues > na_antes) {
df[[var]] <- as.factor(original)
} else {
df[[var]] <- numerico
}
} else if (tipo == "A") {
df[[var]] <- as.factor(df[[var]])
}
}
df
}
df_final <- fijar_formato(df_final, tipos)
sum(is.na(df_final)) == sum(is.na(df_micro))   # deben coincidir
table(df_final$SEXOa, useNA = "always")         # comprobar una variable conocida
class(df_final$EDADa)                           # debe ser "numeric"
class(df_final$H3)                              # debe ser "factor"
class(df_final$EDADa)   # ahora mismo será "character" (ej. "48"), no numero
class(df_final$SEXOa)   # tambien "character" (ej. "Hombre"), no factor
class(df_final$H3)      # "character", mezcla numeros y texto
table(df_final$SEXOa, useNA = "always")
sum(is.na(df_final)) == sum(is.na(df_micro))   # deberian coincidir (ya cuadraba bien antes del paso 7)
head(df_meta)
names(df_micro)[1:20]
str(df_micro[,1:10])
summary(df_micro$EDADa)
save(df_final, file = "df_final_recodificado.RData")
