
library(shiny)
library(shinythemes)
library(bslib)
library(data.table)
library(shinycssloaders)
library(DT)
library(rmarkdown)
library(markdown)
library(shinyBS)
library(rintrojs)
library(shinyjs)

#Creating big boxes for main tabs in the landing page (see ui for formatting css)
lp_main_box <- function(title_box, image_name, button_name) {
      div(class="landing-page-box",
      div(title_box, class = "landing-page-box-title"),
      div(class = "landing-page-icon", style= paste0("background-image: url(", image_name, ".png);
          background-size: auto 80%; background-position: center; background-repeat: no-repeat; ")),
      actionButton(button_name, NULL, class="landing-page-button")
      )
}

#creatLink for pigQTLdb
qtlLink <- function(val,qtl){
  sprintf('<a href="https://www.animalgenome.org/cgi-bin/QTLdb/SS/qdetails?QTL_ID=%s" target="_blank" class="btn btn-primary">%s</a>',val,qtl)
  }

