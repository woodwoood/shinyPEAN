
shinyServer (function(input, output,session) {

   updates_modal1 <- modalDialog(
       fluidRow(
       
      column(12, 
			img(src='density_total_enhancer.png')
      )),
	  size= "xl",
      easyClose = TRUE, 
	  fade=TRUE, 
	  footer = modalButton("Close (Esc)"))
  
  observeEvent(input$btn_indicator_updates, { showModal(updates_modal1) }) 
  
  updates_modal2 <- modalDialog(
       fluidRow(
      column(12, 
			img(src='GSE143288enhancer_number.png')
      )),
	  size= "xl",
      easyClose = TRUE, 
	  fade=TRUE, 
	  footer = modalButton("Close (Esc)"))
  
  observeEvent(input$btn_length, { showModal(updates_modal2) }) 
  
  updates_modal3 <- modalDialog(
       fluidRow(
         column(12, 
			img(src='GSE158430enhancer_number.png')
      )),
	  size= "xl",
      easyClose = TRUE, 
	  fade=TRUE, 
	  footer = modalButton("Close (Esc)"))
  
  observeEvent(input$jump_to_trend, { showModal(updates_modal3) }) 
  
   updates_modal4 <- modalDialog(
       fluidRow(
        
      column(12, 
            img(src='enhancer_distribution.png')
      )),
	  size= "xl",
      easyClose = TRUE, 
	  fade=TRUE, 
	  footer = modalButton("Close (Esc)"))
  
  observeEvent(input$jump_to_rank, { showModal(updates_modal4) }) 
  
  updates_modal5 <- modalDialog(
       fluidRow(
        
      column(12,
	        img(src='GWAS_distribution.png')  

	  )),
	  size= "xl",
      easyClose = TRUE, 
	  fade=TRUE, 
	  footer = modalButton("Close (Esc)"))
  
  observeEvent(input$jump_to_ineq, { showModal(updates_modal5) }) 
  
  
  
  output$enhancer<-DT::renderDataTable(
  {
      if (input$chr != "All"){
          enhancer  <- enhancer[enhancer$Chr == input$chr,]}
	  if (input$tissue != "All"){
          enhancer  <- enhancer[enhancer$Tissue == input$tissue,]}
		enhancer},
		
       caption = 'Table', 
       rownames = FALSE,
	   extensions = 'FixedColumns',
	   options = list(
				   columnDefs = list(list(className = 'dt-center', targets = 10)),
                                        pageLength = 10,
                                      lengthMenu = c(5, 10, 15, 20),
				 
				  dom = 'ft',
				  scrollX = TRUE,
				  fixedColumns = list(leftColumns = 1, rightColumns = 1)))

	gwasenhancer <- reactive({
	  tmp <- gwas
	  tmp$QTL_ID <- qtlLink(tmp$QTL_ID,tmp$QTL_ID)
	  tmp
	}) 
	
   output$qtlgwas <- DT::renderDataTable(
         #{if (input$chro!= "All"){
           # gwas  <- gwas[gwas$Chr == input$chro,]}
	        # gwas},
			 gwasenhancer(),
			 escape = FALSE,
			 rownames=FALSE,
			# colnames=c('v1'=Chr","v2"="Start","End","Tissue",'Breed','GC rate','CpG number','Exp/Obs','Structure',
			      #        'Upstream_GENE','Upstream_ENS','Upstream_TSS','up_chain','Upstream_distance(bp)',
					#	  'Downstream_GENE','Downstream_ENS','Downstream_TSS','down_chain','Downstream_distance(bp)','GSE accession'),
			 filter='bottom',
             options = list(lengthMenu = c(5, 10, 20), pageLength = 5))

} )

