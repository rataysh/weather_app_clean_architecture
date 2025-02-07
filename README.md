# Coding Assessment

**Important:** In this small task, the project's structure and the quality of the source code are the primary concerns. The UI is not the main focus.

## Task

Implement a weather application.

## Preconditions

- You need an API Key for the OpenWeatherMap API: [OpenWeatherMap API](https://openweathermap.org/api)
- Use the API for converting a city name to latitude/longitude: [Geocoding API](https://openweathermap.org/api/geocoding-api)
- Use the API for current weather data: [Current Weather API](https://openweathermap.org/current)

## Weather Application

The user should be able to get weather information for an entered city name.

### Screen 1 — Main View

**UI:**

- The user should be able to enter a city name.
- Pressing a button initiates the weather search.
- The result is displayed below the text field and the search button.
- The displayed data includes:
  - Weather description
  - Temperature
- The user also has the option to view the history of the last entered locations. The history can be accessed by pressing a button in the app bar.

**Logic:**

- After the user enters the city name, the application should convert the city name to latitude/longitude values via an API.
- Once the coordinates are received, a request for the current weather is made.
- Upon a successful request, the results are displayed on the same screen below the text field.

### Screen 2 — History View

**UI:**

- When opening this view, the user sees a list view containing the last searched cities.
- Each list item includes:
  - City name
  - Search time
  - Temperature (Degree)
- Pressing the back button returns the user to the Main View.

## Conclusion

This task is aimed at evaluating the ability to structure a project and write clean, high-quality source code. The UI is secondary and serves only to demonstrate the functionality.
