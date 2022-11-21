## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("formatdown")
library("data.table")

# data.table printout
options(
  datatable.print.nrows = 15,
  datatable.print.topn = 3,
  datatable.print.class = TRUE
)

## -----------------------------------------------------------------------------
library("formatdown")
library("data.table")

## -----------------------------------------------------------------------------
# Numerical value
avogadro <- 6.0221E+23

# Arguments named
(x <- format_power(x = avogadro, digits = 3))

# Arguments unnamed
y <- format_power(avogadro, 3)

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
format_power(x[3], format = "sci")
format_power(x[3], format = "engr")

## -----------------------------------------------------------------------------
# Compare two formats
DT <- data.table(
  scientific  = format_power(x, format = "sci"),
  engineering = format_power(x)
)
knitr::kable(DT, align = "rr")

## -----------------------------------------------------------------------------
format_power(x[6], omit_power = c(-1, 3))
format_power(x[6], omit_power = c(0, 3))

## -----------------------------------------------------------------------------
# Omit no values from power-of-ten notation
DT <- data.table(
  scientific = format_power(x, format = "sci", omit_power = NULL),
  engineering = format_power(x, omit_power = NULL)
)
knitr::kable(DT, align = "rr")

## -----------------------------------------------------------------------------
density

## -----------------------------------------------------------------------------
knitr::kable(density, align = "ccrrr")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to density
DT <- copy(density)

# Format as a vector
format_power(DT$p_Pa, digits = 4)

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to density
DT <- copy(density)

# Format one column, retain all columns
DT$p_Pa <- format_power(DT$p_Pa, digits = 4)
DT[]

## -----------------------------------------------------------------------------
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to density
DT <- copy(density)

# Identify columns to format
cols_we_want <- c("T_K", "p_Pa", "density")

# Select and format.
DT <- DT[, lapply(.SD, function(x) format_power(x, 4)), .SDcols = cols_we_want]
DT[]

## -----------------------------------------------------------------------------
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to density
DT <- copy(density)

# Identify columns to format
cols_we_want <- c("T_K", "p_Pa", "density")

# Format selected columns, retain all columns
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 4)), .SDcols = cols_we_want]
DT[]

## -----------------------------------------------------------------------------
knitr::kable(DT, align = "ccrrr")

## -----------------------------------------------------------------------------
# Copy to avoid "by reference" changes to density
DT <- copy(density)

# Format selected columns, retain all columns with signif digits = 5
cols_we_want <- c("T_K", "density")
DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 5)), .SDcols = cols_we_want]

# Individually format one column with signif digits = 4
DT$p_Pa <- format_power(DT$p_Pa, 4)
DT[]

## -----------------------------------------------------------------------------
knitr::kable(DT, align = "ccrrr")

## -----------------------------------------------------------------------------
x <- density$date
format_power(x)

## -----------------------------------------------------------------------------
x <- density$trial
format_power(x)

## -----------------------------------------------------------------------------
x <- density$humidity
format_power(x)

