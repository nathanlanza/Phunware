import Foundation

struct Thing {
    let id: Int
    let description: String
    let title: String
    let timestamp: String
    let image: String
    let date: String
    let locationline1: String
    let locationline2: String
    
    init(dict: [String:Any]) {
        id = dict["id"] as? Int ?? 0
        description = dict["description"] as? String ?? "none"
        title = dict["title"] as? String ?? "none"
        timestamp = dict["timestamp"] as? String ?? "none"
        image = dict["image"] as? String ?? "none"
        date = dict["date"] as? String ?? "none"
        locationline1 = dict["locationline1"] as? String ?? "none"
        locationline2 = dict["locationline2"] as? String ?? "none"
    }
    
    static func from(_ json: Any) -> [Thing] {
        return (json as! [[String:Any]]).map { Thing(dict: $0) }
    }
}


