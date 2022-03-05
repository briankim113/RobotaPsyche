# Midterm
## Concept
For the midterm, I decided to continue my "fish in the pond" ecology that I started in [February14](/February14).

Taking nature as a source of inspiration, this ecosystem depicts fish swimming in the pond and chasing towards food. Users can click on the screen to drop food particles and essentially feed these fishes. Unfortunately, this pond does not have other sources of food, so if they are not fed by users, these fishes will starve to death.

The following sections further describes my project as well as discoveries I made and challenges I overcame during the process.

## Details
This section lists the details of this project.

- Fish is attracted to food and is repelled by other fish.
    - The float value for forces of attraction / repulsion was calculated through trial and error to make the movements as realistic as possible.
    - Since mass is crucial to attraction, bigger fish are more attracted to food and exert more repulsion toward smaller fish.
    - This observation tries to replicate the "survival of the fittest", as the bigger fish get to eat more food.
- Fish's size reflects their hunger.
    - The fish's mass (aka size) increases every time they eat food.
    - The fish's mass decreases ever so slightly every frame loop.
- Fish dies if they are too hungry.
    - Original starvation was calculated by how long it has been since last time they ate food.
    - New starvation is now calculated by their mass. If they fall below a certain point, they will die.
    - This means that fatter, bigger fish that ate more food will survive longer than thinner ones.
    - Fish that are about to die change their color to red in order to "alert" users.
    - There is a textfield on screen that informs users how many fishes are still alive in the ecosystem.
- If there is no fish left, users can start again by clicking the mouse.
    - A screen of text, as shown in the fourth screenshot below, appears to alert the users that they can restart the ecosystem.
    - This required separating declaration and instantiation of the ArrayList _foods_ and ArrayList _fishes_, so that they can be refreshed and populated with new elements of Fish and Food class.
    - The lists are declared as global variables in the beginning, but are instantiated with the keyword _new_ inside a separate function that is called in the default setup() as well as mouseClicked() when there are no fishes.

## Difficulties
This section lists a few issues that I faced and their solutions.

- Changed the collision check between fish and food inside the eatCheck()
    - It now detects the fish triangle like it would a circle, but this ensures that the collision actually takes into consideration the growing and shrinking size / mass of the fish.
- Deleted checkEdges() completely
    - It took me this long to realize that the fishes weren't doing anything at the edge of the screen becausse... I actually never called the checkEdges() inside the actual draw(). But I liked the Professor's comment about how he likes the idea of letting these creatures take up an infinite amount of space, of which we just get a glimpse of the canvas size. So I decided to get rid of the function completely and let the fishes swim along freely.
- Made the fishes' movement less chaotic
    - When the fishes swam too far away from the screen, the attraction of the food made the acceleration (and hence the velocity) too great. So eventually, the fishes started swimming way too fast, zooming across the canvas.
    - I first addressed this issue by fixing the initial size and force/gravity for fish and food through trial and error.
    - Then, I added a few food particles from the get go, so that the fishes aren't just swimming away from each other and dispersing off the screen in the beginning.
    - Finally, I use the PVector.limit() to limit the fish velocity. The magnitude was again decided through trial and error.
    - But in the process of making the ecosystem "less chaotic", I could not help but wonder how I am "artificially" designing an ecosystem that aspires to reflect a natural setting. Could the chaotic behavior that I have in the beginning be the "true" ecosystem?

## Resources
There are a couple of resources that helped my midterm project, in no particular order.
1. In-class code from the [course website](https://github.com/michaelshiloh/robotaPsyche)
2. Official Processing [documentation](https://processing.org/reference), especially regarding [PVector](https://processing.org/reference/PVector.html)
3. Web [post](https://hellocircuits.com/2013/10/08/simple-object-trails-in-processing/) about how to implement a trail following an object

## Video and Screenshots
[Video Link](https://youtu.be/KkOpw0Tz7oQ)
![](/midterm/Screenshot1.png)
![](/midterm/Screenshot2.png)
![](/midterm/Screenshot3.png)
![](/midterm/Screenshot4.png)
