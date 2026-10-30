# Complex Guessing Game

A game where you guess from complex numbers ranging from -15-15i to 15+15i.

## How to play

**UI design** The five guess buttons in the middle each changes the value by 1, -1, i and -i, the button with zero on it resets the value. The symbol and text on the top displays the results of guesses.

**Steps of playing**
1. After choosing the guess, the button with guess on it makes you guess your chosen number.

2. If your guess is wrong, the game will tell you the difference of your guess's modulus and the correct number's modulus, where modulus is the distance of the point to (0, 0), it will alse tell you the direction of the correct value to your value.

3. If you guess correctly, a new game will start and the process starts again!

## What I added

Using the base of the original guessing game, I added another axis with the same logic for more gameplay, I changed the size comparison to modulus and added a direction display to the game.

## How it works

**Number Displaying** Takes in a complex number and shows the needed string for display.

Sets up a variable called display to be an empty string, this is for changing it and returning the value in the future.

```swift
var display: String = ""
```

The core of the code, mostly checks for coefficients of zero or one.

```swift
if real != 0 && imaginary != 0 {
    if imaginary >= 0 {
        if imaginary != 1 {
            display = "\(real)+\(imaginary)i"
        } else {
            display = "\(real)+i"
        }
    } else {
        if imaginary != -1 {
            display = "\(real)\(imaginary)i"
        } else {
            display = "\(real)-i"
        }
    }
} else if imaginary == 0 {
    display = "\(real)"
} else {
    if imaginary != 1 && imaginary != -1 {
        display = "\(imaginary)i"
    } else if imaginary == 1 {
        display = "i"
    } else {
        display = "-i"
    }
}
```

This is the part of code when both real and imaginary coefficients are not zero, the only thing left to check is for coefficients of one, splitting the code into three.

```swift
if imaginary >= 0 {
    if imaginary != 1 {
        display = "\(real)+\(imaginary)i"
    } else {
        display = "\(real)+i"
    }
} else {
    if imaginary != -1 {
        display = "\(real)\(imaginary)i"
    } else {
        display = "\(real)-i"
    }
```

When imaginary is zero, there is no need for checks since the numbers displayed are natural numbers, nothing is needed.

```swift
display = "\(real)"
```

Else real is zero, then the only special cases is i and -i, so they have their own ifs.

```swift
if imaginary != 1 && imaginary != -1 {
    display = "\(imaginary)i"
} else if imaginary == 1 {
    display = "i"
} else {
    display = "-i"
}
```

Returns display out in regular form of writing complex numbers.

```swift
return display
```

## Testing

Tests of edge cases:

|Test Cases|Inputs|Should Happen|Did Happen|
|-|-|-|-|
|Pointing up|Secret at 1+2i, guess at 1-5i|Arrow pointing up with a larger modulus|✅|
|Pointing right|Secret at 1+2i, guess at -10+2i|Arrow pointing right with a larger modulus|✅|
|Pointing up-right|Secret at 1+2i, guess at 10-5i|Arrow pointing up-right with a larger modulus|✅|
|Same modulus|Secret at 1+2i, guess at 1-2i|Arrow pointing up with the same modulus|✅|
|Edge cases|Guess at 15+15i, press +1 and +i|Guess staying at 15+15i|✅|

Test for the fixed bug in displayedNumber:

|Test Cases|Inputs|Should Happen|Did Happen|
|-|-|-|-|
|Basic case|Secret at 3-i, guess at 10+10i|Display 10+10i on top when guessed|✅|
|Trivial guess|Secret at 3-i, guess at 0|Display 0 when guessed|✅|

## Credits

The starting game was written by Mr. Gordon.
All code was written without AI assistence.
