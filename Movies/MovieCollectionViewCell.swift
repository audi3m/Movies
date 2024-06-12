//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by J Oh on 6/11/24.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EmptyPosterCollectionViewCell: UICollectionViewCell {
    
    let noImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(noImageView)
        contentView.addSubview(titleLabel)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.label.cgColor
        
        noImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView).offset(20)
            make.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(noImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(10)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10)
        }
        
        noImageView.image = .movie
        noImageView.tintColor = .label
        noImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.numberOfLines = 0
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EndOfListCollectionViewCell: UICollectionViewCell {
    
    let endLabel = UILabel()
    let scrollToTopButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(endLabel)
        contentView.addSubview(scrollToTopButton)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        
        endLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.horizontalEdges.equalTo(contentView).inset(10)
        }
        
//        scrollToTopButton.snp.makeConstraints { make in
//            make.centerX.equalTo(contentView.snp.centerX)
//            make.top.equalTo(endLabel.snp.bottom).offset(20)
//            make.size.equalTo(30)
//        }
        
        endLabel.textAlignment = .center
        endLabel.numberOfLines = 3
        endLabel.minimumScaleFactor = 0.7
        endLabel.font = .boldSystemFont(ofSize: 15)
        
        scrollToTopButton.setImage(.arrowUp, for: .normal)
        scrollToTopButton.imageView?.contentMode = .scaleAspectFit
        scrollToTopButton.tintColor = .systemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(showButton: Bool) {
        if showButton {
            if scrollToTopButton.superview == nil {
                contentView.addSubview(scrollToTopButton)
                scrollToTopButton.snp.makeConstraints { make in
                    make.centerX.equalTo(contentView.snp.centerX)
                    make.top.equalTo(endLabel.snp.bottom).offset(20)
                    make.size.equalTo(30)
                }
                scrollToTopButton.tintColor = .label

            }
        } else {
            if scrollToTopButton.superview != nil {
                scrollToTopButton.removeFromSuperview()
            }
        }
    }
    
}

