//
//  MovieTableViewCell.swift
//  The Movies App
//
//  Created by Valentina Guarnizo on 29/03/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var titleMovie: UILabel!
    @IBOutlet private weak var descriptionMovie: UILabel!
    @IBOutlet weak var contentMovie: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentMovie.layer.cornerRadius = 10
        self.imageMovie.layer.cornerRadius = 10
    }
    func setUp(movie: Movie) {
        titleMovie.text = movie.title
        descriptionMovie.text = movie.sinopsis
        imageMovie.imageFromServerURL(urlString: "https://image.tmdb.org/t/p/w200\(movie.image)", placeHolderImage: UIImage(named: "Claqueta")!)
        
        
    }
}
