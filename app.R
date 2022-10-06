library(shiny)

# --------------------------------------------------
# UI
# --------------------------------------------------

ui <- fluidPage(
  fileInput('upload', NULL, 
            buttonLabel = 'Subir Jupyter Notebook', 
            multiple = FALSE, accept = c('.ipynb')),
  downloadButton('download', 'Descargar .Rmd'),
  tableOutput('files')
)

server <- function(input, output, session) {
  output$files <- renderTable(input$upload)
  
  # notebook <- reactive({
  #   req(input$upload)
  #   
  #   extension <- tools::file_ext(input$upload$name)
  #   switch(
  #     extension,
  #     ipynb = rmarkdown::convert_ipynb(
  #       input = input$upload$datapath,
  #       output = 'output.Rmd'
  #       ),
  #     validate('Archivo no válido; Por favor, suba un archivo .ipynb')
  #   )
  # })
  
  output$download <- downloadHandler(
    filename = function() {
      'output.ipynb'
    },
    content = function() {
      rmarkdown::convert_ipynb(input$upload$datapath, 'output.Rmd')
    }
  )
}

shinyApp(ui, server)
