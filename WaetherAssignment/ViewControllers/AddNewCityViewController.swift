/********************************************************************************
 AddNewCityViewController
 ********************************************************************************
 */

import UIKit


class AddNewCityViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //TODO: Need to change to google map API
    private var cityList: [City] = [City( id: 2643743,name: "London",coord:nil,country: nil),
                            City( id: 6619347,name: "Mumbai",coord:nil,country: nil),
                            City( id: 524901,name: "Moscow",coord:nil,country: nil)]
                
    private  var filteredList: [City] = [City]()
    
    var addCityClousure: ((String)->(Void) )!
   
    private var isSearch: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
   
    }


    private func setUpUI() {
        self.title = "Add City"
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    @IBAction func actionCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionSave(_ sender: AnyObject) {}

}

// MARK: - UISearchBarDelegate Setup
extension AddNewCityViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearch = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarSearchBegin(searchBar)
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearch = true
    }

    func searchBarSearchBegin(_ searchBar: UISearchBar) {
        let strText: String =  searchBar.text!.replacingOccurrences(of: " ", with: "")
        if (strText ).isEmpty {
            isSearch = false
        } else {

            DispatchQueue.main.async {
                self.filteredList.removeAll()
                let foundItems = self.cityList.filter { (($0.name?.uppercased().range(of: strText.uppercased())) != nil) || $0.id == Int(strText) }
                self.filteredList =  foundItems
                self.isSearch = true
                self.tableView.reloadData()
               
            }
        }
    }
}

extension AddNewCityViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCitiesCell", for: indexPath) as? AddCitiesCell else {
            fatalError("AddCitiesCell not found")
        }
        cell.configureCell(filteredList[indexPath.row])
        return cell
    }
}

extension AddNewCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let city = filteredList[indexPath.row]
        if let addCityClousure = self.addCityClousure {
            addCityClousure("\(city.id!)")
            self.dismiss(animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
