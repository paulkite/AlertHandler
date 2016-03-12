# V77AlertHandler

##Usage examples:

### Quick Alert

````swift
V77AlertHandler.displayAlert(title: "Title", message: "Message")
````
Presents alert with provided title, message, and an empty cancel button.

![alertwithcancel](https://cloud.githubusercontent.com/assets/4093007/13721034/496ce102-e7ce-11e5-95c6-a1bd0010c57b.png)

### Login Dialog

````swift
let alertController = V77AlertHandler.displayAlert(
    title: "Title",
    message: "Message",
    actions: [
    	UIAlertAction(title: "Login", style: .Default, handler: { (action) -> Void in
    		let username = alertController.textFields.first.text
    		let password = alertController.textFields.last.text
    		
    		Request.Login(username: username, password: password, completion: nil)
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

![alertwithtextfields](https://cloud.githubusercontent.com/assets/4093007/13721039/4d97af64-e7ce-11e5-9fc1-6f16b6db6f76.png)

### Action Sheet

````swift
V77AlertHandler.displayActionSheet(
    title: "Title",
    message: "Message",
    actions: [
    	UIAlertAction(title: "First", style: .Default, handler: nil),
    	UIAlertAction(title: "Second", style: .Destructive, handler: nil),
    	UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    ]
)
````
Presents an action sheet with two option actions and a custom cancel action.

![actionsheetwithcancel](https://cloud.githubusercontent.com/assets/4093007/13721223/0003b7ec-e7d4-11e5-8f30-b16b0a505cc6.png)
