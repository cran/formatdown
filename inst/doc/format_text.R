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



options(formatdown.font.size = "small")

## -----------------------------------------------------------------------------
x <- c("low", "med", "high")

# Compare formats
DT <- data.table(
  scriptsize = format_text(x, size = "scriptsize"),
  small      = format_text(x, size = "small"),
  normalsize = format_text(x, size = "normalsize"),
  large      = format_text(x, size = "large"),
  huge       = format_text(x, size = "huge")
)
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Compare formats
DT <- data.table(
  plain  = format_text(x, face = "plain"),
  italic = format_text(x, face = "italic"),
  bold   = format_text(x, face = "bold"),
  sans   = format_text(x, face = "sans"),
  mono   = format_text(x, face = "mono")
)
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
format_text("R_e")
format_text("m^3")

## -----------------------------------------------------------------------------
format_text("R\\_e")
format_text("m\\verb|^|3")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to air_meas
DT <- copy(air_meas)

# Format selected columns to 4 digits
cols_we_want <- c("temp", "pres", "dens")
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 4)), .SDcols = cols_we_want]

# Treat the gas constant with 3 digits
DT$sp_gas <- format_power(DT$sp_gas, digits = 3)

# View the result
DT[]

# Render in document
knitr::kable(DT,
  align = "r",
  caption = "Table 1. Numerical columns formatted; text columns unformatted.",
)

## -----------------------------------------------------------------------------
# Format selected columns as text
cols_we_want <- c("date", "trial", "humid")
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_text(x)), .SDcols = cols_we_want]

# View the result
DT[]

# Render in document
knitr::kable(DT,
  align = "r",
  caption = "Table 2. Text columns formatted to match",
)

## -----------------------------------------------------------------------------
# Assign arguments to be used from this point forward in the script
options(
  formatdown.font.size = "large",
  formatdown.font.face = "italic"
)

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
  caption = "Table 3. Using `option()` for size size and face",
)

