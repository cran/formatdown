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
# Scalar value assigned a measurement unit
x <- 101300
units(x) <- "Pa"

# Original value
format_units(x, big_mark = ",")

# Convert to hPa
format_units(x, unit = "hPa")

# Convert to psi
format_units(x, digits = 3, unit = "psi")

## -----------------------------------------------------------------------------
library(formatdown)
library(data.table)
suppressPackageStartupMessages(library(units))
library(knitr)

## -----------------------------------------------------------------------------
x <- 101300
units(x) <- "Pa"

## -----------------------------------------------------------------------------
# Variable is class numeric
x <- atmos$alt
x
class(x)

## -----------------------------------------------------------------------------
x_char <- format_units(x, unit = "m")
x_char

## -----------------------------------------------------------------------------
# Assign units before formatting
units(x) <- "m"
x
class(x)

## -----------------------------------------------------------------------------
# Covert units and format as character
x_char <- format_units(x, unit = "km")
x_char

## -----------------------------------------------------------------------------
x <- sort(atmos$temp, decreasing = TRUE)
format_units(x, digits = 4, unit = "K")

## -----------------------------------------------------------------------------
format_units(x, digits = 3, unit = "K")

## -----------------------------------------------------------------------------
# Values are not converted to 2 significant digits
format_units(x, digits = 2, unit = "K")

# Apply signif() before formatting
format_units(signif(x, 2), unit = "K")

## -----------------------------------------------------------------------------
x <- sort(metals$elast_mod, decreasing = TRUE)
units(x) <- "Pa"
format_units(x, digits = 3, unit = "GPa")

## -----------------------------------------------------------------------------
# Data set included with formatdown
DT <- copy(atmos)

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
units(DT$alt) <- "m"
DT[, alt := format_units(alt, unit = "km")]

units(DT$temp) <- "K"
DT[, temp := format_units(temp, 3, unit = "deg_C")]

units(DT$pres) <- "Pa"
DT[, pres := format_units(pres, unit = "hPa")]

units(DT$dens) <- "kg/m^3"
DT[, dens := format_units(dens, unit = "g/m^3", unit_form = "implicit")]

units(DT$sound) <- "m/s"
DT[, sound := format_units(sound, 4)]

knitr::kable(
  DT,
  align = "r",
  col.names = c("Altitude", "Temperature", "Pressure", "Density", "Speed of sound")
)

## -----------------------------------------------------------------------------
# Data set included with formatdown
DT <- copy(atmos)

units(DT$alt) <- "m"
DT[, alt := format_units(alt, unit = "ft")]

units(DT$temp) <- "K"
DT[, temp := format_units(temp, 2, unit = "deg_F")]

units(DT$pres) <- "Pa"
DT[, pres := format_units(pres, unit = "psi")]

units(DT$dens) <- "kg/m^3"
DT[, dens := format_units(dens, unit = "lb/ft^3", unit_form = "implicit")]

units(DT$sound) <- "m/s"
DT[, sound := format_units(sound, 4, unit = "ft/s")]

knitr::kable(
  DT,
  align = "r",
  col.names = c("Altitude", "Temperature", "Pressure", "Density", "Speed of sound")
)

## -----------------------------------------------------------------------------
# Start with the original density vector
x <- atmos$dens

# Assign the original units
units(x) <- "kg/m^3"

# Display a representative value
x[5]

## -----------------------------------------------------------------------------
# Convert to US Customary units
display_units <- "lb ft-3"
units(x) <- display_units

# Display the same representative value
x[5]

## -----------------------------------------------------------------------------
# Convert the vector to numeric values
x <- as.numeric(x)

# Display the representative value
x[5]

## -----------------------------------------------------------------------------
# Apply power of ten notation using format_power()
x <- format_power(x, digits = 3, format = "sci")

# Display the representative value
x[5]

## -----------------------------------------------------------------------------
# Append units string to value strings
x <- paste0(x, " [", display_units, "]")

# Display the representative value
x[5]

## -----------------------------------------------------------------------------
# Substitute for column in the data frame from above
DT[, dens := x]

knitr::kable(
  DT,
  align = "r",
  col.names = c("Altitude", "Temperature", "Pressure", "Density", "Speed of sound")
)

