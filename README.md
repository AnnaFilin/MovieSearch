# 🎬 MovieSearch

**MovieSearch** is a sleek and modern iOS application that allows users to search, explore, and save their favorite movies. This project demonstrates expertise in SwiftUI, API integration, and user-centered design, making it an excellent addition to a professional portfolio.

---

## ✨ Features

- **Movie Search**  
  Search movies by title or genre using an intuitive and responsive search bar.

- **Curated Collections**  
  Explore trending, popular, and top-rated movies.

- **Detailed Movie Information**  
  View comprehensive details, including cast and high-quality backdrops.

- **Favorites Management**  
  Add movies to your favorites list for quick and convenient access.

- **Clean and Responsive UI**  
  Optimized for all screen sizes with smooth navigation and a user-friendly design.

---

## 📱 Screenshots

- Main Screen:
![Main Screen](https://github.com/user-attachments/assets/267b0505-9491-4d0b-b7f3-27cc24235a5e)

- Search Results:
![Search by Genre](https://github.com/user-attachments/assets/d198c58d-2d04-4639-a461-8a618a787598)
![Search by Keyword](https://github.com/user-attachments/assets/cfae45f3-96d8-4964-a59c-dde818535b18)

- Details Screen: 
![Details Screen](https://github.com/user-attachments/assets/ff168ac9-b7af-4c90-b97a-41cb3bfea8b4)
![Details Screen (expanded)](https://github.com/user-attachments/assets/fa6563d7-9257-4271-8ecc-6d67d25beee2)

- Favorites Screen:
![Favorites Screen](https://github.com/user-attachments/assets/2f41484c-eaab-465a-9277-2bfb81f66cf7)

---
## 📱 Screenshots iPad
- Main Screen:



## 🛠️ Tech Stack

- **Language:** Swift  
- **Framework:** SwiftUI  
- **API:** [The Movie Database (TMDb)](https://www.themoviedb.org/documentation/api)  
- **Persistence:** Local storage for favorites  
- **Version Control:** Git and GitHub  

---

## 🚀 Installation Guide

To set up the project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/MovieSearch.git

2. Open the project in Xcode: 
   cd MovieSearch
   open MovieSearch.xcodeproj

3. Configure the API key:
   Open Config.swift and replace YOUR_API_KEY with your TMDb API key:
   struct Config {
       static let apiKey = "YOUR_API_KEY"
   }

4. Build and run the app:
Run the app on an iOS simulator or a connected device.

🔗 API Integration
The app integrates with the TMDb API to fetch real-time movie data, such as:

Trending, popular, and top-rated movies
Search results based on user input
Movies filtered by genre
Detailed information, including cast and backdrops
❤️ Favorites Management
The app allows users to save their favorite movies, ensuring they can revisit them anytime. This feature is implemented with local data persistence for seamless functionality across app sessions.

📊 Future Enhancements
Personalized Recommendations:
Suggest movies based on user preferences and watch history.

Offline Mode:
Cache data locally to enable browsing without internet access.

Localization:
Add support for multiple languages to cater to a global audience.

Advanced Filters:
Allow sorting and filtering by release date, ratings, and other criteria.

🧩 Challenges and Solutions
Dynamic API Handling:
Designed reusable services for scalability and easy integration of additional API features.

Efficient Data Parsing:
Leveraged Swift's Codable for safe and efficient JSON decoding.

Error Handling:
Incorporated user-friendly error messages to improve the user experience in case of network or API failures.

🛠 Skills Demonstrated
Proficiency in Swift and SwiftUI
Strong understanding of RESTful APIs
Knowledge of state management and local data persistence
Focus on user-centered design and responsiveness

