//
//  LuCycleCollectionViewCell.swift
//  LuCycleView
//
//  Created by Rango on 2018/8/15.
//  Copyright © 2018年 Rango. All rights reserved.
//

import UIKit

class LuCycleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : LuCycleModel? {
        didSet{
            titleLabel.text = cycleModel?.title
            iconImageView.image = UIImage(named: (cycleModel?.pic_url)!)
        }
    }
    

}
