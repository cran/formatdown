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
x <- c(1.2E-6, 3.4E+0, 5.6E+13)

# Compare formats
DT <- data.table(
  scriptsize = format_power(x, 2, size = "scriptsize"),
  small      = format_power(x, 2, size = "small"),
  normalsize = format_power(x, 2, size = "normalsize"),
  large      = format_power(x, 2, size = "large"),
  huge       = format_power(x, 2, size = "huge")
)
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
format_power(0.0678, 3, format = "sci", omit_power = c(-2, 2))
format_power(0.0678, 3, format = "sci", omit_power = c(-1, 2))

## -----------------------------------------------------------------------------
format_power(6789, 3, format = "sci", omit_power = c(-1, 2))
format_power(6789, 3, format = "sci", omit_power = c(-1, 3))

## -----------------------------------------------------------------------------
# Omit no values from power-of-ten notation
DT <- data.table(
  scientific  = format_power(x, 3, format = "sci", omit_power = NULL),
  engineering = format_power(x, 3, omit_power = NULL)
)
knitr::kable(DT, align = "r", col.names = c("scientific notation", "engineering notation"))

## -----------------------------------------------------------------------------
x <- c(3.2e-7, 4.5e-6, 4.5e-5, 6.7e-4, 3, 37800)
format_power(x, 3, format = "sci", omit_power = c(-5, -5))
format_power(x, 3, format = "engr", omit_power = c(-5, -5))

## -----------------------------------------------------------------------------
# Copy to avoid by-reference changes
DT <- copy(water)

# Convert temperature from K to C
DT <- DT[, .(visc)]

# Create two columns to compare
DT[, ver1 := format_power(visc, 3)]
DT[, ver2 := format_power(visc, 3, set_power = -3)]

## -----------------------------------------------------------------------------
knitr::kable(DT, align = "r", col.names = c(
  "$\\small\\mu$ [Pa s]", "engr notation", "set power"
))

## -----------------------------------------------------------------------------
DT <- copy(atmos)
DT <- DT[, .(dens)]
DT[, ver1 := format_power(dens, 3)]
DT[, ver2 := format_power(dens, 3, set_power = -3)]
DT[, ver3 := format_power(dens, 3, set_power = -3, omit_power = NULL)]

kable(DT, align = "r", col.names = c(
  "$\\small\\rho$ [kg/m$^3$]",
  "engr notation",
  "set power",
  "set power, omit none"
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

# Treat the gas constant with 3 digits
DT$sp_gas <- format_power(DT$sp_gas, digits = 3)
DT[]

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Assign arguments to be used from this point forward in the script
options(formatdown.power.format = "sci")
options(formatdown.font.size = "scriptsize")

# Copy to avoid "by reference" changes to air_meas
DT <- copy(air_meas)

# Format selected columns to 4 digits
cols_we_want <- c("temp", "pres", "dens")
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 4)), .SDcols = cols_we_want]

# Treat the gas constant with 3 digits
DT$sp_gas <- format_power(DT$sp_gas, digits = 3)

# Format selected columns as text
cols_we_want <- c("date", "trial", "humid")
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_text(x)), .SDcols = cols_we_want]

# Render in document
knitr::kable(DT,
  align = "r",
  caption = "Table 1: Multiple readings for calculating air density",
  col.names = c(
    "Date",
    "Trial",
    "Humidity",
    "$\\small\\theta$ [K]",
    "$\\small P$ [Pa]",
    "$\\small R_{sp}$ [J kg$^{-1}$K$^{-1}$]",
    "$\\small\\rho$ [kg/m$^3$]"
  )
)

