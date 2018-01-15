//
//  SuperHeroCell.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/14/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import UIKit

class SuperHeroCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroAvatar: UIImageView!
    private var imageNetworkRequest: Any?
    static let nibName = "SuperHeroCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(hero: MarvelCharacter) {
        nameLabel.text = hero.name
        heroAvatar.contentMode = UIViewContentMode.scaleToFill
        heroAvatar.layer.cornerRadius = heroAvatar.frame.size.width/2
        heroAvatar.clipsToBounds = true
        heroAvatar.image = nil
        if let imgURL = URL(string: hero.thumbnail) {
            let imgRequest = ImageRequest(url: imgURL)
            imageNetworkRequest = imgRequest
            imgRequest.load { [weak self] (image: UIImage?) in
                guard let heroAvatar = image else { return }
                self?.heroAvatar.image = heroAvatar
            }
        }
    }
}
