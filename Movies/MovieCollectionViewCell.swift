//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by J Oh on 6/11/24.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let id = "MovieCollectionViewCell"
    
    let posterImageView = UIImageView()
    let endLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(endLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        endLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
        }
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10
        
        endLabel.font = .boldSystemFont(ofSize: 13)
        endLabel.textAlignment = .center
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    

