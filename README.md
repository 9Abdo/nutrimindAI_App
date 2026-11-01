# NutriMind AI 🚀

**Tagline:** *Smart Analysis, Healthier You.*

NutriMind AI is a Flutter‑based mobile application that leverages generative AI to help users make healthier food choices. It provides instant nutritional breakdowns of meals, personal daily targets, and a conversational nutrition assistant.

---

## Overview

NutriMind AI combines **Firebase** for authentication and data storage, **Supabase** for image storage, and an **n8n‑hosted Gemini‑powered API** for AI food analysis and chat. The app is fully localized (English / Arabic) and supports both light and dark themes.

---

## Key Features

| Feature | Description |
|---|---|
| **AI Food Analysis** | Analyze meals via **text** descriptions or **food images**. The AI returns calories, protein, carbs, fat and a health‑score, plus a short recommendation. |
| **AI Nutrition Assistant** | Interactive chatbot that accepts text and image inputs. Powered by the same Gemini‑based endpoint used for analysis. |
| **Daily Nutrition Dashboard** | Circular and linear progress indicators show today’s intake vs. custom goals (calories, protein, carbs, fat). |
| **Custom Nutrition Goals** | Users can set daily targets for calories, protein, carbohydrates, and fat. Goals are stored in Firestore and can be edited from the UI. |
| **Automatic Daily Reset** | Statistics are computed only for meals whose timestamp matches the current calendar day, so the dashboard automatically resets each new day. |
| **Meal History** | Every analysed meal is saved in Firestore. Users can view past analyses with full nutritional breakdowns. |
| **Authentication** | Email‑password sign‑up & login via **Firebase Auth**, with optional email‑verification handling. |
| **Localization** | All UI strings use **easy_localization**. The app supports English and Arabic (RTL) out of the box. |
| **Theme Support** | Light and dark themes are managed by a `ThemeCubit` and respect the device’s system setting. |

---

## Screenshots

Below are the complete 60 screenshots captured for each language and theme. Images are displayed at a readable width (~190 px).

### English – Light Mode

<table>
<tr>
<td><img src="assets/screenshot/english_light/change_daily_goal.png" width="190" alt="Change Daily Goal (English Light)"/></td>
<td><img src="assets/screenshot/english_light/chat.png" width="190" alt="Chat (English Light)"/></td>
<td><img src="assets/screenshot/english_light/details.png" width="190" alt="Meal Details (English Light)"/></td>
<td><img src="assets/screenshot/english_light/history.png" width="190" alt="Meal History (English Light)"/></td>
<td><img src="assets/screenshot/english_light/home.png" width="190" alt="Home Dashboard (English Light)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/english_light/loading_meal.png" width="190" alt="Loading Meal (English Light)"/></td>
<td><img src="assets/screenshot/english_light/log_in.png" width="190" alt="Login Screen (English Light)"/></td>
<td><img src="assets/screenshot/english_light/log_out.png" width="190" alt="Logout Confirmation (English Light)"/></td>
<td><img src="assets/screenshot/english_light/personal_info.png" width="190" alt="Personal Info (English Light)"/></td>
<td><img src="assets/screenshot/english_light/profile.png" width="190" alt="Profile Page (English Light)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/english_light/sign_up.png" width="190" alt="Sign‑Up Screen (English Light)"/></td>
<td><img src="assets/screenshot/english_light/splash_light.png" width="190" alt="Splash – Light Mode (English)"/></td>
<td><img src="assets/screenshot/english_light/text_chat.png" width="190" alt="Text Chat (English Light)"/></td>
<td><img src="assets/screenshot/english_light/text_image_chat.png" width="190" alt="Chat with Image (English Light)"/></td>
<td><img src="assets/screenshot/english_light/text_image_load_chat.png" width="190" alt="Loading AI Response (English Light)"/></td>
</tr>
</table>

### English – Dark Mode

