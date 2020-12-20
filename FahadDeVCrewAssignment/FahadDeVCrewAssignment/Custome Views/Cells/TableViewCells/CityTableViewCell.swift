 //
//  CityTableViewCell.swift
//  FahadDeVCrewAssignment
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(city:CityModel) {
        self.lblCity.text = city.city
        self.lblState.text = city.state

    }

}
