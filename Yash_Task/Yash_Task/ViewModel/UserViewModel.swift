//
//  ViewController.swift
//  Yash_Task
//
//  Created by DevstreeAir2 on 24/03/21.
//

import UIKit



class UserViewModel {
    
  
    var user : User? = nil
    // MARK: - Constructor
    init(model: User?  = nil) {
        if let inputModel = model {
            user = inputModel
        }
    }
    
     
}

extension UserViewModel {
    //["email":model.email,"password":model.password]
    func requestLogin(params : [String:Any],completion: @escaping (Bool,Result<User?, Error>?,String?) -> Void) {
        HTTPManager.shared.post(urlString: baseUrl + loginURL, params: params) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
                completion(false,.failure(error),nil)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    
                    let objResult = try ResultData(data: dta)
                    
                    if objResult.result == 1 {
                        completion(true,.success(objResult.data?.user ?? nil),"Something went wrong!")
                    }else{
                        completion(false,.success(objResult.data?.user ?? nil),objResult.errorMessage)
                    }
                    
                    

                    
                    
                } catch  let error {
                    // deal with error from JSON decoding if used in production
                    completion(false,.failure(error),nil)
                }
            }
        }
    }
    
}