<table>
<tr>
<td><img src="assets/screenshot/english_dark/change_daily_goal.png" width="190" alt="Change Daily Goal (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/chat.png" width="190" alt="Chat (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/details.png" width="190" alt="Meal Details (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/history.png" width="190" alt="Meal History (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/home.png" width="190" alt="Home Dashboard (English Dark)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/english_dark/loading_meal.png" width="190" alt="Loading Meal (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/log_in.png" width="190" alt="Login Screen (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/log_out.png" width="190" alt="Logout Confirmation (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/personal_info.png" width="190" alt="Personal Info (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/profile.png" width="190" alt="Profile Page (English Dark)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/english_dark/sign_up.png" width="190" alt="Sign‑Up Screen (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/splash_dark.png" width="190" alt="Splash – Dark Mode (English)"/></td>
<td><img src="assets/screenshot/english_dark/text_chat.png" width="190" alt="Text Chat (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/text_image_chat.png" width="190" alt="Chat with Image (English Dark)"/></td>
<td><img src="assets/screenshot/english_dark/text_image_load_chat.png" width="190" alt="Loading AI Response (English Dark)"/></td>
</tr>
</table>

### Arabic – Light Mode

<table>
<tr>
<td><img src="assets/screenshot/arabic_light/change_daily_goal.png" width="190" alt="Change Daily Goal (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/chat.png" width="190" alt="Chat (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/details.png" width="190" alt="Meal Details (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/history.png" width="190" alt="Meal History (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/home.png" width="190" alt="Home Dashboard (Arabic Light)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/arabic_light/loading_meal.png" width="190" alt="Loading Meal (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/log_in.png" width="190" alt="Login Screen (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/log_out.png" width="190" alt="Logout Confirmation (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/personal_info.png" width="190" alt="Personal Info (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/profile.png" width="190" alt="Profile Page (Arabic Light)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/arabic_light/sign_up.png" width="190" alt="Sign‑Up Screen (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/splash_light.png" width="190" alt="Splash – Light Mode (Arabic)"/></td>
<td><img src="assets/screenshot/arabic_light/text_chat.png" width="190" alt="Text Chat (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/text_image_chat.png" width="190" alt="Chat with Image (Arabic Light)"/></td>
<td><img src="assets/screenshot/arabic_light/text_image_load_chat.png" width="190" alt="Loading AI Response (Arabic Light)"/></td>
</tr>
</table>

### Arabic – Dark Mode

<table>
<tr>
<td><img src="assets/screenshot/arabic_dark/change_daily_goal.png" width="190" alt="Change Daily Goal (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/chat.png" width="190" alt="Chat (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/details.png" width="190" alt="Meal Details (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/history.png" width="190" alt="Meal History (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/home.png" width="190" alt="Home Dashboard (Arabic Dark)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/arabic_dark/loading_meal.png" width="190" alt="Loading Meal (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/log_in.png" width="190" alt="Login Screen (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/log_out.png" width="190" alt="Logout Confirmation (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/personal_info.png" width="190" alt="Personal Info (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/profile.png" width="190" alt="Profile Page (Arabic Dark)"/></td>
</tr>
<tr>
<td><img src="assets/screenshot/arabic_dark/sign_up.png" width="190" alt="Sign‑Up Screen (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/splash_dark.png" width="190" alt="Splash – Dark Mode (Arabic)"/></td>
<td><img src="assets/screenshot/arabic_dark/text_chat.png" width="190" alt="Text Chat (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/text_image_chat.png" width="190" alt="Chat with Image (Arabic Dark)"/></td>
<td><img src="assets/screenshot/arabic_dark/text_image_load_chat.png" width="190" alt="Loading AI Response (Arabic Dark)"/></td>
</tr>
</table>

---

## Technologies & Tools

| Technology | Purpose |
|---|---|
| **Flutter 3** (`sdk: ^3.9.0`) | UI toolkit for cross‑platform mobile (iOS, Android, Windows, macOS, Linux). |
| **Dart** | Programming language used by Flutter. |
| **flutter_bloc** | State‑management via Cubit/BLoC pattern (e.g., `AuthCubit`, `HomeCubit`, `ChatBotCubit`). |
| **dio** | HTTP client for calling the n8n‑hosted Gemini chat API. |
| **Firebase Core / Auth / Firestore** | User authentication, storing meal records, and persisting daily goals. |
| **Supabase Flutter** | Cloud storage for meal and profile images (`SupabaseStorageService`). |
| **easy_localization** | Internationalisation, providing English & Arabic strings and RTL layout support. |
| **flutter_screenutil** | Responsive sizing across different device screens. |
| **percent_indicator / linear_progress_bar** | Visual progress widgets on the dashboard. |
| **cached_network_image** | Efficient image caching for remote meal photos. |
| **image_picker** | Allows users to pick or capture food images for analysis. |
| **lottie** | Animated loading & splash visuals. |
| **google_fonts** | Consistent typography across the app. |
| **shared_preferences** | Lightweight local storage (e.g., for theme preference). |
| **awesome_dialog** | Styled dialogs for confirmations and recommendations. |
| **dartz** | Functional programming utilities (e.g., `Either` for use‑case results). |
| **go_router** | Declarative routing between screens. |
| **circle_nav_bar / glass_bottom_navigation / google_nav_bar** | Bottom navigation UI components. |
| **line_icons** | Icon set used throughout the UI. |

