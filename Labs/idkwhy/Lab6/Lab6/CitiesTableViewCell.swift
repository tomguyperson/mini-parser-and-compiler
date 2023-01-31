//
//  CityTableViewCell.swift
//  Lab4
//
//  Created by Tommy Mesquita on 2/28/22.
//

import Foundation
import UIKit


class CityTableViewCell: UITableViewCell {

    //@IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var cityImage: UIImageView!{
       didSet {
        cityImage.layer.cornerRadius = cityImage.bounds.width / 2
        cityImage.clipsToBounds = true
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
