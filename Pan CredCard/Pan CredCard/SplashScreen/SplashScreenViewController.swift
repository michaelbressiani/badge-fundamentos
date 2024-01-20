//
//  ViewController.swift
//  Pan CredCard
//
//  Created by Michael Bressiani on 20/01/24.
//

import UIKit

protocol Coordinator: AnyObject {
    func navigationListCredCards()
}

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var titleAppLabel: UILabel!
    
    weak var delegate: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsConfig()
        delegate = self
        delegate?.navigationListCredCards()
    }
    
    func elementsConfig() {
        titleAppLabel.text = "Pan CredCard"
        titleAppLabel.textColor = .white
        titleAppLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        view.backgroundColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 240/255.0, alpha: 1.0)
    }
}

extension SplashScreenViewController: Coordinator {
    func navigationListCredCards() {
        let vcString = String(describing: ListCredCardsViewController.self)
        let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? ListCredCardsViewController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        })
    }
}

