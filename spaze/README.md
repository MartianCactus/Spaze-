# SPAZE!
#### Video Demo:  https://youtu.be/soDP52-Yop0
#### Description:
Spaze! (yes, with the !) is a 2d shooter game made in the Love2D framework using the lua language. The game involves you shooting bullets out of a ship to destroy randomly generated meteors falling towards you. Some meteors are non destructable(indicated by the color orange!!) and you have no choice but to avoid them.

The game has a game-speed variable, which slowly increases as the game goes on before capping.This is done by incrementing the variable by delta time every frame. The love2d framework works with three major functions, ther load function where you load and initializa every variable and asset, the update functio where you update every iteration of the game. And the draw function where you draw every iteration of the game. These three functions run in a loop continuously as long as the game is running.

The update function has a built in attribute called delta time. This is the time between every frame of the game. Some systems may be faster and some may be slower, to equalize this, the refresh time between every frame is passed on to the update function. And so, isntead of hardcoding everything, we use delta time to update things at the same pace on every machine. This variable causes meteors to generate more often and to fall faster. You ship fires two bullets at once, strategic use of this can take down two meteors at once!

The game has interactive UI buttons that color up while you hold the button. Just a design choice I liked. I really like the whole "old console, aesthetically old school" felling the game gives.

Underneath the hood the game works by using an Object Orientented model. The ship is an object, so are the bullets and the meteors, and they all inherit their traits from the entity superclass. Collision detection is a big part of the game, collision has to be detected between bullets and meteors, between meteors and the ship, and even between meteors and meteors! (so multiple meteors do not spawn together, they are destroyed by checking collision off screen)

Keeping track of the meteors and bullets in a list and iteracting over them when they are drawn, or removing them from the list (essentially destroying them!) when they suffer a collision or go off screen is also a part of the system.

And then the gamehas some UI sounds, some interactive sounds and a deep eerie space-ish-y sound in the background.

List of used technologies:
-Love2d
-Lua
-Classic library

The are thanks to Mr. Kenny! He makes free video game assets for aspiring and hobbiyst developers like me to use! Here's his website: https://kenney.nl/assets

That's all for Spaze!

And this is CS50!
