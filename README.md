# Flutter test app

* Author: Ilia Ostashkov
* Flutter version: 2.6.0

## Main checkpoints

### ✅ API

The Dutch Rijksmuseum API was used in the application (documentation here: https://data.rijksmuseum.nl/object-metadata/api/)

### ✅ Architecture

- The application uses the popular Bloc state management library (https://pub.dev/packages/flutter_bloc).
- The test project demonstrate separating the application into layers.
    - Data layer: retrieve data from the API. The RijksApiClient is independent of the application. As a result, I created it as an internal package.
    - Domain layer: abstract the data layer and expose domain models for the application to consume. ArtObjectRepository also implemented as an internal package. 
    - Presentation layer: display art objects information and manage the state of each page (BLoC)
- Dependency injection is implemented with a simple dependency injection plugin for Flutter and Dart.(https://pub.dev/packages/flutter_simple_dependency_injection)

### ✅ Pages

The application has 3 pages: 
* list of art objects page
* art object details page
* picture viewing page.

### ✅ List of art objects page

- The page has sections with headers. Each header of the section displays the century to which the art objects belong. When scrolling down the list, we gradually load all the new art objects (pagination). When the elements in the current section run out, we request objects from the next section (century). Order of centuries: 21st, 20th, 19th century. Loading and converting JSON to objects is asynchronous.

- All images from the list items are loaded asynchronously. Also, images are cached and have an animation of loading and displaying. If the image loading is interrupted with an error, the corresponding icon is displayed.

- The 'pull to refresh' ability is also implemented for a complete reload of the list. This is useful when we have received any error.

### ✅ Art object details page

When you open the details page, the data of the art object from the list is immediately displayed. Detailed information about the art object is also requested from the API. As soon as this information is received, additional information fields are displayed on the page. If any of the additional fields is empty, it is not displayed.

### ✅ Picture viewing page

This is a simple page without business logic. It is only needed to display the image on the full screen.

### ✅ Handling of failures

Request failure handling is implemented. If an error occurs, a corresponding pop-up notification will be displayed.

<img src="https://user-images.githubusercontent.com/8611478/133454847-f74d60a0-8390-4bf1-8265-5e50dbbb1bb1.PNG" width="250">

### ✅ Unit tests

Unit tests are written for:
- api (`/packages/rijks_api/test/`)
- domain (`/packages/test_app_domain/test/`)
- presentation BLoC (`/packages/test_app_blocs/test/`)
- shared utils (`/packages/test_app_shared/test/`)
- UI Kit (`/packages/test_app_ui_kit/test/`)

<img width="387" alt="Screenshot 2021-09-15 at 4 21 57 PM" src="https://user-images.githubusercontent.com/8611478/133454790-a0c02cf5-edaa-44b2-a847-aaef6efcced8.png">

### 📌 Widget tests

Widget tests are written only for common widgets (`/test/widgets/`). In the future, I will add the widget tests for pages.

### 📌 CI/CD

I use CodeMagic.io for CI/CD.

[![Codemagic build status](https://api.codemagic.io/apps/61801c5bf780e4f64be7e6c7/61801c5bf780e4f64be7e6c6/status_badge.svg)](https://codemagic.io/apps/61801c5bf780e4f64be7e6c7/61801c5bf780e4f64be7e6c6/latest_build)

## Video

https://user-images.githubusercontent.com/8611478/133456754-e35a3aea-9f5c-46c4-be2a-74d14a16b442.MOV

https://user-images.githubusercontent.com/8611478/133454564-70659cae-25cc-4d51-8c41-e6feb8ff926f.MOV

https://user-images.githubusercontent.com/8611478/133458463-cdf6e1b5-0cb0-418e-b8ca-3231ac47b0e9.MOV
