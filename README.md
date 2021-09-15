# Flutter test app

* Author: Ilia Ostashkov
* Flutter version: 2.2.3

https://user-images.githubusercontent.com/8611478/133454564-70659cae-25cc-4d51-8c41-e6feb8ff926f.MOV
https://user-images.githubusercontent.com/8611478/133454624-71f3b088-0815-4362-b169-2720d0502214.MOV

## Main checkpoints

### ✅ API

The Dutch Rijksmuseum API was used in the application (documentation here: https://data.rijksmuseum.nl/object-metadata/api/)

### ✅ Architecture

- The application uses the popular Bloc state management library (https://pub.dev/packages/flutter_bloc).
- The test project demonstrate separating the application into layers.
    - Data: retrieve data from the API. The RijksApiClient is independent of our application. As a result, I created it as an internal package (and could even publish it on pub.dev).
    - Repository: abstract the data layer and expose domain models for the application to consume. ArtObjectRepository also implemented as an internal package. 
    - Business Logic: manage the state of each feature (BLoC, event, state).
    - Presentation: display art objects information.
- Dependency injection occurs in the `PageFabric` class when creating screens. This implementation can be replaced with some DI library if needed (for example, https://pub.dev/packages/flutter_simple_dependency_injection)

### ✅ Screens

The application has 3 screens: 
* list of art objects screen
* art object details screen
* picture viewing screen.

### ✅ List of art objects screen

- The screen has sections with headers. Each header of the section displays the century to which the art objects belong. When scrolling down the list, we gradually load all the new art objects (pagination). When the elements in the current section run out, we request objects from the next section (century). Order of centuries: 21st, 20th, 19th century. Loading and converting JSON to objects is asynchronous.

- All images from the list items are loaded asynchronously. Also, images are cached and have an animation of loading and displaying. If the image loading is interrupted with an error, the corresponding icon is displayed.

- The 'pull to refresh' ability is also implemented for a complete reload of the list. This is useful when we have received any error.

### ✅ Art object details screen

When you open the details screen, the data of the art object from the list is immediately displayed. Detailed information about the art object is also requested from the API. As soon as this information is received, additional information fields are displayed on the screen. If any of the additional fields is empty, it is not displayed.

### ✅ Picture viewing screen

This is a simple screen without business logic. It is only needed to display the image on the full screen.

### ✅ Handling of failures

Request failure handling is implemented. If an error occurs, a corresponding pop-up notification will be displayed.

![IMG_7306](https://user-images.githubusercontent.com/8611478/133454847-f74d60a0-8390-4bf1-8265-5e50dbbb1bb1.PNG)

### ✅ Unit tests

Unit tests are written for:
- data layer (html report is generated at `/packages/rijks_api/coverage/index.html`) 
- repository layer (html report is generated at `/packages/art_object_repository/coverage/index.html`)
- business logic layer (`/test/unit/`)

<img width="387" alt="Screenshot 2021-09-15 at 4 21 57 PM" src="https://user-images.githubusercontent.com/8611478/133454790-a0c02cf5-edaa-44b2-a847-aaef6efcced8.png">

### 📌 Widget tests

Widget tests are written only for simple text widgets (`/test/widgets/`). In the future, I will add the widget tests for screens.

### 📌 Integration tests

Integration tests have not yet been implemented.
