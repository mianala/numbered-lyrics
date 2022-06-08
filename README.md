# You want to have your own numbered lyrics app?

## How to add your lyrics?

1 - Find out the database table template [here](https://docs.google.com/spreadsheets/d/19bWQmThzsXVkloat7vGnPwiJLFeYxgXbrnKd1eGO0E0/edit?usp=sharing). Duplicate it and add your lyrics.

2 - Download it in CSV

3 - Create a new SQLite database named lyrics.db with SQLiteStudio and Import the CSV file

4 - Overwrite the .db file inside the _assets_ folder

When you update the lyrics.db file don't forget to clear the device storage otherwise it won't update the lyrics but use the previous one instead.

Then you can run the app.

## Setup

> flutter pub get

## Make it your own?

To rename the app, change the name of the app in **AndroidManifest.xml** for android

Change the icon in **assets/icon.png** and run

> flutter pub run flutter_launcher_icons:main

If you happen to want to change the lyrics.db file name, you need to change it in the database_helper.dart and the pubspec.yaml file.

To use the list as a homepage instead of the numers just change the home widget from **NumbersGridScreen** to **SongListScreen**.

You might also want to change the appbar titles for the NumbersGridScreen and the SongListScreen.
