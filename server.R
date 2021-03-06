library(shiny)

source('getChords.R')

# Define server logic that generates a model from a small dataset of a given artist 
#and transposes the key as needed.  Math of the key assumes major scale, so for the sake of
#simplicity all 2 and 6 chords will be treated as minor in the output
shinyServer(function(input, output) {
  chord<-reactive({
      getChords(input$artist, input$part, input$key, input$nChords)
  })
  songsUsed<-reactive({
      if(input$artist == "Taylor Swift"){
         "Here's a chord sequence generated from a Markov Model trained on the songs 'Blank Space', 'Love Story', and 'We Are Never Getting Back Together':"
      }
      else if(input$artist == "Nicki Minaj"){
          "Here's a chord sequence generated from a Markov Model trained on the songs 'Fly', 'Superbass' and 'See Thru Me':"
      }
      else if(input$artist == "Katy Perry"){
          "Here's a chord sequence generated from a Markov Model trained on the songs 'California Gurls', 'Piece of Me' and 'Roar':"
      }
  })
  output$songs<-renderText({
        print(songsUsed())
  })
  output$chords<-renderText({print(chord())})
  output$description<-renderText("This application generates chord progressions between 3 and 6 chords long based on a probabilistic 
                                 'markov' model that is generated by averaging 
                                transition probabilities between chords for 3 songs from 3 different pop artists.  To use the application, simply select your favorite artist,
                                 song part, and a number of chords then hit 'Submit'.")
})