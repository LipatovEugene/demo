 
import UIKit

class FlickrImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var filterName = ""
    static let nibName = "FlickrImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        imageView.image = nil
    }
    
    var model: ImageModel? {
        didSet {
            if let model = model {
                imageView.image = UIImage(named: "placeholder")
                imageView.downloadImage(model.imageURL ,filter:filterName)
            }
        }
    }
}
