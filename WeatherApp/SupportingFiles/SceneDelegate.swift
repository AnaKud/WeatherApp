// SceneDelegate.swift
// Created by Anastasiya Kudasheva

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(windowScene: scene)
		self.window?.rootViewController = TabBarAssembly.build()
		self.window?.makeKeyAndVisible()
	}
}
