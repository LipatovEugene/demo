 
import UIKit

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [FlickrPhoto]
    let total: String
 
}
