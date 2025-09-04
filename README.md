# Breach
Welcome to Breach!
A mobile app that allows users connect to streams and read exciting posts from various categories.


1. A guide on how to generate a build (points for having a bash script for this).
STEP 1: 
Prepare Your Environment

-Install Flutter SDK and add it to your PATH.

-Run:

flutter doctor

to check dependencies (Xcode, Android SDK, etc.).

STEP 2:

Use bash script to generate build

-Run:

chmod +x build.sh

to make the script executable

- Then Run it with a target:

./build.sh apk
./build.sh appbundle
./build.sh ios
./build.sh web


2. A breakdown of what you’ve done and how to follow the code.

A. Authentication & Caching User

I consumed endpoints provided on Swagger to authenticate user

I used shared_preferences (or hive) to store a logged-in user locally.

On app launch, we check if the user is cached → skip login.

A StateNotifierProvider (authNotifierProvider) manages the current user.

B. Theme Mode (Dark/Light)

themeModeProvider is a StateProvider<ThemeMode> with a toggle.

The app listens to it and switches between ThemeData.light() and ThemeData.dark().

Preference is stored so it persists across app restarts.

C. Posts Stream

Posts come from postsStreamProvider → a StreamProvider<List<Post>>.

This keeps UI live-updated (new posts appear without refresh).

D. Categories (Interests)

User can select/change categories (categoriesProvider).


E. App Structure

main.dart.

AppConfig to initialize app environment and endpoints

Router using GoRouter

AppTheme initialization





3. Link to Google Drive containing a demo of your app on Android and iOS (using
an emulator is perfectly fine).

https://drive.google.com/file/d/1aOwrVogCiVxPzSF2hfdci4wxJ3cUE9Xg/view?usp=drive_link



4. Ensure all the links are publicly accessible.
Yes



