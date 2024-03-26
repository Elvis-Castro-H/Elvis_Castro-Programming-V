# TicTacToe


## Implementation Approach
For this Tic Tac Toe game implementation, I utilized Haskell programming language due to its functional nature, which aligns well with the game's logic. The implementation consists of multiple modules to separate concerns and promote modularity. The primary modules include `Board`, `TicTacToe`, and `ConsoleGame`.

- **Board**: Defines the game board structure and provides functions for manipulating the board.
- **TicTacToe**: Contains the game logic, such as checking for a winner and determining valid moves.
- **ConsoleGame**: Handles the game loop and user interaction for the console-based version of the game.

## Design Decisions
1. **Functional Programming**: Leveraged Haskell's functional programming paradigm to model game logic using pure functions and immutable data structures.
2. **Modular Design**: Divided the implementation into separate modules to encapsulate related functionality and promote code organization and reusability.
3. **Separation of Concerns**: Each module focuses on a specific aspect of the game (e.g., board representation, game rules, user interface), facilitating easier maintenance and testing.

## Challenges Encountered
1. **Infinite Loop**: Encountered challenges in managing the game loop to ensure it terminates correctly. Addressed this by carefully designing the loop logic and ensuring proper termination conditions.
2. **IO Operations**: Faced difficulties integrating IO operations within the functional programming paradigm of Haskell, especially when handling user input and output. Overcame this by leveraging Haskell's IO monad and designing IO functions appropriately.