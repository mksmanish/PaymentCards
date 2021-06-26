//
//  CellIndentifiers.swift
//  assignment_25
//
//  Created by manish on 25/06/21.
//

import Foundation
class CellIndentifers : NSObject {
    enum indenti {
       
        static let YouPaidCellTableViewCell = "YouPaidCellTableViewCell"
        static let YouReceivedTableViewCell = "YouReceivedTableViewCell"
        static let YouRequestedTableViewCell = "YouRequestedTableViewCell"
        static let RequestreceivedTableViewCell = "RequestreceivedTableViewCell"
      
    }
    
    enum url {
        static let baseURL = "https://dev.onebanc.ai/assignment.asmx/GetTransactionHistory?userId=1&recipientId=2"
    }
   
}
