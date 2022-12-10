//
//  ViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 01.12.22.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DefaultNetworkService().request(InTheatresMoviesRequest()) { result in
            switch result {
            case .success(let data):
                print(data.items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

