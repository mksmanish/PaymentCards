//
//  DetailsController.swift
//  assignment_25
//
//  Created by manish on 25/06/21.
//

import UIKit

class DetailsController: UIViewController {
var transectionDetails = transactions()
    
    @IBOutlet weak var lbltransectionID: UILabel!
    @IBOutlet weak var status: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI() {
        lbltransectionID.text = String(transectionDetails.id ?? 0)
        if transectionDetails.status == 2 {
            status.text = "Transection Successful"
            view.backgroundColor = .green
        }else if transectionDetails.status == 1{
            status.text = "Transection Pending"
            view.backgroundColor = .red
        }
        
    }
    

    

}
