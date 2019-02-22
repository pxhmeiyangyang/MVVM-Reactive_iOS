//
//  ViewModel.swift
//  MVVM+ReactiveSwift
//
//  Created by pxh on 2019/2/18.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

import Result
import ReactiveSwift

class ViewModel {
    
    struct FormError: Error {
        let reason: String
        
        static let invalidEmail = FormError(reason: "The address must end with `@reactivecocoa.io`.")
        static let mismatchEmail = FormError(reason: "The e-mail addresses do not match.")
        static let usernameUnavailable = FormError(reason: "The username has been taken.")
    }
    
    let email: ValidatingProperty<String, FormError>
    let emailConfirmation: ValidatingProperty<String, FormError>
    let termsAccepted: MutableProperty<Bool>
    
    let submit: Action<(), (), FormError>
    
    let reasons: Signal<String, NoError>
    
    init(userService: UserService) {
        // email: ValidatingProperty<String, FormError>
        email = ValidatingProperty("") { input in
            return input.hasSuffix("@reactivecocoa.io") ? .valid : .invalid(.invalidEmail)
        }
        
        // emailConfirmation: ValidatingProperty<String, FormError>
        emailConfirmation = ValidatingProperty("", with: email) { input, email in
            return input == email ? .valid : .invalid(.mismatchEmail)
        }
        
        // termsAccepted: MutableProperty<Bool>
        termsAccepted = MutableProperty(false)
        
        // `validatedEmail` is a property which holds the validated email address if
        //  the entire form is valid, or it holds `nil` otherwise.
        //
        // The condition used in the `map` transform is:
        // 1. `emailConfirmation` passes validation: `!email.isInvalid`; and
        // 2. `termsAccepted` is asserted: `accepted`.
        let validatedEmail: Property<String?> = Property
            .combineLatest(emailConfirmation.result, termsAccepted)
            .map { email, accepted -> String? in
                return !email.isInvalid && accepted ? email.value! : nil
        }
        
        // The action to be invoked when the submit button is pressed.
        //
        // Recall that `submit` is an `Action` with no input, i.e. `Input == ()`.
        // `Action` provides a special initializer in this case: `init(state:)`.
        // It takes a property of optionals — in our case, `validatedEmail` — and
        // would disable whenever the property holds `nil`.
        submit = Action(unwrapping: validatedEmail) { (email: String) in
            let username = email.replacingOccurrences(of: "@reactivecocoa.io", with: "")
            
            return userService.canUseUsername(username)
                .promoteError(FormError.self)
                .attemptMap { Result<(), FormError>($0 ? () : nil, failWith: .usernameUnavailable) }
        }
        
        // `reason` is an aggregate of latest validation error for the UI to display.
        reasons = Property.combineLatest(email.result, emailConfirmation.result)
            .signal
            .debounce(0.1, on: QueueScheduler.main)
            .map { [$0, $1].compactMap { $0.error?.reason }.joined(separator: "\n") }
    }
    
}
