//
//  RouterHome.swift
//  The Movies App
//
//  Created by Valentina Guarnizo on 29/03/22.
//

import UIKit

class RouterHome {

    static let share = RouterHome()
    
    func showHome() -> UIViewController {
        let controller = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        return controller
    }
    
    func showDetail(movie: Movie) -> UIViewController {
        let controller = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.movie = movie
        return controller
    }

}

