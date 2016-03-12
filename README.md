# V77AlertHandler
Simple UIAlertController wrapper.

Usage examples:

![simulator screen shot mar 11 2016 9 05 19 pm](https://cloud.githubusercontent.com/assets/4093007/13720976/18193c28-e7cd-11e5-97c7-98d6a2993bc1.png)

````swift
V77AlertHandler.displayAlert(title: "Title", message: "Message")
````
Presents alert with provided title, message, and an empty cancel button.

![simulator screen shot mar 11 2016 9 05 28 pm](https://cloud.githubusercontent.com/assets/4093007/13720977/1bc88c70-e7cd-11e5-98af-1f693f16188f.png)

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
