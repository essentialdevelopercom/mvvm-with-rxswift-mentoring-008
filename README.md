# iOS Dev Mentoring #008 - Test-driven MVVM with RxSwift

![](https://github.com/essentialdevelopercom/mvvm-with-rxswift-mentoring-008/workflows/CI/badge.svg)

Project and source code of the [iOS Dev Mentoring #008 - Test-driven MVVM with RxSwift](https://www.essentialdeveloper.com/ios-dev-mentoring-008-test-driven-mvvm-with-rxswift).

---

## Challenge

Ready to practice and test your skills? Fork the repo and test-drive these extra functionalities:

1. Prevent suggestion requests for empty query strings.

2. Return to 'All fields' state when the keyboard is dismissed (via the return key).

3. When a suggestion is selected:
	- Update the fields according to the suggestion values (if any).
	- There might be a running suggestion request, in which case you should stop/ignore it.
		
4. The suggestion service may fail, but we don't want to bother the user with any error messages because suggestions are not a critical part of the flow, and there's nothing they can do about it. You need to ignore suggestion service errors, so they don't propagate in the stream.

5. As you type in fields that receive suggestions, many async requests will be fired to the suggestions service (one for each character typed). But we want only the latest one to complete (the latest text entered by the user). So, you need to stop/ignore previous requests.

6. Validation:
	- IBAN, Tax number, and Bank name are mandatory fields. So, you need to add Field validation and show formatted errors in the UI.
	- Add a right navbar button to submit the form. The button should be enabled when all fields are valid and disabled when any field is invalid.

7. Load bank name from another service based on the IBAN number
	- Request every time IBAN changes and is valid. But we don't want to override user input, so only request when the bank name is empty.
	- Stop request when the user starts typing in the bank name field to avoid overriding user input.
