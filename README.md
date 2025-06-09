# Netgear technical assigment

A SwiftUI application that searches and displays books using the Google Books API. It leverages `async/await`, Swift Concurrency, protocol-oriented design, and dependency injection to provide a modular and testable architecture. It uses the framework [Networking](https://github.com/brillcp/networking) for network calls.


## 🚀 Getting Started

### Requirements

- Xcode 16+
- iOS 18+
- Swift 6.0+

### Installation

1. Clone the repo:
```bash
git clone https://github.com/brillcp/VG_NG_IOS_25.git
```
2. Launch the app from Xcode initially to install it on a physical device.
3. Once it’s running, stop the execution in Xcode, then manually reopen the app from the home screen.
This allows the app to run independently, providing a more realistic and performant experience without debugger overhead.

## 🧩 Features

- 🔍 Search for books using the Google Books API
- 📚 View detailed book information including title, authors, pricing, description, and thumbnail
- 💵 Price formatting with localized currency support
- 🖼️ Loads thumbnails asynchronously with error handling


| Toggle | List view |
|-|-|
| ![toggle](https://github.com/user-attachments/assets/5dbb7432-d583-4390-ba8c-a3a2dd46854c) | ![list](https://github.com/user-attachments/assets/783a5beb-58b8-4768-8f35-f33fc40dadb6) |


### Video
https://github.com/user-attachments/assets/b5f65b68-e974-4cd2-a658-75360065e764


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


## 📁 File structure
```
Project/
├── BookService/          // Networking leyer and API abstraction
├── Extensions/           // Extensions, formatters, and helpers
├── GoogleBookAPI/        // Google Book API implementations
├── Views/                // Contains the search view and the book detail view, as well as other UI components
```

## 🧪 Testing

The project uses Swift’s modern testing tools:
-	`@Test` annotations for async tests.
-	`#expect` assertions for readability.
-	`MockNetworkService` to isolate view models from network concerns.


## 📌 Deliverables
- ✅ Public repository named VV_NG_IOS_25
- ✅ README with explanation and setup instructions
- ✅ Modern architecture, SwiftUI-based UI
- ✅ Test coverage and documented limitations
