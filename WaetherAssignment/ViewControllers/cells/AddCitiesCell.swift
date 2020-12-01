/********************************************************************************
 AddCitiesCell
 ********************************************************************************
 */
import UIKit

class AddCitiesCell : UITableViewCell {
    
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var cityId : UILabel!
 
    func configureCell(_ city: City){
        self.cityLabel.text = city.name
        self.cityId.text = "\(city.id!)"
       
    }
}
