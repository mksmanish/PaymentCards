//
//  ViewController.swift
//  assignment_25
//
//  Created by manish on 24/06/21.
//

import UIKit
import Alamofire
import SwiftyJSON

// this class represents the main viewcontroller

class ViewController: UIViewController,CancelRequest{
   
    // MARK: IBOutlets
    @IBOutlet weak var tblHistory: UITableView!
    var arrHistory = [transactions]()
    var transectionGroup: [[transactions]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        self.setupUI()
        self.callAPIrouter()
        
    }
    func cancelRequestParameter(index: Int) {
        print(index)
    }
    
    // function to setUp the UI
    func setupUI() {
        
        self.tblHistory.register(UINib(nibName: "Youpaid", bundle: nil), forCellReuseIdentifier: CellIndentifers.indenti.YouPaidCellTableViewCell)
        self.tblHistory.register(UINib(nibName: "YouReceived", bundle: nil), forCellReuseIdentifier: CellIndentifers.indenti.YouReceivedTableViewCell)
        self.tblHistory.register(UINib(nibName: "YouRequested", bundle: nil), forCellReuseIdentifier: CellIndentifers.indenti.YouRequestedTableViewCell)
        self.tblHistory.register(UINib(nibName: "Requestreceived", bundle: nil), forCellReuseIdentifier: CellIndentifers.indenti.RequestreceivedTableViewCell)
    }
    
    //function to get the data from the API calling
    func callAPIrouter() {
        AF.request(CellIndentifers.url.baseURL)
            .validate()
            .responseDecodable(of: TransDetails.self) { (response) in
                guard let historyDetails = response.value else { return }
                let resultData = historyDetails.result
                
                self.arrHistory = self.getValuesForTimeline(arrAccounts : resultData!)
                var dataInGroup = Dictionary(grouping: self.arrHistory, by:  { getDateToGroup(date: $0.startDate!) })
              //  let Maindata = dataInGroup.sorted(by: {$0.key < $1.key})

                self.transectionGroup.append(contentsOf: dataInGroup.values)
                self.tblHistory.reloadData()
                
                
            }
    }
    
    //function returns the array of transection values
    func getValuesForTimeline(arrAccounts : [transactions]) -> [transactions]
    {
        var arrValuesInfoDetails = [transactions]()
        for accnt in arrAccounts{
            var objAcnt = transactions()
            objAcnt.amount = accnt.amount
            objAcnt.description = accnt.description
            objAcnt.type = accnt.type
            objAcnt.status = accnt.status
            objAcnt.partner = accnt.partner
            objAcnt.customer = accnt.customer
            objAcnt.direction = accnt.direction
            objAcnt.startDate = accnt.startDate
            objAcnt.endDate = accnt.endDate
            objAcnt.id = accnt.id
            arrValuesInfoDetails.append(objAcnt)
        }
        return arrValuesInfoDetails
    }
    
}

// function to convert the date to required format from UTC
func getDateFromUTC(date:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    guard let dt = dateFormatter.date(from: date) else { return "" }
    dateFormatter.timeZone =  TimeZone.current
    dateFormatter.dateFormat = "d MMM yyyy, hh:mm a"
    return dateFormatter.string(from: dt)
}

// function to convert the date to required format from UTC
func getDateToGroup(date:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    guard let dt = dateFormatter.date(from: date) else { return "" }
    dateFormatter.timeZone =  TimeZone.current
    dateFormatter.dateFormat = "d MMM yyyy"
    return dateFormatter.string(from: dt)
}


