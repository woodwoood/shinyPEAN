
gwas <- read.table("data\\GWAS_enhancer_QTLdb_pigSS11.1.txt",sep="\t",header=TRUE)

enhancer <- read.table("data\\total_putative_enhancer_messages.txt",sep="\t",header=TRUE)

tagList( #needed for shinyjs
  useShinyjs(),  # Include shinyjs
  introjsUI(),   # Required to enable introjs scripts
    titlePanel("  shinyPEAN: a shiny APP of Pig Enhancer and its Annotation"),
      navbarPage(
           title = div(tags$a(img(src="pig_title.png", height=40)),
                      style = "position: relative; top: -5px;"), 
           windowTitle = "Pig", 
           theme = shinytheme("journal"), #Theme of the app 
           collapsible = TRUE, #tab panels collapse into menu in small screens
           header = tags$head(includeCSS("www/styles.css") # CSS styles
							                              ),
			    tabPanel("Home",
                      fluidRow(
						  br(),
						   column(width=2), 
                                  column(
                                    h4(p("Diagrams of Pig Enhancer Database",style="color:black;text-align:center")),
                                       width=8,style="background-color:#4e8eb3;border-radius: 10px")),
                                  br(),
							      br(),
							#1st row of boxes	  
			                 fluidRow(
                               column(6, class="landing-page-column",
			                     br(), #spacing
                                  introBox(
                                     lp_main_box(image_name = "density_total_enhancer", 
                                                 button_name = 'btn_indicator_updates', 
								                 title_box = "Distribution map of putative enhancers on pig chromosome"),
                                  data.step = 1,
                                  data.intro = h5("The profile summary "),
                                  data.position = "bottom-right-aligned")),
								  
                               column(6, class="landing-page-column",
                                 br(), #spacing
                                  introBox( 
                                    lp_main_box(image_name= "GSE143288enhancer_number", 
                                                button_name = 'btn_length', 
								                title_box = "Number of putative enhancers in different tissues"),
                                    data.step = 2,
                                    data.intro = h5("The 'Data' window can be used to filter and download profiles data"),
									data.position = "bottom-left_aligned"))),
                            #2nd row of boxes
                          fluidRow(
                             br(), #spacing
                             column(8, style = "padding-left: 0px; padding-right: 0px;", 
                                 introBox( 
                                 data.step = 3,
                                 data.intro = h5("The trend and rank charts allow detailed exploration of one indicator at a time."),
                             column(6, class="landing-page-column",
                                 lp_main_box(image_name= "GSE158430enhancer_number", 
                                             button_name = 'jump_to_trend', 
								             title_box = "Number of putative enhancers in different tissues")),
                
                             column(6, class="landing-page-column",
                                  lp_main_box(image_name= "enhancer_distribution", 
                                              button_name = 'jump_to_rank', 
								              title_box = "Number of putative enhancers in gene structure")))),
											  
                             column(4, class="landing-page-column",
                                  introBox(
                                  data.step = 4,
                                  data.intro = h5("The inequalities module in profiles tool."),
                                  lp_main_box(image_name= "GWAS_distribution", 
                                              button_name = 'jump_to_ineq', 
								              title_box = "Distribution of GWAS sites in pig genome region")
											  ))),
                                br(),
							    br(),
							    br(),
                           fluidRow(
						         column(width=2),
                                 column(
                                   p("The dataset of pig putative enhancer identified by ChIP-seq is comprises 
								     of genome position, sequence characteristic, breed, tissue and
									 pig QTL association data ,you can query what you want.",style="color:black;text-align:center"),
                                   width=8,style="background-color:#eb6864;border-radius: 10px")),
                           br()),
						   
				navbarMenu("Search",
				    tabPanel("Table", 
                             fluid = TRUE,
                      fluidRow(
                          column(3,
                             titlePanel("Query"),
							 br(),
							 helpText("."),
							   br(),
							   hr(),
							   selectInput(
                                    inputId = "tissue",
                                    label = "Tissue:",
                                    choices = c("All",sort(unique(as.character(enhancer$Tissue)))),
									width = "220px"),
								br(),
								br(),
						       selectInput(
                                    inputId = "chr",
                                    label = "Chromosome:",
                                    choices = c("All",unique(as.character(enhancer$Chr))),
									width = "220px"),
                                br(),
                                numericInput(
							          inputId = "position",
                                      label = "Position:",
                                      value = "1",
                                      width = "200px"),
                                hr()),
                          column(9,
                             fluidRow(
						     #uiOutput("modals"),
						     DT::dataTableOutput(outputId = "enhancer")),
                          hr()),
                          br())),
             
			        tabPanel("Associations",fluid = TRUE,
			               titlePanel("QTN within pig putative enhancer"),
                           
                           hr(),
                           fluidRow(
                               DT::dataTableOutput(outputId = "qtlgwas"))
							   )),

				tabPanel("User Guide",
				          fluidRow(
						  includeMarkdown('user_guide.rmd')))
						  ))