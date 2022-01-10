//
//  ViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class ViewController: UIViewController, MyDelegate {
    @IBOutlet private weak var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }
    
    func cellTapped() {
        let nextViewController = DetailViewController()
        navigationController?.pushViewController(nextViewController,
                                                 animated: false)
    }
}
