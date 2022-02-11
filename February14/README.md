# February14

## Description
Develop a set of rules for simulating the real-world behavior of a creature, such as a nervous fly, swimming fish, hopping bunny, slithering snake, etc. Give the creature a personality through its behavior and not through its visual design.

Do your creatures have a limited lifespan? How would you implement this? What about hunger or energy level? If the creature is very hungry is it perhaps less careful or more aggressive about approaching food?

Think about introducing other elements into the environment (food, a predator) for the creature to interact with. Does the creature experience attraction or repulsion to things in its world? Can you think more abstractly and design forces based on the creature’s desires or goals?

## Code Highlights
For this assignment, I decided to implement swimming fish creatures. I tried to picture how fish all swim toward and fight for a very small food particle. Taking this natural setting as an inspiration, I implemented the following behaviors / characteristics:

1. Fish swim toward food particles. In other words, food particles attract the fish.
2. Fish swim away from each other. In other words, fish repel other fish.
3. Fish swim and leave a bit of "water trail" behind.
4. If a particular fish reaches (collides to) a food particle, that particle is "eaten" and a new particle is respawn to a random location on the screen.
5. As fish eats, its mass gets bigger, which in turn increases its attraction toward food particles and its repulsion against other fish.

I personally like the last part because I think it exemplifies (albeit simplified) the survival of the fittest. My hope is to demonstrate that fish who eat more are more likely to continue eating more, which scares away other fish who are "weaker" from not eating as much.

## Difficulties
A few difficulties that I faced in this project are the following:

1. Fish are attracted to the food particles, but unless they are coming straight towards the food, the attraction almost behaves like a gravitational pull of Earth and moon, where the attractee (moon/fish) doesn't really collide into the attractor (Earth/food). So, in many instances, fish go toward the food but even if there are no fish around to push them away, they don't really "eat" the food.
2. Fish do repel each other, but the behavior I was going for was not necessarily a general repulsion away from each other. Rather, I was hoping that they would make appropriate turns to not collide into each other. Fish do seem to avoid crowding due to repulsion, but if there is a single fish in their way, they don't seem to mind just passing through.
3. I tried to implement a way to allow the user (aka the mouse) to "drop" the food particles and make them appear on the screen. But this idea proved to be difficult, because I was not sure what to do when there are no particles left. Because I would "null" the food particle once eaten, there were NullPointerException errors that were raised. This can be solved relatively easily by checking the array length/content and not call any food functions if the array is "empty". But if the exceptions can be handled, how about the fish's behavior? Without any attractors, do they just swim away from each other until there is a user input? Also, because there is no fixed number of particles, that meant that I needed to create some kind of dynamic array that expands and shrinks depending on how many particles the user has dropped and will drop and how many fish have eaten, etc. For these reasons, this idea is left as an idea for now.

## Video and Screenshots