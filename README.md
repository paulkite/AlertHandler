# V77AlertHandler
Simple UIAlertController wrapper.

Usage examples:

![alertwithcancel](https://cloud.githubusercontent.com/assets/4093007/13721034/496ce102-e7ce-11e5-95c6-a1bd0010c57b.png)

````swift
V77AlertHandler.displayAlert(title: "Title", message: "Message")
````
Presents alert with provided title, message, and an empty cancel button.

![alertwithtextfields](https://cloud.githubusercontent.com/assets/4093007/13721039/4d97af64-e7ce-11e5-9fc1-6f16b6db6f76.png)

````swift
let alertController = V77AlertHandler.displayAlert(
    title: "Title",
    message: "Message",
    actions: [
    	UIAlertAction(title: "Login", style: .Default, handler: { (action) -> Void in
    		// Code
    	})
    ],
    textFieldHandlers: [
    	{(usernameField) -> Void in
    		usernameField.placeholder = "Username"
    	},
    	{(passwordField) -> Void in
    		passwordField.placeholder = "Password"
    		passwordField.secureTextEntry = true
    	}
    ],
    tintColor: UIColor.greenColor()
)
````
Presents an alert with two input fields, one action and an empty cancel button, while tinting the buttons to green.
