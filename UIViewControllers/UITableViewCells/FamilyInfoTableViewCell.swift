

import UIKit

class FamilyInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var btnUpload2: UIButton!
    @IBOutlet weak var btnUpload1: UIButton!
    @IBOutlet weak var btnHitOk: UIButton!
    @IBOutlet weak var txtRePassword: AETextFieldValidator!
    @IBOutlet weak var txtPassword: AETextFieldValidator!
    @IBOutlet weak var txtUserName: AETextFieldValidator!
    @IBOutlet weak var txtBirthday: AETextFieldValidator!
    @IBOutlet weak var txtChildLastName: AETextFieldValidator!
    @IBOutlet weak var txtChildFirstName: AETextFieldValidator!
    @IBOutlet weak var txtRelation: AETextFieldValidator!
    @IBOutlet weak var txtParentLastName: AETextFieldValidator!
    @IBOutlet weak var txtParentFirstname: AETextFieldValidator!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if txtRePassword != nil {
            self.setTextFieldBorder(textField: txtRePassword)
        }
        
        if txtPassword != nil {
            self.setTextFieldBorder(textField: txtPassword)
        }
        if txtUserName != nil {
            self.setTextFieldBorder(textField: txtUserName)
        }
        if txtBirthday != nil {
            self.setTextFieldBorder(textField: txtBirthday)
        }
        if txtChildLastName != nil {
            self.setTextFieldBorder(textField: txtChildLastName)
        }
        if txtChildFirstName != nil {
            self.setTextFieldBorder(textField: txtChildFirstName)
        }
        
        if txtRelation != nil {
            self.setTextFieldBorder(textField: txtRelation)
            txtRelation.rightview(Img: UIImage.init(named: "imgArrow")!)
        }
        if txtParentLastName != nil {
            self.setTextFieldBorder(textField: txtParentLastName)
        }
        if txtParentFirstname != nil {
            self.setTextFieldBorder(textField: txtParentFirstname)
        }
        if btnUpload2 != nil {
            btnUpload2.layer.borderColor = appColor.cgColor
            btnUpload2.layer.borderWidth = 1
        }
        if btnUpload1 != nil {
            btnUpload1.layer.borderColor = appColor.cgColor
            btnUpload1.layer.borderWidth = 1
        }
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTextFieldBorder(textField : UITextField){
        textField.layer.borderColor = appColor.cgColor
        textField.layer.borderWidth = 1
        textField.leftview()
        
    }
    
}
