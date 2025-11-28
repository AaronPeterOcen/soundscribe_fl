<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/6wj0hh6.jpg" alt="Project logo"></a>
</p>

<h3 align="center">SoundScribe</h3>

---

<p align="center"> A beautiful Flutter application for music identification and lyrics discovery. Identify songs around you and find their lyrics instantly!
    <br> 
</p>

# SoundScribe

SoundScribe is a Flutter application for music identification and lyrics discovery. Use it to identify songs playing around you, view basic song info, and search for lyrics by artist and title.

## Key features

- Song identification (microphone capture + matching UI) — see the Shazam-like UI in the app.
- Lyrics search by artist and title.
- Cross-platform support: Android, iOS, macOS, Linux, Windows and Web (via Flutter).
- Uses plugins for audio recording, speech-to-text, URL launching, HTTP I/O and more.

## Project layout (important files)

- App entry: [`MyApp`](lib/main.dart) — [lib/main.dart](lib/main.dart)
- Main UI: [`HomeScreen`](lib/screens/homescreen.dart) — [lib/screens/homescreen.dart](lib/screens/homescreen.dart)
- Lyrics search screen: [`LyricsSearch`](lib/screens/lyric_search.dart) — [lib/screens/lyric_search.dart](lib/screens/lyric_search.dart)
- Song identification UI: [`ShazamUi`](lib/screens/shazam_ui.dart) — [lib/screens/shazam_ui.dart](lib/screens/shazam_ui.dart)
- Pub dependencies: [pubspec.yaml](pubspec.yaml)
- Tests: [test/widget_test.dart](test/widget_test.dart)

## Prerequisites

- Flutter SDK (stable). Project uses Dart SDK constraint: `>=3.9.2 <4.0.0` (see [pubspec.yaml](pubspec.yaml)).
- Platform toolchains for targets you plan to build (Android SDK / Xcode / Visual Studio / GTK toolchain).

## Setup & run (development)

1. Install Flutter and platform tools: https://flutter.dev/docs/get-started/install
2. Fetch dependencies:

```sh
flutter pub get
```

### Installing

A step by step series of examples that tell you how to get a development env running.

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo.

## 🔧 Running the tests <a name = "tests"></a>

Explain how to run the automated tests for this system.

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## 🎈 Usage <a name="usage"></a>

Add notes about how to use the system.

## 🚀 Deployment <a name = "deployment"></a>

Add additional notes about how to deploy this on a live system.

## ⛏️ Built Using <a name = "built_using"></a>

- [MongoDB](https://www.mongodb.com/) - Database
- [Express](https://expressjs.com/) - Server Framework
- [VueJs](https://vuejs.org/) - Web Framework
- [NodeJs](https://nodejs.org/en/) - Server Environment

## ✍️ Authors <a name = "authors"></a>

- [@kylelobo](https://github.com/kylelobo) - Idea & Initial work

See also the list of [contributors](https://github.com/kylelobo/The-Documentation-Compendium/contributors) who participated in this project.

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose code was used
- Inspiration
- References
