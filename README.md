# AgroShine - The first atempt to visualize the BBGC-MuSo modell throught RBBGCMuso

## Introduction

The AgroShine repository is the first atempt to creating GUI for the BBGC-MuSo modell, which will be a part of the bigger AgroMo multi (or meta) modell. The Agromo is an integrated biogeochemical framework for agriculture, which works well for the hungarian climatical environment. Further information on the project: (http://www.agrar.mta.hu/hu/kutatomuhely_sajtok)

## AgroShine goals

To use the BBGC-MuSo model use have to provide several imput files (meteo., ecophys.,init.,...). Handle these manually is quite difficoult and require additional programs for example text editors, furthermore the users can only use commandline with only a basic interface. In spite of the accuracy and feature-richness of the modell these [features] are hard to be exploited.

AgroShine will provide a convinient web based interface to BBGC-MuSo, to make the modell user-friendly enough to use in AgroMo.

## Tools and methods

We chose one of the simpliest and most robust way for creating GUI: [RShiny](https://shiny.rstudio.com/) and [Plotly](https://plot.ly/). To use these package, we have to posess a framework in [R](https://www.r-project.org/) for it. For this purpuse we created an R package, called: [RBBGCMuso](https://github.com/hollorol/RBBGCMuso). To make AgroShine a native-like app, we use [Electron](https://electronjs.org/). 

## Tasks

### January - 2018

- [x] Creating github organisation, repository (task 1)
- [x] Creating first README file for Github. (task 2)
- [x] Examining [grammer of graphics](http://www.springer.com/gp/book/9780387245447), and make some good plot for MuSo (task 3)
- [x] Examining [Plotly](https://plot.ly/) and make some interactive graphics (task 4)
- [x] Examining [dlpyr](http://dplyr.tidyverse.org/) package for faster database handling, learn the base conception, and change every dataframe (task 5)
- [x] Examining [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html) package for pipelining capabilities (task 6)
- [x] Examining [RShiny](https://www.r-project.org/) and make a simple web application (task 7)
- [ ] Making a demo application for the meeting (2018-01-31) (task 8) 

### February - 2018

- [ ] Design an interface between RBBGCMuso and the graphical environment.
- [ ] Examining [Electron](https://electronjs.org/)
- [ ] Making an easy Electron app.
- [ ] Establish the fundamental principles of the aestetics.
- [ ] Creating graphical themes.
- [ ] Presentation of the second demo app.

### March - 2018

- [ ] Addig wished features
- [ ] Creating installer for Linux and Mac
- [ ] Convert Agroshine to a full native app, version 0.1
- [ ] Creating installer for Windows
- [ ] Presentation of the beta-version of MusoShine, version 0.5

### April - 2018

To Be Continued ... 
