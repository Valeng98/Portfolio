//
//  DetailViewController.swift
//  The Movies App
//
//  Created by Valentina Guarnizo on 31/03/22.
//
import Foundation
import UIKit

class DetailViewController: UIViewController { 
    
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var imageFilm: UIImageView!
    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    private var router: RouterHome?
    private let colorApp = UIColor(red: 1.0 / 255.0, green: 77.0 / 255.0, blue: 108.0 / 255.0, alpha: 2.0)
   
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
   
    func setUp() {
        guard let data = movie else { return }
        titleHeader.text = data.title
        descriptionMovie.text = data.sinopsis
        imageFilm.imageFromServerURL(urlString: "https://image.tmdb.org/t/p/w200\(data.image)", placeHolderImage: UIImage(named: "Claqueta")!)
        releaseDate.text = data.realseDate
        originalTitle.text = data.originalTitle
        voteAverage.text = String(data.voteAverage)
        
    }
}
