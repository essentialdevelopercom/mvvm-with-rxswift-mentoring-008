//
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        showPaymentForm()
        
        return true
    }
    
    private func showPaymentForm() {
        let vm = PaymentFormViewModel(service: RandomSuggestionsService())
        let vc = PaymentFormViewController(viewModel: vm)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
    
}
