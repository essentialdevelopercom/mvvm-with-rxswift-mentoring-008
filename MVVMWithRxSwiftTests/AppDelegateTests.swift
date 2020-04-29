//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import XCTest
@testable import MVVMWithRxSwift

class AppDelegateTests: XCTestCase {
    
    func test_didFinishLaunchingWithOptions_setsWindowWithRootNavigationController() {
        let sut = AppDelegate()
        XCTAssertNil(sut.window)
        
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(sut.window)
        XCTAssertTrue(sut.window?.rootViewController is UINavigationController)
        XCTAssertTrue(sut.window?.topViewController is PaymentFormViewController)
    }
    
}

private extension UIWindow {
    var topViewController: UIViewController? {
        (rootViewController as? UINavigationController)?.topViewController
    }
}
