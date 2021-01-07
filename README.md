# coding_test

To run this project you need to setup [Flutter](https://flutter.dev/)

# Setup Firebase
First Create a firebase project [Firebase Console](https://console.firebase.google.com/)
## Android setup
Add an android app to you firebase project `https://console.firebase.google.com/u/0/project/[your-projet-id]/settings/general`. Replace `your-project-id` with the project id of the project you just created.

Use `com.example.coding_test` as package name
follow the on screen instructions.

## IOS Setup

Add an ios app to you firebase project `https://console.firebase.google.com/u/0/project/[your-projet-id]/settings/general`. Replace `your-project-id` with the project id of the project you just created.

Use `com.example.codingTest` as bundle id
follow the on screen instructions.

## Turn on Auth Provider

Enable `Email/Password` provider [here](https://console.firebase.google.com/u/0/project/draft-app-a1a44/authentication/providers)

## Setup Cloud Firestore
Setup Cloud Firestore by following instructions here `https://console.firebase.google.com/u/0/project/your-project-id/firestore`. Replace `your-project-id` with the project id of the project you are using.

## Setup Firebase Storage
Setup Firebase storage by following instructions here `https://console.firebase.google.com/u/0/project/your-project-id/storage`. Replace `your-project-id` with the project id of the project you are using.

## Get Pacakges

Open your terminal.
Enter `cd path/to/coding_test/`

run `flutter pub get`


## Run your app

Attach a phone to your app, make sure in android you turn on [usb debugging](https://developer.android.com/studio/debug/dev-options).

run `flutter run` assuming you only have one device connected.

for more details folow [here](https://flutter.dev/docs/get-started/test-drive).
