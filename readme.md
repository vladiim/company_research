# Description

A framework for reproducible R analysis.

***

# Objective

The objective is to have simple opinionated framework for reproducible data-analysis in the R language.

***

# Dependencies

* [R](http://www.r-project.org/)

***

# Structure

* `./init.R` is used to

> - Load app package dependencies

> - Load files

> - Load environment variables

> - Set global options

> - Connect to services (databases, external APIs etc)

* Extract data with `./extract/**`

* Save data in `./data/**`

* Load data with `./load/**`

* Transform data in `./transform/**`

* Plotting functions are in `./plots/**`

* Build models in `./models/**`

* Report templates are in `./reports/templates`

* The reporting functions are in `./reports/run.R`.

***

# Running reports

This code base has designed to produce reproducible reporting analysis for Audi. The reports are written in a mix of [Markdown](http://commonmark.org/) and [R](http://www.r-project.org/) in the `./report/template/**` directory.

To run a report:

* Start R within the top-level directory `R`

* Load the initialiser `source('init.R')`

* Run one of the reports within `./report/run.R` e.g. `runReport.test()`

* The output of the report can be found in `./report/output/**`.

_Note_ in order to keep the repository size down, the output of the reports (inc images) has been ignored from Git.

***

# Writing reports: work-flow

A typical workflow might look like the following:

1. Create a file describing your data in `./data/*` e.g. `./data/sales.R`

2. Write functions to get and munge the data as required, prefixed with `data.` e.g. `data.monthlySales()`

3. Create `./plots/sales.R` to graph your insights

4. Write a function using `ggplot2` that corresponds to your data pre-fixed with `graph` e.g. `graph.monthlySales()`

5. Create a new template file in `./reports/templates/*` or edit the existing file `./reports/templates/report.Rmd`

6. If you create a new template ensure

  a) You use the `*.Rmd` file type

  b) You edit the function in `./reports/run.R` to include your new file (you can also create a new function)

7. Write your analysis in [markdown](http://commonmark.org/)

8. Add your graph to `./reports/helpers/report.R` using [knitr](http://yihui.name/knitr/) annotation (ensure you start with `source('../../init.R')` to set the environment in knitr)

9. Include the knitr function name within your reporting template using the example given in `./reports/templates/report.Rmd`

10. When you're ready to run the report, open a terminal within the working dir and run `source('init.R'); runReport()` the output should be a markdown document within `reports/output/*`

***
