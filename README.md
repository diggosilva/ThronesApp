# ThronesApp

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

A simple iOS application written in Swift, built for practical search controller.


| Feed | Details | Favorites |
| --- | --- | --- |
| ![Feed](https://github.com/user-attachments/assets/92bf2794-5273-4090-9f48-8dff7348903f) | ![Details](https://github.com/user-attachments/assets/9a4f8c88-a2bf-4023-b865-ebe757c7cbd7) | ![Favorites](https://github.com/user-attachments/assets/7edf8c7c-3ebf-4253-bce7-99df809563a8) |


## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Setup](#setup)

## Features

- View Code (UIKit)
- Search Controller
- Modern CollectionView
- Modern TableView
- MVVM with Combine
- Await/Async Request
- UserDefaults
- Custom elements
- Dark Mode
- Unit Tests

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.0 or later

## Functionalities

- [x] **# Thrones List**: Displays a list of available Characters for viewing.
- [x] **Thrones Details**: Tapping on a character takes the user to a detailed screen with information about it.
- [x] **Favorite Thrones**: Allows the user to favorite a Character. This is done using `UserDefaults` to store the favorite characters.
- [x] **Favorites Page**: Displays all Characters that the user has favorited. From this page, users can access image and name of each character.
- [x] **Remove from Favorites**: From the favorites page, users can remove character from their favorites list.
- [x] **Dark Mode Support**: Full support for Dark Mode, offering a more pleasant user experience in different lighting conditions.
- [x] **UIKit Interface**: Utilizes UIKit components for building the user interface.
- [x] **Modern Collections**: Implements `UICollectionViewDataSource` to optimize data management and UI updates.
- [x] **Modern Tables**: Implements `UITableViewDataSource` to optimize data management and UI updates.


## Setup

First of all download and install Xcode, Swift Package Manager and then clone the repository:

```sh
$ git@github.com:diggosilva/ThronesApp.git
```

After cloning, do the following:

```sh
$ cd <diretorio-base>/ThronesApp/
$ open ThronesApp.xcodeproj/
```
