/********************************************************************************
 CityListViewController
 ********************************************************************************
 */

import UIKit

class CityListViewController: UITableViewController {

    // MARK: - Segues
    enum Segues: String {
        case showDetail = "deailedWeatherVC"
        case saveAddCity = "addWeatherVC"
    }
   
    private var arrayWeather: [Weather.WeatherModel] = [Weather.WeatherModel]()
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private var myCities = ["4163971", "2147714", "2174003"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupUIRefreshControl()
        setupUIActivityControl()
        getWeather()
        setupTimer()
    }
    
    // MARK: - setUpUI
    private func setUpUI() {
        self.title = "Your Cities Weather"
       
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    private func setupUIRefreshControl() {
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(actionPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupUIActivityControl() {
        tableView.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
               
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: tableView, attribute:.centerX, multiplier: 1, constant: 0)
        tableView.addConstraint(horizontalConstraint)
               
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: tableView, attribute: .centerY, multiplier: 1, constant: 0)
        
        tableView.addConstraint(verticalConstraint)
    }

    private func setupTimer() {
      
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.getWeather()
        }
    }
    
    @objc func actionPullRefresh() {
        getWeather()
      
    }
    
    private func getWeather() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        WeatherManager.getWeather(forCities: myCities ) { (weather) in
            DispatchQueue.main.async {
                if let weatherList = weather{
                   
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.arrayWeather = weatherList.list
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
                
            }
        }
    }
    
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayWeather.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            fatalError("WeatherCell not found")
        }
        cell.configureCell(arrayWeather[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segues.showDetail.rawValue, sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let identifier = segue.identifier,
            let segueValue = Segues(rawValue: identifier)
        {

            switch segueValue {
            case .showDetail:
                self.prepareSegueForWeatherDetailVC(for: segue, sender: sender)

            case .saveAddCity:
                self.prepareSegueForAddWeatherVC(segue: segue)
                break

            }

        } else {
            fatalError("segue not found")
        }
    }
}

extension CityListViewController {

    private func prepareSegueForWeatherDetailVC(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let indexPath = sender as? IndexPath,
            let controller = segue.destination as? WeatherDetailViewController
        {
            controller.cityId = "\(self.arrayWeather[indexPath.row].id)"
        }
    }

    private func prepareSegueForAddWeatherVC(segue: UIStoryboardSegue) {
        if
            let navigationController = segue.destination as? UINavigationController,
            let citiesVC = navigationController.viewControllers.first as? AddNewCityViewController
        {
            citiesVC.addCityClousure = { (city) in
                
                self.myCities.append(city)
                self.getWeather()
            }
            
        } else {
            fatalError("NavigationController not found")
        }
    }
}
