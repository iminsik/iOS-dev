# iOS app development

## What's next?
- [ ] Replace PromiseKit with AsyncTask in a feature branch
  ```swift
    func testIsValidTicketNumber_WhenNotValid_ReturnsFalse() {
        let ticketNumbers = ["ZXVCDZZ", "Z1c2fg", "11111", ";BBBBB"]
        for ticketNumber in ticketNumbers {
            let actual = FindTicketController.IsValidTicketNumber(ticketNumber)
            XCTAssert(actual == false, String(format: ticketNumber + " should not be valid."))
        }
    }
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
