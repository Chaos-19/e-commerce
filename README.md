# Becho Gadget

Welcome to **Becho Gadget**, a comprehensive Flutter project designed to provide a robust e-commerce platform. This project leverages the power of Flutter and Firebase to deliver a seamless shopping experience across multiple platforms, including iOS, Android, Web, macOS, Linux, and Windows.

## Features

- **User Authentication**: Secure user authentication using Firebase Auth.
- **Product Management**: Efficient product management with Firestore integration.
- **Cart Functionality**: Add, update, and remove items from the cart.
- **Wishlist**: Save favorite products to the wishlist.
- **Order Management**: Place and track orders with real-time updates.
- **Search**: Search for products by name or category.
- **Responsive Design**: Optimized for both mobile and desktop platforms.
- **Notifications**: Real-time notifications for order updates.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Firebase CLI](https://firebase.google.com/docs/cli)

### Installation

1. **Clone the repository**:

   ```sh
   git clone https://github.com/Chaos-19/e-commerce.git
   cd pro_ecommerce
   ```

2. **Install dependencies**:

   ```sh
   flutter pub get
   ```

3. **Set up Firebase**:

   - Create a Firebase project.
   - Add your app to the Firebase project.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the respective directories.

4. **Run the app**:
   ```sh
   flutter run
   ```

## Project Structure

The project follows a feature-based folder structure:

- **lib/src/features**: Contains all the feature modules like authentication, cart, category, order, products, and wishlist.
- **lib/src/common_widgets**: Reusable widgets used across the application.
- **lib/src/constants**: Constant values used throughout the app.
- **lib/src/routing**: Routing configuration for navigation.
- **lib/src/utils**: Utility functions and extensions.

## Key Files

- **lib/src/features/cart/presenter/cart/cart_screen.dart**: Implements the cart screen functionality.
- **lib/src/features/category/presenter/category_screen/category_screen.dart**: Implements the category screen functionality.
- **lib/src/features/order/presenter/customer_order_screen/customer_order_screen.dart**: Implements the customer order screen functionality.
- **lib/src/features/products/data/products_repository.dart**: Manages product data operations.
- **lib/src/features/wishlist/presenter/wishlist_screen.dart**: Implements the wishlist screen functionality.

## Testing

Run the following command to execute the test suite:

```sh
flutter test
```

## Contributing

Contributions are welcome! Please read the CONTRIBUTING.md for guidelines on how to contribute to this project.

### Contributors

- **Kalkidan Getachew** - [kalgetachew375@gmail.com](mailto:kalgetachew375@gmail.com)
- **Firaol Tufa** - [olfira45@gmail.com](mailto:olfira45@gmail.com)
- **Bereket Abdela** - [bekibekina@gmail.com](mailto:bekibekina@gmail.com)
- **Gezahegn Welde** - [gzepa1234@gmail.com](mailto:gzepa1234@gmail.com)
- **Dagmawi Belete** - [dagmbelete221@gmail.com](mailto:dagmbelete221@gmail.com)
- **Eden Sisay**

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Riverpod](https://riverpod.dev/)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
