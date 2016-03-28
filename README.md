# AlertHandler

##Usage examples:

### Quick Alert

````swift
AlertHandler.displayAlert(title: "Title", message: "Message")
````
Presents alert with provided title, message, and an empty cancel button.

![alertwithcancel](https://cloud.githubusercontent.com/assets/4093007/14069709/37c9fabc-f452-11e5-8c92-43795c106575.png)

### Login Dialog

````swift
let alertController = AlertHandler.displayAlert(
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

![alertwithtextfields](https://cloud.githubusercontent.com/assets/4093007/14069708/37c9cbe6-f452-11e5-8ec1-0085d08549a8.png)

### Action Sheet

````swift
AlertHandler.displayActionSheet(
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

![actionsheetwithcancel](https://cloud.githubusercontent.com/assets/4093007/14069707/374a8638-f452-11e5-8514-95dfd831a53f.png)
