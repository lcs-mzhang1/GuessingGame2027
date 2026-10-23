import SwiftUI
import Foundation

// The game's settings. They sit up here, outside the game,
let lowestNumber: Int = -15
let highestNumber: Int = 15

let numberRange: Int = 15

// The game itself: what it remembers, what it shows on the screen,
struct GuessingGameView: View {
    // MARK: - Stored properties
    
    // The number the player is trying to find. The app picks it at random.
    @State var realSecretNumber: Int = Int.random(in: lowestNumber...highestNumber)
    @State var imaginarySecretNumber: Int = Int.random(in: lowestNumber...highestNumber)

    // The guess the player is about to make. It starts in the middle.
    @State var realGuess: Int = 0
    @State var imaginaryGuess: Int = 0

    // How many guesses the player has made in this game.
    @State var guessCount: Int = 0

    // The message shown to the player, with a symbol and a colour to match it.
    @State var message: String = "I'm thinking of a complex number with modulus no greater than \(numberRange)."
    @State var messageSymbol: String = "questionmark.circle.fill"
    @State var messageColor: Color = Color.yellow

    // Becomes true when the player finds the secret number.
    @State var gameIsOver: Bool = false

    // MARK: - Computed properties

    var body: some View {
        VStack(spacing: 15) {
            // The title at the top of the screen.
            HStack {
                Image(systemName: "graph.2d")
                Text("Complex Guessing Game")
            }
            .font(.largeTitle)
            .bold()
            .foregroundStyle(Color.yellow)

            Spacer()

            // The message card: what the game has to say to you.
            VStack(spacing: 12) {
                Image(systemName: messageSymbol)
                    .font(.system(size: 60))
                    .foregroundStyle(messageColor)
                Text(message)
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 180)
            .background(messageColor.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 24))

            Spacer()

            // The guess you are about to make, shown nice and big.
            Text(displayedNumber(real: realGuess, imaginary: imaginaryGuess))
            .font(.system(size: 96, weight: .bold))
            .monospacedDigit()
            
            // Buttons to change the guess.
            HStack() {
                Button("+i") {
                    changeGuess(real: 0, imaginary: 1)
                }
            }
            .buttonStyle(.bordered)
            .font(.title3)
            .bold()
            .monospacedDigit()
            .disabled(gameIsOver)

            HStack(spacing: 8) {
                Button("-1") {
                    changeGuess(real: -1, imaginary: 0)
                }
                Button("0") {
                    changeGuess(real: 0 - realGuess, imaginary: 0 - imaginaryGuess)
                }
                Button("+1") {
                    changeGuess(real: 1, imaginary: 0)
                }
            }
            .buttonStyle(.bordered)
            .font(.title3)
            .bold()
            .monospacedDigit()
            .disabled(gameIsOver)
            
            HStack() {
                Button("-i") {
                    changeGuess(real: 0, imaginary: -1)
                }
            }
            .buttonStyle(.bordered)
            .font(.title3)
            .bold()
            .monospacedDigit()
            .disabled(gameIsOver)

            // Show the Guess button while the game is on, and the Play Again button once the number is found.
            if gameIsOver {
                Button("Play Again", systemImage: "arrow.clockwise") {
                    startNewGame()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.green)
            } else {
                Button("Guess", systemImage: "hand.point.up.left.fill") {
                    checkGuess()
                }
                .buttonStyle(.borderedProminent)
            }

            Text("Guesses so far: \(guessCount)") //\(displayedNumber(real: realSecretNumber, imaginary: imaginarySecretNumber)
                .font(.headline)
                .foregroundStyle(Color.secondary)
        }
        .padding(32)
        .font(.title2)
        .fontDesign(.rounded)
        .controlSize(.large)
        .tint(Color.red)
        
        // How big the game's window is on the Mac. It can be made taller or wider.
        .frame(minWidth: 420, minHeight: 640)
    }

    // MARK: - Functions

    // Checks the player's guess against the secret number.
    func checkGuess() {
        // One more guess has been made.
        guessCount += 1

        if realGuess == realSecretNumber && imaginaryGuess == imaginarySecretNumber {
            message = "Yes! \(displayedNumber(real: realSecretNumber, imaginary: imaginarySecretNumber)) is my number."
            messageSymbol = "star.circle.fill"
            messageColor = Color.green
            gameIsOver = true
        } else {
            if modulus(real: realGuess, imaginary: imaginaryGuess) < modulus(real: realSecretNumber, imaginary: imaginarySecretNumber) {
                message = "\(displayedNumber(real: realGuess, imaginary: imaginaryGuess)) has smaller modulus than my number. Try again."
                messageSymbol = "xmark.circle.fill"
                messageColor = Color.red
            } else if modulus(real: realGuess, imaginary: imaginaryGuess) > modulus(real: realSecretNumber, imaginary: imaginarySecretNumber) {
                message = "\(displayedNumber(real: realGuess, imaginary: imaginaryGuess)) has larger modulus than my number. Try again."
                messageSymbol = "xmark.circle.fill"
                messageColor = Color.red
            } else {
                message = "\(displayedNumber(real: realGuess, imaginary: imaginaryGuess)) has same modulus than my number. Try again."
                messageSymbol = "xmark.circle.fill"
                messageColor = Color.red
            }
        }
    }
    
    func changeGuess(real: Int, imaginary: Int) {
        realGuess += real
        imaginaryGuess += imaginary
        
        if realGuess > highestNumber {
            realGuess = highestNumber
        }
    }
    
    func displayedNumber(real: Int, imaginary: Int) -> String {
        var display: String = ""
        
        if real != 0 && imaginary != 0 {
            if imaginary >= 0 {
                if imaginary != 1 {
                    display = "\(real)+\(imaginary)i"
                } else {
                    display = "\(realGuess)+i"
                }
            } else {
                if imaginary != -1 {
                    display = "\(realGuess)\(imaginaryGuess)i"
                } else {
                    display = "\(realGuess)-i"
                }
            }
        } else if imaginary == 0 {
            display = "\(real)"
        } else {
            if imaginary != 1 && imaginary != -1 {
                display = "\(imaginary)i"
            } else if imaginaryGuess == 1 {
                display = "i"
            } else {
                display = "-i"
            }
        }
        
        return display
    }
    
    func modulus(real: Int, imaginary: Int) -> Double {
        // Transforms numbers in double form.
        let realAsDouble = Double(real)
        let imaginaryAsDouble = Double(imaginary)
        
        return sqrt(pow(realAsDouble, 2) + pow(imaginaryAsDouble, 2))
    }

    // Picks a new secret number and resets everything else.
    func startNewGame() {
        realSecretNumber = Int.random(in: lowestNumber...highestNumber)
        realGuess = 0
        imaginaryGuess = 0
        guessCount = 0
        message = "I'm thinking of a complex number with modulus no greater than \(numberRange)."
        messageSymbol = "questionmark.circle.fill"
        messageColor = Color.yellow
        gameIsOver = false
    }
}

#Preview {
    GuessingGameView()
}
