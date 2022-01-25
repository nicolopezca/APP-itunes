//
//  ViewController.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var homeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }  
}

extension ViewController: HomeViewDelegate {
    func cellTapped(artist: Artist) {
        let nextViewController = DetailViewController()
        nextViewController.artist = artist
        navigationController?.pushViewController(nextViewController,
                                                 animated: false)
    }
}
