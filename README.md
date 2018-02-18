# AgroShine - The first attempt to visualize the Biome-BGCMuSo model throught RBBGCMuso

## Introduction

The AgroShine repository is the first attempt to create a GUI for the [Biome-BGCMuSo model](http://nimbus.elte.hu/bbgc/), which will be a part of the bigger AgroMo multi (or meta) model. The Agromo is an integrated biogeochemical framework for agriculture, which works well for the Hungarian climatical environment. Further information on the project: (http://www.agrar.mta.hu/hu/kutatomuhely_sajtok)

## AgroShine goals

To use the Biome-BGCMuSo model users have to provide several input files (meteo., ecophys., init., ...). Handling of these files manually is quite difficult and requires additional programs, for example text editors, furthermore the users can only use command line with only a basic interface. In spite of the accuracy and feature-richness of the modell these [features] are hard to be exploited.

AgroShine will provide a convinient web based interface to Biome-BGCMuSo, to make the model user-friendly enough to use in AgroMo.

## Tools and methods

We chose one of the simplest and most robust way for creating GUI: [RShiny](https://shiny.rstudio.com/) and [Plotly](https://plot.ly/). To use these packages, we have to posess a framework in [R](https://www.r-project.org/) for it. For this purpuse we created an R package, called: [RBBGCMuso](https://github.com/hollorol/RBBGCMuso). To make AgroShine a native-like app, we use [Electron](https://electronjs.org/). 

## Tasks

### January - 2018

- [x] Creating github organisation, repository (task 1)
- [x] Creating first README file for Github. (task 2)
- [x] Examining [grammer of graphics](http://www.springer.com/gp/book/9780387245447), and make some good plot for MuSo (task 3)
- [x] Examining [Plotly](https://plot.ly/) and make some interactive graphics (task 4)
- [x] Examining [dlpyr](http://dplyr.tidyverse.org/) package for faster database handling, learn the base conception, and change every dataframe (task 5)
- [x] Examining [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html) package for pipelining capabilities (task 6)
- [x] Examining [RShiny](https://www.r-project.org/) and make a simple web application (task 7)
- [x] Making a demo application for the meeting (2018-01-31) (task 8) 

### February - 2018
- [x] Learning the basincs of GIS with GRASS, QGIS (task 9)
- [x] Examining sp package in R. (task 10)
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
