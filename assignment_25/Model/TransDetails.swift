//
//  TransDetails.swift
//  assignment_25
//
//  Created by manish on 25/06/21.
//

import Foundation
import UIKit
// MARK: Parmeters of transection Details
struct TransDetails:Codable
{
    var userId:Int?
    var receipeintId:Int?
    var result:[transactions]?

    enum CodingKeys: String, CodingKey{
        case userId = "userId"
        case receipeintId = "receipeintId"
        case result = "transactions"
    }
}

struct transactions:Codable
{
   
    var id:Int?
    var startDate:String?
    var endDate: String?
    var amount:Float?
    var direction:Int?
    var type:Int?
    var status:Int?
    var description:String?
    var customer:CustomerInfo?
    var partner:parnerInfo?
    

    enum CodingKeys: String, CodingKey{
        case id = "id"
        case startDate = "startDate"
        case endDate = "endDate"
        case amount = "amount"
        case direction = "direction"
        case type = "type"
        case status = "status"
        case description = "description"
        case customer = "customer"
        case partner = "partner"
    }
    
}
struct CustomerInfo:Codable{
    var vPayId:Int?
    var vPay:String?
    
    enum CodingKeys: String, CodingKey{
        case vPayId = "vPayId"
        case vPay = "vPay"
    }
    
}

struct parnerInfo:Codable{
    var vPayId:Int?
    var vPay:String?
    
    enum CodingKeys: String, CodingKey{
        case vPayId = "vPayId"
        case vPay = "vPay"
    }
    
}




