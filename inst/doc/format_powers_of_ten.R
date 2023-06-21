## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library("formatdown")

options(
  datatable.print.nrows = 15,
  datatable.print.topn = 3,
  datatable.print.class = TRUE
)

## -----------------------------------------------------------------------------
library("formatdown")
library("data.table")
library("knitr")

## -----------------------------------------------------------------------------
# Numerical value
avogadro <- 6.0221E+23

# Arguments named
(x <- format_power(x = avogadro, digits = 4))

# Arguments unnamed
y <- format_power(avogadro, 4)

# Implicit use of default argument
z <- format_power(avogadro)

# Demonstrate equivalence
all.equal(x, y)
all.equal(x, z)

## -----------------------------------------------------------------------------
format_power(avogadro)

## -----------------------------------------------------------------------------
x <- c(
  1.2222e-6, 2.3333e-5, 3.4444e-4, 4.1111e-3, 5.2222e-2, 6.3333e-1,
  7.4444e+0, 8.1111e+1, 9.2222e+2, 1.3333e+3, 2.4444e+4, 3.1111e+5, 4.2222e+6
)
format_power(x)

## -----------------------------------------------------------------------------
format_power(x[1], 3)
format_power(x[1], 4)

## -----------------------------------------------------------------------------
format_power(x[3])
format_power(x[3], format = "sci")

## -----------------------------------------------------------------------------
# Compare two formats
DT <- data.table(
  scientific  = format_power(x, 3, format = "sci"),
  engineering = format_power(x, 3)
)
knitr::kable(DT, align = "r", col.names = c("scientific notation", "engineering notation"))

## -----------------------------------------------------------------------------
format_power(0.0678, 3, format = "sci", omit_power = c(-2, 2))
format_power(0.0678, 3, format = "sci", omit_power = c(-1, 2))

## -----------------------------------------------------------------------------
# Omit no values from power-of-ten notation
DT <- data.table(
  scientific  = format_power(x, 3, format = "sci", omit_power = NULL),
  engineering = format_power(x, 3, omit_power = NULL)
)
knitr::kable(DT, align = "r", col.names = c("scientific notation", "engineering notation"))

## -----------------------------------------------------------------------------
# Copy to avoid by-reference changes
DT <- copy(water)

# Convert temperature from K to C
DT <- DT[, .(temp = round(temp - 273.15), visc)]

# Create two columns to compare
DT[, ver1 := format_power(visc, 3)]
DT[, ver2 := format_power(visc, 3, set_power = -3)]

## -----------------------------------------------------------------------------
knitr::kable(DT, align = "r", col.names = c(
  "Temperature [C]", "Viscosity [Pa s]", "engineering notation", "with fixed exponent"
))

## -----------------------------------------------------------------------------
DT <- copy(atmos)
DT <- DT[, .(alt = alt / 1000, dens)]
DT[, ver1 := format_power(dens, 3)]
DT[, ver2 := format_power(dens, 3, set_power = -3)]
DT[, ver3 := format_power(dens, 3, set_power = -3, omit_power = NULL)]

kable(DT, align = "r", col.names = c(
  "Altitude [km]",
  "Density [kg/m$^3$]",
  "engineering notation",
  "with fixed exponent",
  "omit decimals"
))

## -----------------------------------------------------------------------------
# Equivalent usage
w <- format_power(x[1])
y <- format_power(x[1], delim = "$")
z <- format_power(x[1], delim = c("$", "$"))

all.equal(w, y)
all.equal(w, z)

## -----------------------------------------------------------------------------
format_power(x[1], delim = "\\(")
format_power(x[1], delim = c("\\(", "\\)"))

## -----------------------------------------------------------------------------
# Included with formatdown
air_meas

# Render in document
knitr::kable(air_meas, align = "r")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to air_meas
DT <- copy(air_meas)

# Format as a vector
format_power(DT$pres, digits = 4)

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to air_meas
DT <- copy(air_meas)

# Format one column, retain all columns
DT$pres <- format_power(DT$pres, digits = 4)
DT[]

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to air_meas
DT <- copy(air_meas)

# Identify columns to format
cols_we_want <- c("temp", "pres", "dens")

# Select and format.
DT <- DT[, lapply(.SD, function(x) format_power(x, 4)), .SDcols = cols_we_want]
DT[]

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to air_meas
DT <- copy(air_meas)

# Identify columns to format
cols_we_want <- c("temp", "pres", "dens")

# Format selected columns, retain all columns
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 4)), .SDcols = cols_we_want]
DT[]

# Render in document
knitr::kable(DT, align = "r")

