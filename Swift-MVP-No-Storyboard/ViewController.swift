//
//  ViewController.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import UIKit

class ViewController: UIViewController {
    var presenter: PresenterProtocol?
    
    init(with presenter: PresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: screenSize)
        myView.backgroundColor = UIColor.white
        self.view.addSubview(myView)
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}

extension ViewController: PresenterDelegate {
    func renderProfile(profile: ProfileViewModel) {
        
    }
    
    func render(errorMessage: String) {
        
    }
    func renderLoading() {
        
    }
    func render(profile:ProfileViewModel) {
        
    }
}
