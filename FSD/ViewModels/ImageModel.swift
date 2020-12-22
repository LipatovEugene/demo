 

import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FlickrPhoto) {
        imageURL = photo.imageURL
    }
}
