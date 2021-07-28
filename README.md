# my_poem
This app is intented to be a fun app to show and test your memorizing skills. All poems selected are by chance with no specific theme.

There are three components to the app

1. The poem library
- Each poem is saved as an individual text file with the following structure
  + Line 1: title
  + Line 2: blank -----
  + Line 3: poet
  + Line 4: source or poem collection
  + Line 5: year
  + Line 6: blank -----
  + Line 7+: poem text

2. Poem data processing or poem_list.R: process all the text files from the poem library
- input: poems folder
- output: poem_list.csv

2. The app design
- Poem library: list of all the poems currently saved
- Game 1: 
 + click Draw your poem to draw a poem title at random
 + recite the poem from your memory
 + click the Answer button to see the poem text
 
- Game 2: 
 + click Draw your cue to draw a line from a poem at random
 + recite the poem from your memory
 + click the Answer to see the poem text (TODO)
 
 - Game 2: 
 + Select a poem from th drop-down menu
 + recite the poem from your memory
 + click the Show the poem to see the whole poem
