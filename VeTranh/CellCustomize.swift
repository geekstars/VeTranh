//
//  CellCustomize.swift
//  VeTranh
//
//  Created by Hoàng Minh Thành on 9/20/16.
//  Copyright © 2016 Hoàng Minh Thành. All rights reserved.
//

import UIKit

class CellCustomize: UICollectionViewCell {
    
    let kCellWidth:CGFloat = 44
    var filteredImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    func addSubviews() {
        if(filteredImageView == nil)
        {
            filteredImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            filteredImageView.layer.borderColor = tintColor.cgColor
            contentView.addSubview(filteredImageView)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            filteredImageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
}
