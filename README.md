# Netgear technical assigment

A SwiftUI application that searches and displays books using the Google Books API. It leverages `async/await`, Swift Concurrency, protocol-oriented design, and dependency injection to provide a modular and testable architecture. It uses the framework [Networking](https://github.com/brillcp/networking) for network calls.


## 🧩 Features

- 🔍 Search for books using the Google Books API
- 📚 View detailed book information including title, authors, pricing, description, and thumbnail
- 🌈 Extracts dominant colors from thumbnails for UI accenting
- 💵 Price formatting with localized currency support
- 🖼️ Loads thumbnails asynchronously with error handling


## 🏗 Architecture

- **MVVM with Protocols:** `BookViewModelProtocol` defines the contract. `BookViewModel` handles image loading, formatting, and display logic.
- **Networking Layer:** Abstracted using `NetworkServiceProtocol`. A default implementation (`NetworkService`) performs HTTP requests, and a `MockNetworkService` is used in unit tests.
- **Composable Services:** `BookService` handles API-specific logic and maps responses to `BookViewModel` instances.
- **Modern Swift Concurrency:** All async work uses `async/await`, with `@Published` properties for UI updates.


## 🎨 UI Design Notes

The assignment specification requested that book thumbnails be displayed in an Image View with a 16:9 aspect ratio. This would typically be appropriate for media like videos or wide banners, but books are traditionally formatted in a portrait ratio (around 9:16).

### Design Decision

To preserve realism and visual fidelity, I rendered book thumbnails using a portrait aspect ratio (9:16) instead of forcing them into 16:9. This approach:
- Prevents distortion and cropping
- Reflects real-world book proportions
- Enhances readability and visual balance

This is in line with the instruction:

*“Employ your discretion to best showcase your design approach.”*


The TabView navigation and layout remain consistent with the assignment’s structural requirements, but the image aspect ratio has been intentionally adjusted to better reflect real-world book UIs.


## File structure
```
Project/
├── BookDetailView/       // The detail view for books
├── BookService/          // Networking leyer and API abstraction
├── Extensions/           // Extensions, formatters, and helpers
├── GoogleBookAPI/        // Google Book API implementations
├── SearchView/           // The main search view for finding books
├── UIComponents/         // Custom UI components
```

## 🧪 Testing

The project uses Swift’s modern testing tools:
-	`@Test` annotations for async tests.
-	`#expect` assertions for readability.
-	`MockNetworkService` to isolate view models from network concerns.

## 🚀 Getting Started

### Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/brillcp/VG_NG_IOS_25.git
   cd bookfinder
