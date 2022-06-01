

import UIKit

class ChildListTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
