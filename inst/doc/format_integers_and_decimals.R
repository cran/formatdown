## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

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
# Data set included with formatdown
DT <- copy(atmos)

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Apply power of ten notation to one column
DT$dens <- format_power(DT$dens, digits = 3, set_power = -3)

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Format one column as an integer
DT$alt <- format_decimal(DT$alt / 1000, 0)

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Name the columns to be formatted
cols_to_format <- c("temp", "sound")

# Use data.table .SD syntax with lapply()
DT[, (cols_to_format) := lapply(.SD, function(x) format_decimal(x, 1)), .SDcols = cols_to_format]

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Hundreds and higher, integers. Create a temporary variable
DT[pres > 99, temp_pres := format_decimal(pres, 0, big_mark = ",")]

# Units place or lower, 2 decimal places
DT[pres <= 10, temp_pres := format_decimal(pres, 2)]

# In-between those two ranges, 1 decimal place
DT[pres > 10 & pres <= 99, temp_pres := format_decimal(pres, 1)]

# Overwrite the original and delete the temporary column
DT[, pres := temp_pres]
DT[, temp_pres := NULL]

# Render in document
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Render in document
knitr::kable(DT,
  align = "r",
  caption = "Table 1. Atmospheric varables as a function of altitude",
  col.names = c(
    "Altitude [km]",
    "Temperature [K]",
    "Pressure [Pa]",
    "Density [kg/m$^3$]",
    "Speed of sound [m/s]"
  )
)

