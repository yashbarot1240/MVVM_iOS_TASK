//
//  ViewController.swift
//  Yash_Task
//
//  Created by DevstreeAir2 on 24/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    
    // MARK: IBOutlets
    @IBOutlet var passwordTextField: UITextField!{
        didSet{
            passwordTextField.isSecureTextEntry = true
            passwordTextField.textContentType = .newPassword
            passwordTextField.clipsToBounds = true
        }
    }
    @IBOutlet var emailTextField: UITextField!{
        didSet{
            
            emailTextField.textContentType = .emailAddress
            emailTextField.clipsToBounds = true
        }
    }
    
    
    @IBOutlet var emailErrorLabel: UILabel!{
        didSet{
            
            emailErrorLabel.textColor = .systemRed
            
        }
    }
    @IBOutlet var passwordErrorLabel: UILabel!{
        didSet{
            
            passwordErrorLabel.textColor = .systemRed
            
        }
    }
    
   
    
    
    // MARK: Object
    var userViewModel = UserViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.emailErrorLabel.isHidden = true
        self.passwordErrorLabel.isHidden = true
        
        
        
    }
    
    
    func isValid()->(isValid:Bool,data : [String : Any]){
        guard let emaildAddress = emailTextField.text else { return (false,[:]) }
        guard let password = passwordTextField.text else { return (false,[:]) }

        
        if emaildAddress.isEmpty {
            self.emailErrorLabel.text = "Please enter email address."
            self.emailErrorLabel.isHidden = false
            self.passwordErrorLabel.isHidden = true
            return (false,[:])
        }else if !emaildAddress.isValidEmail(){
            self.emailErrorLabel.text = "This is a invalid email."
            self.emailErrorLabel.isHidden = false
            self.passwordErrorLabel.isHidden = true
            return (false,[:])
        }else if password.isEmpty {
            self.passwordErrorLabel.text = "Please enter password."
            self.emailErrorLabel.isHidden = true
            self.passwordErrorLabel.isHidden = false
            return (false,[:])
        }else if !password.isValidPassword() {
            self.passwordErrorLabel.text = "Passwords require at least 1 up percase, 1 lowercase, and 1 number."
            self.emailErrorLabel.isHidden = true
            self.passwordErrorLabel.isHidden = false
            
            return (false,[:])
        }
        self.emailErrorLabel.isHidden = true
        self.passwordErrorLabel.isHidden = true
        return (true,["email":emaildAddress,"password":password])
        
    }
    
    // MARK: IBAction
    
    @IBAction func btnLogin_Click(_ sender: Any) {
       
        let result = self.isValid()
        
        if result.isValid {
            userViewModel.requestLogin(params: result.data) { (isSuccess,result,error_message) in
                switch result {
                case .failure(let error):
                    print ("failure", error)
                    guard error_message != nil else {
                        return
                    }
                    self.showAlert(withMessage: error_message!)
                case .success(let user) :
                    if let user = user {
                        print ("user", user.userID)
                        if let objDate = user.createdAt?.convertIntoDate() {
                            self.showAlert(withTitle: "login successful", withMessage: "Login User ID : \(user.userID!) Create AT : \(objDate)")
                        }
                    }else{
                        guard error_message != nil else {
                            return
                        }
                        self.showAlert(withMessage: error_message!)
                    }
                    
                case .none:
                    break;
                }
            }
        }
        
    }


}