// MARK: TableView datasources and delegates
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    // returns the number of rows in each section of tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transectionGroup[section].count
    }
    
    // returns the number of sections in tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return transectionGroup.count
    }
    
    
    // returns the header text of the header view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let events = transectionGroup[section]
        let event = events.first
        return "• • • • • • • • • • • • • • • • • \(getDateToGroup(date: event?.startDate ?? "")) • • • • • • • • • • • • • "
    }
    
    
    // returns the cell to show in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // confirm and sent condition
        if transectionGroup[indexPath.section][indexPath.row].direction == 1 && transectionGroup[indexPath.section][indexPath.row].status == 2{
            let cell = tblHistory.dequeueReusableCell(withIdentifier: CellIndentifers.indenti.YouPaidCellTableViewCell, for: indexPath) as! YouPaidCellTableViewCell
            cell.lblAmount.text = String(transectionGroup[indexPath.section][indexPath.row].amount ?? 0.0)
            cell.lblCurrency.text = "₹"
            cell.lblTransection.text = String(transectionGroup[indexPath.section][indexPath.row].id ?? 0)
            cell.lblYouPaid.text = "You paid"
            cell.dateOfTransection.text = getDateFromUTC(date: transectionGroup[indexPath.section][indexPath.row].startDate ?? "")
            cell.selectionStyle = .none
            return cell
            //confirm and recived condition
        }else if transectionGroup[indexPath.section][indexPath.row].direction == 2 && transectionGroup[indexPath.section][indexPath.row].status == 2 {
            let cell = tblHistory.dequeueReusableCell(withIdentifier: CellIndentifers.indenti.YouReceivedTableViewCell, for: indexPath) as! YouReceivedTableViewCell
            cell.lblAmount.text = String(transectionGroup[indexPath.section][indexPath.row].amount ?? 0.0)
            cell.lblCurrency.text = "₹"
            cell.lblTransection.text = String(transectionGroup[indexPath.section][indexPath.row].id ?? 0)
            cell.lblYouPaid.text = "You received"
            cell.dateOfTransection.text = getDateFromUTC(date: transectionGroup[indexPath.section][indexPath.row].startDate ?? "")
            cell.selectionStyle = .none
            return cell
            //sent and request condition
        }else if transectionGroup[indexPath.section][indexPath.row].status == 1 && transectionGroup[indexPath.section][indexPath.row].direction == 1 {
            let cell = tblHistory.dequeueReusableCell(withIdentifier: CellIndentifers.indenti.YouRequestedTableViewCell, for: indexPath) as! YouRequestedTableViewCell
            cell.lblAmount.text = String(transectionGroup[indexPath.section][indexPath.row].amount ?? 0.0)
            cell.lblCurrency.text = "₹"
            cell.lblYouPaid.text = "You requested"
            cell.dateOfTransection.text = getDateFromUTC(date: transectionGroup[indexPath.section][indexPath.row].startDate ?? "")
            cell.index = indexPath.row
            cell.delegateRequested = self
            cell.selectionStyle = .none
            return cell
            //request and recived condition
        }else{
            let cell = tblHistory.dequeueReusableCell(withIdentifier: CellIndentifers.indenti.RequestreceivedTableViewCell, for: indexPath) as! RequestreceivedTableViewCell
            cell.lblAmount.text = String(transectionGroup[indexPath.section][indexPath.row].amount ?? 0.0)
            cell.lblCurrency.text = "₹"
            cell.lblYouPaid.text = "Request received"
            cell.dateOfTransection.text = getDateFromUTC(date: transectionGroup[indexPath.section][indexPath.row].startDate ?? "")
            cell.selectionStyle = .none
            return cell
            
        }
        
    }
    
    // navigation of each each cell on select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailsController") as! DetailsController
        vc.transectionDetails = transectionGroup[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // styling of the header present in the tableview
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 13.0)
        }
    }
    
    // returns the height of row in tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 130 for the youpaid,recived and requested
        // 150 for the requested received
        if transectionGroup[indexPath.section][indexPath.row].direction == 1 && transectionGroup[indexPath.section][indexPath.row].status == 2{
            return 130
        }else if transectionGroup[indexPath.section][indexPath.row].direction == 2 && transectionGroup[indexPath.section][indexPath.row].status == 2{
            return 130
        }else if transectionGroup[indexPath.section][indexPath.row].status == 1 && transectionGroup[indexPath.section][indexPath.row].direction == 1 {
            return 130
        }else{
            return 150
        }
    }
}
