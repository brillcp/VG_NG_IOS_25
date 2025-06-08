# Netgear technical assigment

A SwiftUI application that searches and displays books using the Google Books API. It leverages async/await, Swift Concurrency, protocol-oriented design, and dependency injection to provide a modular and testable architecture. It uses the framework [Networking](https://github.com/brillcp/networking) for network calls.

## 🧩 Features

- 🔍 Search for books using the Google Books API
- 📚 View detailed book information including title, authors, pricing, description, and thumbnail
- 🌈 Extracts dominant colors from thumbnails for UI accenting
- 💵 Price formatting with localized currency support
- 📸 Loads thumbnails asynchronously with error handling
- 📳 Haptic feedback when interacting with books

---

## 🏗 Architecture

- **MVVM with Protocols:** `BookViewModelProtocol` defines the contract. `BookViewModel` handles image loading, formatting, and display logic.
- **Networking Layer:** Abstracted using `NetworkServiceProtocol`. A default implementation (`NetworkService`) performs HTTP requests, and a `MockNetworkService` is used in unit tests.
- **Composable Services:** `BookService` handles API-specific logic and maps responses to `BookViewModel` instances.
- **Combine & Swift Concurrency:** All async work uses `async/await`, with `@Published` properties for UI updates.

---

```
Project/
├── BookDetailView/       // The detail view for books
├── BookService/          // Networking leyer and API abstraction
├── Extensions/           // Extensions, formatters, and helpers
├── GoogleBookAPI/        // Google Book API implementations
├── SearchView/           // The main search view for finding books
├── UIComponents/         // Custom UI components
```

---

## 🧪 Testing

The project uses Swift’s modern testing tools:
-	@Test annotations for async tests.
-	#expect assertions for readability.
-	MockNetworkService to isolate view models from network concerns.

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
