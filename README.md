# iOS app development

```swift
    func sendUserNotificationOnce(identifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            // Enable or disable features based on authorization.
        }
        
        // customize your notification content
        let content = UNMutableNotificationContent()
        content.title = "iBeacon2"
        content.body = "Isn't Geoffrey cute?"
        content.sound = UNNotificationSound.default
        
        // when the notification will be triggered
        let timeInSeconds: TimeInterval = 5
        // the actual trigger object
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInSeconds,
            repeats: false
        )
        
        // the notification request object
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        // trying to add the notification request to notification center
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            }
        })
    }
```

## What's next?
- [ ] Replace PromiseKit with AsyncTask in a feature branch
  ```swift
    // synchronous API
    func encrypt(message: String) -> Task<String> {
        return Task {
            encrypt(message)
        }
    }
    // asynchronous API
    func get(URL: NSURL) -> Task<(NSData?, NSURLResponse?, NSError?)> {
        return Task {completionHandler in
            NSURLSession().dataTaskWithURL(URL, completionHandler: completionHandler).resume()
        }
    }
    
    // async
    encrypt(message).async { ciphertext in /* do somthing */ }
    get(URL).async {(data, response, error) in /* do somthing */ }

    // await
    let ciphertext = encrypt(message).await()
    let (data, response, error) = get(URL).await()
  ```

## Check points
- [ ] Local Push notification center
- [ ] Google FireBase Analytics
- [ ] We should be familiar with storyboard.
- [x] We can have multiple storyboards for a same controller per device
- [ ] What is DEV, TEST and QA in Mobile App development: manual deployment
- [ ] How to create a custom module, e.g, CustomTableView, and associate the Storyboard item with the custom module.
- [ ] Can we layout with percentage?
- [ ] Understand the view controller life cycle and its callbacks and more https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/WorkWithViewControllers.html
- [x] CocoaPods: brew install cocoapods
- [ ] UI Unit tests? Is it not enough?
- [x] Asynchronous jobs:
  - AsyncTask https://medium.com/@zhxnlai/async-programming-in-swift-with-asynctask-95a708c1c3c0
  - Swift PromiseKit https://learnappmaking.com/promises-swift-how-to/
  - Grand Central Dispatch https://www.raywenderlich.com/60749/grand-central-dispatch-in-depth-part-1
  - Bolt https://github.com/BoltsFramework/Bolts-ObjC
  - FutureKit https://github.com/FutureKit/FutureKit
  - BrightFuture https://github.com/Thomvis/BrightFutures
  - Functional Reactive Programming
    * ReactiveCocoa https://github.com/ReactiveCocoa/ReactiveCocoa
    * RxSwift https://github.com/ReactiveX/RxSwift 
- [ ] An easy way to inspect values of variables in debugging in XCode, not printing
- [x] An easy way to format String, such as String interpolation
- [ ] Continuous Integration: https://docs.microsoft.com/en-us/azure/devops/pipelines/languages/xcode?view=vsts

## Instructor's notes (Kimate)
- Completion Handler: https://blog.bobthedeveloper.io/completion-handlers-in-swift-with-bob-6a2a1a854dc4
- AlamoFire and SwiftJSON: https://www.codementor.io/ashishkakkad/how-to-use-alamofire-and-swiftyjson-with-swift-4or6su5oa
- Codable, JSON decoder: https://medium.com/xcblog/painless-json-parsing-with-swift-codable-2c0beaeb21c1
- Handy and quick Core Data Wrapper https://realm.io/docs/swift/latest/
- View Controller is different View, which doesn't occupy a whole space, for example, "Table View Controller" vs "Table View"
- Storyboard is a kinda project file
- "IB" stands for "Interface Builder'. Therefore, variables with IBOutlet resolves 'nil', and with IBAction 'Void' respectively. but it let "Interface Builder" link UI elements to variables with the decorators.
- 'protocol' and 'delegate' decorators are similar
- VIPER pattern (View, Interactor, Presenter, Entity, and Routing)
  * https://www.objc.io/issues/13-architecture/viper/
  * https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html
- GEO fencing and Wifi Beacon https://proximi.io/geofence-complete-guide-geofencing/
