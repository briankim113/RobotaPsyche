# February28

## Description
Make progress on your midterm project either by elaborating on your February14 ecology.

* Each creature should have some different characteristics such as maximum speed, maximum force, hunger threshold, size, aggression factor, etc. Group all of these in a new class called "DNA". You don't need to implement it yet, but think about how two (or more?) creatures might reproduce to create a creature that has some mix of the parent's DNA. The later goal will be to see if our creatures can "improve" through natural selection.
* Be creative, whimsical, and experimental! You don't need to accurately depict real life. Make up imaginary creatures and their behaviors. Think outside the box! This is not required but is allowed and encouraged.
* Consider what else your mouse can do: enhance (or not) individual creators, change a flow field (wind, water current, a high mountain).
* Try to incorporate some of the new things we've learned in order to give your ecology a more interesting behavior.

## Code Highlights
1. I made usage of ArrayList for both fishes and foods to be able to insert and remove them from the list without worrying about setting elements to null and dealing with all kinds of errors and exceptions that may be raised.
2. We now have 10 fishes to start with and if they don't eat within a given amount of time (10 seconds), they will die of hunger! You can also keep track of how many are alive at the moment via text on the screen.
3. We can now actually use mouseClicked() function to "drop" the food particles into our canvas. Cause as much chaos as you want by adding many food particles. Or let fish swim away from each other by having none at all.
4. I encountered some unintentional behaviors that emerged through the changes I made for this week. First, in the beginning, before users put in any food, all the fish have no attractors, so they slowly push each other off the screen. Once there is at least one food particle, they start coming back. Second, when there are so many food particles on the screen, havoc ensues. It gets even better as fish gets bigger and thus have more mass which increases the attraction force.
5. Minor details
   1. I added push() and pop() to display() functions inside Food class and Fish class so that the style changes don't affect each other and with the screen.
   2. I made the mass increase smaller per food particle because I added way too much food once, and all the fish became half the screen size...

## Further Directions
1. The biggest challenge I faced is regarding the Fish.eatCheck() function. The location check that I had before did not take the fish's size into account. This meant that even though the fish was getting bigger, it was only looking at the center point of the fish triangle and not its entirety. I want the food to be eaten if it "enters" the fish triangle. So, inside the location check, I am now using 5*mass, which is used in the Fish.display() as part of the parameter for triangle(). But after trying to print some data for debugging, I don't think this behavior is exactly what I want to display either.
   1. Right now, the fish's location.x and location.y are the coordinates of the center point of this triangle. But because we have the fading water trail (which is an array of these triangles) as well as the translate() / rotate() functions that help us draw the fish in the display(), figuring out the triangle's "boundary" is geometrically so messy. Having fish be circles would make this very easy, but then fish won't look like fish.
2. I am thinking about having an event be triggered when fish are all dead and there are no more fish. A simple idea would be to reset everything after user clicks some button that appears, but I think it could be even more interesting to let the user "become God". What happens if in the second round, users can place all the fish and food in the desired locations, and also be able to determine the hunger time limit? I don't know how feasible having such two different modes will be, but I could also just stick with one over the other for the midterm itself.

## Video and Screenshots
