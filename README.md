[![go_local_api_test](https://github.com/lukaszfabia/GoLocal/actions/workflows/go.yml/badge.svg)](https://github.com/lukaszfabia/GoLocal/actions/workflows/go.yml)
[![frontend_tests](https://github.com/lukaszfabia/GoLocal/actions/workflows/flutter.yml/badge.svg)](https://github.com/lukaszfabia/GoLocal/actions/workflows/flutter.yml)

[![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)](/backend/)
[![Postgres](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](/backend/internal/database/database.go)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](/backend/docker-compose.yml)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](/frontend/)
[![Flutter](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](/frontend/)
[![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)](/backend/internal/notifications)


[![issues](https://img.shields.io/github/issues/lukaszfabia/GoLocal.svg)](https://github.com/lukaszfabia/GoLocal/issues)
[![issues-closed](https://img.shields.io/github/issues-closed/lukaszfabia/GoLocal.svg)](https://github.com/lukaszfabia/GoLocal/issues?q=is%3Aissue+is%3Aclosed)
[![issues-pr](https://img.shields.io/github/issues-pr/lukaszfabia/GoLocal.svg)](https://github.com/lukaszfabia/GoLocal/pulls)
[![issues-pr-closed](https://img.shields.io/github/issues-pr-closed/lukaszfabia/GoLocal.svg)](https://github.com/lukaszfabia/GoLocal/pulls?q=is%3Apr+is%3Aclosed)

# GoLocal - Event Planning App 🚀

An event planning and participation app functioning as a social platform. 

## Features 🌟

1. **User Registration and Login** 
   A secure login system allowing users to create accounts, manage profiles, and sync with accounts from other social platforms.

2. **Event Creation and Management** 
   Users can create events, add details, set dates, times, locations.

3. **Voting Creation and Participation** 

4. **Participant Interaction** 
   Comments, reactions, the ability to message other participants, and create discussion groups related to a specific event.

5. **Notifications** 
   Users receive notifications about upcoming events, invites to new events, and reminders about upcoming meetings.

6. **Event Personalization** 
   Options to customize event appearance, such as images, backgrounds, colors, and styles, tailored to the event's theme.

7. **Collaborative Event Organization** 
   Allowing event organizers to add co-organizers who can collaborate in creating and managing the event.

8. **Recommendation System**
   The app can suggest events based on user preferences, past attendance, and trending/promoted events.

9. **Secure Data Management** 
    Protecting user data through encryption and other privacy measures.

10. **Seeding**
    A lot of data can be generated to populate the app and to run tests.

11. **Containerization**
   Backend can be run as a Docker container.

## My personal contribution

We worked in a team of 3 people. I ([lmProgramming](https://github.com/lmProgramming)) was mainly responsible for the Voting System and Recommendation System, on both backend (Golang) and frontend (Flutter). Thanks to test integration, both modules work pretty well. This was the biggest project I co-created in a team for University so far. Both backend and frontend have distinct architectures, thanks to interfaces we were able to easily create mocks, and we usem some design patterns. For details about contributions, visit [Contributors](https://github.com/lukaszfabia/GoLocal/graphs/contributors).
