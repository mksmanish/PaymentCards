//
//  YouReceivedTableViewCell.swift
//  assignment_25
//
//  Created by manish on 24/06/21.
//

import UIKit
// This class represets the cell elements of YouReceived Cell
class YouReceivedTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTransection: UILabel!
    @IBOutlet weak var lblYouPaid: UILabel!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var dateOfTransection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    /// function used for the setting of UI
    func setupUI() {
        ContentView.layer.borderWidth = 1.5
        ContentView.layer.borderColor = UIColor.black.cgColor
    }


}
