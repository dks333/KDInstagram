# KDInstagram

## Modules

- Feed (VIPER)
  - Routers transfer between Feed, Like, Profile, Comment Modules
- Search (MVVM)
- Profile(MVC)
  - Segmented Viewcontroller: Header 

## Structure of every view controller

- Feed: Multiple UITableView + CollectionView
- LikedList: Tableview and searchbar
- Comment: Tableview
- Profile: SegmentViewController, includes HeaderVC and multiple collection view

## AutoLayout

- Resizable UILabel

## Obstacles 

- Dynamic cell size (tableview and image collection view)
- Comment Module: "View more replies" function
- Transfer data from VIPER to MVC (use delegate and embedded in routers)
- Viewcontroller rendered in Storyboard are hard to reuse
- Transfer user interaction from view to presenter, presenter to interactor, interactor to data set
- Separate Models from views
- RxSwift cannot handle optional objects
- Reuse view controllers initialized in nib
- Read codebase of SegmentedController and change portions of code to fit the profile view controller
- Complex collection view layout in search view controller
  - Solution: 第三方资源库，需要修改 (edit Cocoapods libraries to fill my own needs)

## Fun things

- Lottie animation: 'Like' effect
- Story View Cocoapods

## Pros & Cons (of each module)

### Pros 

- **VIPER**: Easy to test and understand which module or section is causing the bug, clear layout of logic, view and navigation, good for large development team
- **MVVM**: Clean code, release pressure of view controller, view model handles all the logic works, good for anyone(so far the best one)
- **MVC**: Easy to implement all function, short in time (good for individual developer or small functions)

### Cons:

- **VIPER**: too many protocols, need to create a new function in different sections(such as protocols, presenters, interactions, views), longer development, hard to maintain by individual developer
- **MVVM**: RxSwift doesn't handle optional(try Combine next time)
- **MVC**: Data source and view are mixed together, hard to debug

