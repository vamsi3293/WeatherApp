//
//  ViewController.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//

import UIKit

class HomeScreenController: UIViewController {

	lazy var viewModel = {
		ForecastVM()
	}()

	let currentLocation: UILabel = {
	   let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "...Location"
		label.textAlignment = .left
		label.textColor = .label
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
		return label
	}()
	
	let currentTime: UILabel = {
	   let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "...Date "
		label.textAlignment = .left
		label.textColor = .label
		label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
		return label
	}()
	let tableView:UITableView = {
		let tView = UITableView()
		tView.translatesAutoresizingMaskIntoConstraints = false
		return tView
		
	}()
	
	

  override func viewDidLoad() {
	super.viewDidLoad()
	view.backgroundColor = .white
	  setupViews()
	  layoutViews()
	  tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "cell")
	  tableView.delegate = self
	tableView.dataSource = self
	  tableView.allowsSelection = false

	  initViewModel()
  }

	//initialises the viewmodel for the controller
	func initViewModel() {
		
		viewModel.reloadData = { [weak self] in
			if let forecastData = self?.viewModel.forecastData{
				DispatchQueue.main.async {
					self?.tableView.reloadData()
					self?.currentLocation.text = "\(forecastData.location.name) , \(forecastData.location.country)"
					self?.currentTime.text = Date.getCurrentDateAndTime()
				}
				
			}
			
		}
		viewModel.getForecastDataFromDefaults()
		
	}
	
	//adds the uielements to main view
	func setupViews() {
		view.addSubview(currentLocation)
		view.addSubview(currentTime)
		view.addSubview(tableView)
		
	}
	
	//adds the autolayout contstraint to view elements
	func layoutViews() {
		
		currentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		currentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
		currentLocation.heightAnchor.constraint(equalToConstant: 70).isActive = true
		currentLocation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18).isActive = true
		
		currentTime.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 4).isActive = true
		currentTime.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
		currentTime.heightAnchor.constraint(equalToConstant: 10).isActive = true
		currentTime.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
		
		tableView.topAnchor.constraint(equalTo: currentTime.bottomAnchor, constant: 20).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18).isActive = true
				
	
	}
}

extension HomeScreenController:UITableViewDelegate,UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let count = viewModel.forecastData?.forecast.forecastday.count{
			return count
		}else{
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ForecastTableViewCell
		if let forecastData = viewModel.forecastData?.forecast.forecastday[indexPath.row]{
			
			cell.configure(with: forecastData)
			
		} else{
			
		}
		return cell
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
	
}
