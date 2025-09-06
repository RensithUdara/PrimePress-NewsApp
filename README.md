# Infosphere News App

## Overview
Infosphere is a comprehensive news application built with Flutter that delivers the latest news articles from various sources around the world. The app provides a sleek, modern user interface with smooth animations and an intuitive navigation experience.

## Features
- **Real-time News Updates**: Get the latest breaking news from trusted sources
- **Category-based News**: Browse news by different categories including General, Entertainment, Health, Science, Sports, and Technology
- **Detailed Article View**: Read full articles with information about source, publication date, and author
- **Pull-to-Refresh**: Stay updated with the latest news using the liquid pull-to-refresh feature
- **Cached Images**: Fast loading of images with caching for improved performance
- **Responsive Design**: Optimized for various screen sizes and orientations
- **Smooth Animations**: Beautiful transitions and animations for enhanced user experience

## Tech Stack
- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Basic StatefulWidget state management
- **APIs**: NewsAPI.org for fetching news data
- **HTTP Client**: http package for API calls
- **Image Handling**: cached_network_image for efficient image loading and caching
- **Animation Libraries**: 
  - simple_animations
  - flutter_spinkit for loading indicators
- **Date Formatting**: intl package
- **UI Enhancement**: 
  - shimmer for skeleton loading effects
  - liquid_pull_to_refresh for refreshing news
- **External Links**: url_launcher for opening article sources in browser

## Project Structure
The project follows a clean and organized structure:
```
lib/
  ├── animation/       # Custom animations for UI elements
  ├── models/          # Data models for news articles
  ├── services/        # API service clients
  ├── utils/          # Utility widgets and helper functions
  ├── view/           # UI screens and components
  └── main.dart       # Application entry point
```

## Screens
1. **Splash Screen**: Initial loading screen with animation
2. **Home Screen**: Displays top headlines and featured news
3. **Discover Screen**: Browse news by categories
4. **Article Screen**: Detailed view of selected news article
5. **Navigation Bar**: Bottom navigation for easy screen switching

## Setup and Installation

### Prerequisites
- Flutter SDK (>=3.0.6)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android SDK / Xcode (for iOS development)

### Getting Started
1. Clone the repository
```bash
git clone https://github.com/yourusername/Infosphere_newsApp.git
```

2. Navigate to project directory
```bash
cd Infosphere_newsApp
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

### API Configuration
This app uses NewsAPI.org to fetch news data. You'll need to:
1. Get an API key from [NewsAPI.org](https://newsapi.org/)
2. Replace the API key in `lib/services/topheadlines_api.dart` file

## Dependencies
- google_fonts: ^5.1.0
- http: ^1.1.0
- flutter_spinkit: ^5.2.0
- intl: ^0.18.1
- cached_network_image: ^3.3.0
- simple_animations: ^5.0.2
- shimmer: ^2.0.0
- equatable: ^2.0.5
- url_launcher: ^6.0.11
- liquid_pull_to_refresh: ^3.0.1

## Future Improvements
- User authentication and personalized news feed
- Offline reading capability
- Bookmarking favorite articles
- Dark mode support
- News search functionality
- Push notifications for breaking news
- Additional news sources and filters
- Social media sharing options

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements
- News data provided by [NewsAPI.org](https://newsapi.org/)
- UI design inspiration from [Dribbble](https://dribbble.com/shots/15193792-News-iOS-mobile-app)
- Flutter and the Flutter community for the amazing framework and packages

## Contact
For any questions or feedback, please contact:
- Email: your.email@example.com
- GitHub: [Your GitHub Profile](https://github.com/yourusername)
