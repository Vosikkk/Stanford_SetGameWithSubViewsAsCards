# Stanford_SetGameWithSubViewsAsCards
## Set Game

### Description

This project is an implementation of the Set card game for iOS devices. The game adheres to specific requirements outlined in Assignment 2. It offers an intuitive and dynamic user interface that adapts to the number of cards in play and screen orientation. Here are the key features and design considerations:

### Features

1. **Solo Set Game**: The application allows users to play a solo game of Set, a matching card game.

2. **Dynamic Card Count**: The game dynamically adjusts to the number of cards in play. It starts with 12 cards and allows users to deal 3 more cards as long as there are cards left in the deck.

3. **Adaptive Card Size**: Cards are displayed as large as possible based on the screen real estate available. As more cards appear on the screen, they automatically resize to fit the space.

4. **Card Removal**: When three cards are matched and no more cards are left in the Set deck, the matching cards are removed from the screen. The remaining cards reorganize to utilize the freed-up space.

5. **Custom Card Rendering**: Cards are drawn using UIBezierPath and/or CoreGraphics functions. No attributed strings or UIImages are used for card rendering.

6. **Symbol Variety**: Cards display one, two, or three symbols that can be squiggles, diamonds, or ovals. Symbols can be solid, striped, or unfilled and come in green, red, or purple colors. The rendering adapts to card size.

7. **Selection and Deselection**: A tap gesture on a card selects or deselects it.

8. **Deal More Cards**: A swipe down gesture allows users to deal 3 more cards from the deck.

9. **Random Reshuffling**: A two-finger rotation gesture allows users to reshuffle all the cards randomly, aiding in situations when they are stuck.

10. **Orientation Support**: The game functions and looks good in both Landscape and Portrait orientations on all iOS devices, including iPhones and iPads. It efficiently uses the available screen space in all circumstances.

### How to Play

1. Tap a card to select or deselect it.
2. Swipe down to deal 3 more cards from the deck.
3. Use a two-finger rotation gesture to reshuffle all the cards when needed.

Enjoy playing Set, and have fun!

### Technologies Used

- Swift
- UIKit
- CoreGraphics
- Git

### Acknowledgments

This project was created as part of an assignment 3 and follows the specified requirements.
