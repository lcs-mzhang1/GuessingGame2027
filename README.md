# Complex Guessing Game

A game where you guess from complex numbers ranging from -15-15i to 15+15i.

## How to play

The five guess buttons in the middle each changes the value by 1, -1, i and -i, the button with zero on it resets the value.
After choosing the guess, the button with guess on it makes you guess your chosen number, if your guess is wrong, the game will tell you the difference of your guess's modulus and the correct number's modulus, where modulus is the distance of the point to (0, 0), it will alse tell you the direction of the correct value to your value, if you guess correctly, a new game will start.

## How it works

The buttons for changing the value guessed directs the changeGuess function which changes the value and checks if the value is out if range.
After guessing, the game first increments guessCount by 1, then it will create a variable shapeShown to be the value of the shown shape up top depending on the direction of the correct value to the guessed value, afterward, it would check the modulus using the modulus function, which takes in a pair of numbers and outputs the modulus, for the display of the number, the displayedNumber function is used to handle cases if any coefficients of the real part or imaginary part is one to handle edge cases.

## Testing

|Test Number|realGuess|imaginaryGuess|realSecretNumber|imaginarySecretNumber|message|shapeShown|
|-|-|-|-|-|-|-|
|1|0|0|1|1|"smaller modulus"|"arrow.up.right"|
|2|-1|-1|1|1|"same modulus"|"arrow.up.right"|
|3|0|0|15|0|"smaller modulus"|"arrow.right"|
|4|10|10|10|10|"is my number"|"star.circle.fill"|
|5|15|15|2|2|"larger modulus"|"arrow.down.left"|

These each test different cases with different modulus and direction.

## Credits

The starting game was written by Mr. Gordon.
All code was written without AI assistence.
