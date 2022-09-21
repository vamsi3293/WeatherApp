//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
	
	let imgWeatherCondition:UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	let lblDate: UILabel = {
	   let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .label
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
		return label
	}()
	let lblMinTemp: UILabel = {
	   let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .label
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
		return label
	}()
	let lblMaxTemp: UILabel = {
	   let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .left
		label.textColor = .label
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
		return label
	}()
	
	let cardView:UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViews()
		layoutViews()

		}

	required init?(coder aDecoder: NSCoder) {
		   fatalError("init(coder:) has not been implemented")
	   }
	override func layoutSubviews() {
		super.layoutSubviews()
		cardView.backgroundColor = .white
		cardView.layer.cornerRadius = 10.0
		cardView.layer.shadowColor = UIColor.gray.cgColor
		cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		cardView.layer.shadowRadius = 6.0
		cardView.layer.shadowOpacity = 0.7
	}
	
	func setupViews() {
		contentView.addSubview(cardView)
		cardView.addSubview(imgWeatherCondition)
		cardView.addSubview(lblDate)
		cardView.addSubview(lblMinTemp)
		cardView.addSubview(lblMaxTemp)
		
	}
	func layoutViews() {
		cardView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
		cardView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
		cardView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
		cardView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
		
		imgWeatherCondition.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
		
		imgWeatherCondition.heightAnchor.constraint(equalToConstant: 40).isActive = true
		imgWeatherCondition.widthAnchor.constraint(equalToConstant: 40).isActive = true
		imgWeatherCondition.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
		
		lblDate.topAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
		lblDate.leadingAnchor.constraint(equalTo: imgWeatherCondition.trailingAnchor, constant: 10).isActive = true
		lblDate.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
		
		lblMinTemp.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 5).isActive = true
		lblMinTemp.leadingAnchor.constraint(equalTo: imgWeatherCondition.trailingAnchor, constant: 10).isActive = true
		lblMinTemp.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
		
		lblMaxTemp.topAnchor.constraint(equalTo: lblMinTemp.bottomAnchor, constant: 5).isActive = true
		lblMaxTemp.leadingAnchor.constraint(equalTo: imgWeatherCondition.trailingAnchor, constant: 10).isActive = true
		lblMaxTemp.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true

	}
	func configure(with item: DayForecast) {
		lblDate.text = item.date
		lblMinTemp.text = "Min.Temp : \(item.day.mintemp_c) °C"
		lblMaxTemp.text = "Max.Temp : \(item.day.maxtemp_c) °C"
		imgWeatherCondition.loadImageFromURL(url: "https:\(item.day.condition.icon)")
		
	}
}
