//
//  LoginController.swift
//  katia
//
//  Created by Hadji on 29/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        
        view.addSubview(segmentControl)
        segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(topContainer)
        topContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        topContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        topContainer.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 8).isActive = true
        topContainerHeightConstraint = topContainer.heightAnchor.constraint(equalToConstant: 160)
        topContainerHeightConstraint?.isActive = true
        setupTopContainer()
        
        view.addSubview(bottomContainer)
        bottomContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bottomContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 30).isActive = true
        bottomContainer.heightAnchor.constraint(equalToConstant: 56).isActive = true
        setupBottomContainer()
    }
    
    var topContainerHeightConstraint: NSLayoutConstraint?
    var confirmPasswordFieldHeightConstraint: NSLayoutConstraint?
    
    let segmentControl: UISegmentedControl = {
        let items = ["Log in", "Register"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentTintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(segmentControlChanged), for: UIControl.Event.valueChanged)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    let topContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let bottomContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    
    let loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        field.textColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)])
        field.font = UIFont.boldSystemFont(ofSize: 16)
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        field.textColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)])
        field.font = UIFont.boldSystemFont(ofSize: 16)
        return field
    }()
    
    let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        field.textColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)])
        field.font = UIFont.boldSystemFont(ofSize: 16)
        return field
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchDown)
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        button.titleLabel?.textColor = .green
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchDown)
        return button
    }()
    
    private func setupTopContainer() {
        topContainer.addSubview(loginField)
        loginField.leftAnchor.constraint(equalTo: topContainer.leftAnchor, constant: 8).isActive = true
        loginField.rightAnchor.constraint(equalTo: topContainer.rightAnchor, constant: -8).isActive = true
        loginField.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 8).isActive = true
        loginField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topContainer.addSubview(passwordField)
        passwordField.leftAnchor.constraint(equalTo: topContainer.leftAnchor, constant: 8).isActive = true
        passwordField.rightAnchor.constraint(equalTo: topContainer.rightAnchor, constant: -8).isActive = true
        passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 8).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topContainer.addSubview(confirmPasswordField)
        confirmPasswordField.leftAnchor.constraint(equalTo: topContainer.leftAnchor, constant: 8).isActive = true
        confirmPasswordField.rightAnchor.constraint(equalTo: topContainer.rightAnchor, constant: -8).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 8).isActive = true
        confirmPasswordFieldHeightConstraint = confirmPasswordField.heightAnchor.constraint(equalToConstant: 0)
        confirmPasswordFieldHeightConstraint?.isActive = true
        
        topContainer.addSubview(loginRegisterButton)
        loginRegisterButton.leftAnchor.constraint(equalTo: topContainer.leftAnchor, constant: 8).isActive = true
        loginRegisterButton.rightAnchor.constraint(equalTo: topContainer.rightAnchor, constant: -8).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 8).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupBottomContainer() {
        bottomContainer.addSubview(forgotPasswordButton)
        forgotPasswordButton.leftAnchor.constraint(equalTo: bottomContainer.leftAnchor, constant: 8).isActive = true
        forgotPasswordButton.rightAnchor.constraint(equalTo: bottomContainer.rightAnchor, constant: -8).isActive = true
        forgotPasswordButton.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 8).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func segmentControlChanged() {
        let selectedIndex = segmentControl.selectedSegmentIndex
        
        if selectedIndex == 0 {
            loginRegisterButton.setTitle("Log in", for: .normal)
            
            topContainerHeightConstraint?.isActive = false
            topContainerHeightConstraint = topContainer.heightAnchor.constraint(equalToConstant: 160)
            topContainerHeightConstraint?.isActive = true
            
            
            confirmPasswordFieldHeightConstraint?.isActive = false
            confirmPasswordFieldHeightConstraint = confirmPasswordField.heightAnchor.constraint(equalToConstant: 0)
            confirmPasswordFieldHeightConstraint?.isActive = true
            
            bottomContainer.isHidden = false
        }
        else {
            loginRegisterButton.setTitle("Create new account", for: .normal)
            
            topContainerHeightConstraint?.isActive = false
            topContainerHeightConstraint = topContainer.heightAnchor.constraint(equalToConstant: 200)
            topContainerHeightConstraint?.isActive = true
            
            confirmPasswordFieldHeightConstraint?.isActive = false
            confirmPasswordFieldHeightConstraint = confirmPasswordField.heightAnchor.constraint(equalToConstant: 40)
            confirmPasswordFieldHeightConstraint?.isActive = true
            
            bottomContainer.isHidden = true
        }
    }
    
    @objc func handleLoginRegister() {
        let login = loginField.text!.trimmingCharacters(in: .whitespaces)
        let password = passwordField.text!.trimmingCharacters(in: .whitespaces)
        let confirmPassword = confirmPasswordField.text!.trimmingCharacters(in: .whitespaces)
        
        let segmentControlSelectedIndex = segmentControl.selectedSegmentIndex
        
        if login.isEmpty || password.isEmpty {
            return
        }
        if segmentControlSelectedIndex == 0 {
            // TODO handle login
            dismiss(animated: true, completion: nil)
        }
        else if segmentControlSelectedIndex == 1 {
            if !password.elementsEqual(confirmPassword){
                return
            }
            
            // TODO handle register
        }
    }
    
    @objc func handleForgotPassword() {
        print("forgot password clicked")
    }
}
