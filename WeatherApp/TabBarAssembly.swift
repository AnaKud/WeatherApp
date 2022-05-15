// TabBarAssembly.swift
// Created by Anastasiya Kudasheva

import UIKit

final class TabBarAssembly {
	static func build() -> UITabBarController {
		let weatherController = UINavigationController(rootViewController: CurrentWeatherAssembly.buid())
		let diaryVC = UINavigationController(rootViewController: WeatherDiaryAssembly.build())
		let tabbar = UITabBarController()
		tabbar.tabBar.backgroundColor = .clear
		tabbar.setViewControllers([weatherController, diaryVC], animated: true)
		weatherController.tabBarItem = UITabBarItem(title: "Current", image: UIImage(named: "sunnyTabbar"), tag: 0)
		diaryVC.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(named: "edit"), tag: 1)
		tabbar.tabBar.tintColor = .white
		tabbar.tabBar.unselectedItemTintColor = .black
		return tabbar
	}
}
