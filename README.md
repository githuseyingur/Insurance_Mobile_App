# Insurance Mobile App Demo

This project is a **Minimum Viable Product (MVP)** of an insurance mobile application built with Flutter.  
Users can view their active policies and submit a damage claim.

## Architecture
The project uses a `**feature-based architecture**` with the following main structure:
```text
lib/
├─ core/
├─ feature/
└─ product/
```

Features are organized by functionality. Each feature contains its own layers:
```text
feature/
  └─ policy/
      ├─ cubit/
      ├─ service/
      ├─ model/
      ├─ view/
      └─ widget/
  └─ claim/
      ...
```

This structure keeps related components together and separates **UI, business logic, and data handling**, making the project easier to maintain and extend.



## State Management
<p>The application uses **Bloc with Cubit** for state management. Cubit was chosen because it provides a **simple and lightweight way to manage state**, ensures a cleaner codebase and enhances project maintainability.</p>



## Networking

**Dio** is used for HTTP requests.

A **Postman Mock API Server** is used to simulate backend endpoints. Policy data fetching and claim submission requests are sent to this mock server.



## Routing

Navigation is implemented using **GoRouter**, which provides a clear and scalable routing structure.



## Form Validation & Error Handling

The **Claim Submission** screen includes form validation to ensure required fields are filled.

Error and loading states are handled using a status variable with the following values:

- `initial`
- `loading`
- `completed`
- `error`

This allows the UI to react properly to asynchronous operations.



## Security
Managed via `envied` with obfuscation for enhanced protection of base URL.




## Packages
```dart
  # UI
  flutter_screenutil: ^5.9.3
  google_fonts: ^6.3.0

  # STATE
  flutter_bloc: ^9.1.1
  equatable: ^2.0.8

  # NAVIGATION
  go_router: ^16.1.0

  # SERVICE
  dio: ^5.9.1 

  # SECURITY
  envied: ^1.2.1 

  # INTERNET ACCESS
  connectivity_plus: ^7.0.0
```

## Run the Project
Flutter 3.27.4 <br>
Dart 3.6.2

```console
git clone https://github.com/githuseyingur/Insurance_Mobile_App
flutter pub get
flutter run
```


