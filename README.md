# Breach


// TODO: implement wantKeepAlive

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

3. Link to Google Drive containing a demo of your app on Android and iOS (using
an emulator is perfectly fine).


4. Ensure all the links are publicly accessible.





1. Register and Login using email and password.
2. List of posts from the backend.
3. Ability to filter posts based on categories (as it appears on the design).
4. A user selecting their topics of interest during onboarding.
5. The stream showing the most recent 5 events sent via websocket.


1. API for user registration using email and password.
2. API for users to login using email and password.
3. API to get all blog posts.
4. API to get all blog categories.
5. Ability to filter posts based on categories (as it appears on the design).
6. API to save user interests during onboarding.
7. Authenticated Web socket to stream news events on the dashboard.

1. Build the frontend using React.
2. Handle errors correctly and prompt users to take corrective actions.
3. Ensure the final product can handle multiple concurrent events without
degrading.


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
