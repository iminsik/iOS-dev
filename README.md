# iOS app development

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
- [ ] An easy way to inspect values of variables in debugging, not printing
- [x] An easy way to format String, such as String interpolation
- [x] Continuous Integration: https://docs.microsoft.com/en-us/azure/devops/pipelines/languages/xcode?view=vsts
