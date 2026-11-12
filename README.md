# Garage Eka

A Flutter vehicle-care platform for Sri Lankan drivers, built as a university UEE project (Year 3, Semester 2). One app serves four kinds of user: vehicle owners, service centres, spare-part shops and repair workshops.

## Features

**Vehicle owners**
- "Carport": save your vehicles (manufacturer, model, last service date, licence and insurance expiry) and get reminder notifications
- Find service centres and workshops near you, see service details and book appointment slots
- Browse spare-part and interior shops, view items, add to cart and buy
- **AI assistant**: ask vehicle questions in a chat, answered by a hosted chatbot API

**Service centres, shops and workshops**
- Add and manage listings with banner images, district and address
- Accept or decline appointments
- Add and update shop items (brand, type, classification)

**General**
- Ratings, call and directions buttons
- Push and local notifications

## Tech stack

- **Flutter** (Dart)
- **Firebase** Authentication, Cloud Firestore and Cloud Messaging
- `flutter_local_notifications`, `geolocator`, `dio` (assistant API), `persistent_bottom_nav_bar`, `flutter_rating_bar`

## Project structure

```
lib/
  user/              owner screens: services, workshops, shops, appointments, assistant
  user_home_screens/ profile, carport, reminders, manufacturer/model pickers
  services_center/   service centre dashboard
  shop/              shop dashboard
  workshop/          workshop dashboard
  services/          authentication service
  screens/           login, registration, home
```

Firestore collections: `users`, `carport`, `manufacturers`, `models`, `serviceCenters`, `workshops`, `shops`, `items`, `bookedSlots`, `order`.

## Getting started

```bash
flutterfire configure     # connect your Firebase project
flutter pub get
flutter run
```
