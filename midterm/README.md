# Midterm
## Concept
## Process
1. Fixed the eatCheck() function to consider the triangle similar to a circle with a radius
2. Made the actual size of the fish be reflective of their hunger
    1. Their mass / size decreases ever so slightly for every frame
    2. Their mass increases when they eat
3. Changed the death logic from timer to mass
    1. This means that bigger fish have "longer time" until their death
4. Make the movement less chaotic
    1. Fixed the starting size and gravity for fish and food
    2. Add few food particles from the get go, so that fish are not just dispersing from the start
    3. Limit the fish velocity magnitude so it is not zooming across the screen really fast
    4. But as I am making it less chaotic, am I creating an "artificial" ecosystem the way I think it should work?
5. Add "endangerment" color if mass drops to a dangerous level
    1. Thought about in what ways we could communicate to the animals
6. Added a screen about starting new, and you can just click the mouse again
    1. Had to differentiate declaration and instantiation of foods and fishes ArrayLists
    2. Declaration done outside on the top for global variables
    3. Instantiation inside a separate function that is called in setup() and mouseClicked() so information is "rewritten" with the = new ArrayList<>()

## Difficulties
## Discoveries
## Resources
