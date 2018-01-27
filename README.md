# AgroShine - The first atempt to visualize the BBGC-MuSo modell throught RBBGCMuso

## Introduction

The AgroShine repository is the first atempt to creating GUI for the BBGC-MuSo modell, which will be a part of the bigger AgroMo multi (or meta) modell. The Agromo is an integrated biogeochemical framework for agriculture, which works well for the hungarian climatical environment. Further information on the project: (http://www.agrar.mta.hu/hu/kutatomuhely_sajtok)

## AgroShine goals

To use the BBGC-MuSo model use have to provide several imput files(meteo., ecophys.,init.,...). Handle these manually is quite difficoult, and require additional programs for example text editors, furthermore use can only use commandline with no interface. In spite of the accuracy and feature-richness of the modell these features are hard to be exploited.

AgroShine will provide a convinient web based interface to BBGC-MuSo, to make the modell user-friendly enough to use in AgroMo.

## Tools and methods

We chose one of the simpliest and most robust way for creating GUI: [RShiny](https://shiny.rstudio.com/) and [Plotly](https://plot.ly/). To use these package, we have to posess a framework in [R](https://www.r-project.org/) for it. For this purpuse we created an R package, called: [RBBGCMuso](https://github.com/hollorol/RBBGCMuso).

## Tasks
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item