---

## Application Architecture

NutriMind follows a **feature‑by‑feature layered architecture**:

* **Presentation** – UI widgets and screens (`view/…`). Each feature has its own Cubit (`*_cubit.dart`) exposing state classes (`*_state.dart`).
* **Domain** – Use‑case classes encapsulate business logic (`*use_case.dart`). Repositories are defined as abstract contracts.
* **Data** – Remote data sources (`*_data_source_abstract.dart` & `remote_*.dart`) use **Dio** to talk to the AI endpoint (`ConstApi.chatApi`). Local persistence is handled by **FirestoreServices** and **SupabaseStorageService**.
* **Core** – Shared constants (`app_color.dart`, `app_style.dart`, `const_api.dart`, `const_image.dart`), helpers (`dateintil.dart`, `showsnackbar.dart`), and common widgets (`custom_button.dart`, `card_meal.dart`).

State management is performed with **Cubit** (a lightweight `Bloc`). UI layers react to state changes via `BlocBuilder` and `BlocListener`. All network calls return a `Either<Failure, Success>` pattern (using `dartz`) for clear error handling.

---

## Getting Started

### Prerequisites

* **Flutter SDK** (`>=3.9.0`)
* **Android Studio / Xcode / Visual Studio** (for device emulation)
* **Firebase project** with Auth and Firestore enabled.
* **Supabase project** with a bucket named `meal-images` (or adjust `SupabaseStorageService`).
* An **n8n workflow** exposing the Gemini chat endpoint (`https://abdofayad39.app.n8n.cloud/webhook/chat`). The endpoint must accept `multipart/form-data` with fields `message`, `language`, and `image`.

### Clone the repository

```bash
git clone https://github.com/9Abdo/nutrimind.git
cd nutrimind
```

### Install dependencies

```bash
flutter pub get
```

### Firebase configuration

1. Run `flutterfire configure` (or manually place `google-services.json` / `GoogleService-Info.plist` in the respective platform folders).
2. Enable **Email/Password** sign‑in method in the Firebase console.
3. Ensure Firestore rules allow read/write for authenticated users.

### Supabase configuration

* Add your Supabase URL and anon key to `lib/feature/services/supbase_services.dart` (the values are read from `ConstApi.urlsupbase` and `ConstApi.publishKey`).

### n8n / Gemini API configuration

The base URL is already defined in `ConstApi.chatApi`. If you host your own n8n workflow, replace the constant with the appropriate endpoint.

### Run the app

```bash
flutter run
```

---

## Project Highlights

* **Modular feature folders** keep codebases maintainable.
* **AI‑driven analysis** via a single HTTP endpoint – no heavy on‑device models.
* **Real‑time daily statistics** calculated locally from Firestore data.
* **Full RTL support** powered by `easy_localization` and `Directionality` handling.
* **Dark / Light theming** automatically follows system preferences.

---

## Future Improvements

*(These are not yet implemented and are listed for roadmap planning only)*

- Unit & widget test coverage for critical Cubits.
- Offline‐first capability with local caching of meals.
- Voice input for meal description.
- Integration with a public nutrition database (e.g., USDA) for fallback analysis.
- Push notifications for daily goal reminders.

---

## Developer Information

- **Name:** Abdelrahman Sabry
- **Role:** Flutter Developer
- **University:** Mansoura University – Faculty of Computers and Information
- **GitHub:** https://github.com/9Abdo
- **LinkedIn:** www.linkedin.com/in/abdelrahman-sabry-4bb4022a0

---

*AI‑generated nutritional values are estimates only and should not replace professional medical advice.*
