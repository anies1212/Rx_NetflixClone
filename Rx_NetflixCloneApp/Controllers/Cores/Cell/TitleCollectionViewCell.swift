//
//  TitleCollectionViewCell.swift
//  Rx_NetflixCloneApp
//
//  Created by anies1212 on 2022/07/24.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
    var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleImageView.frame = contentView.frame
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleImageView.image = nil
    }
    
    func configure(model: Title){
        let baseURL = Constants.imageBaseURL
        guard let posterURL = model.poster_path else {return}
        titleImageView.sd_setImage(with: URL(string: baseURL + posterURL))
    }
    
}
