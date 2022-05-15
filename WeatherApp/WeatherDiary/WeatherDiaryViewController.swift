// WeatherDiaryViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

final class WeatherDiaryViewController: UIViewController {
	private let tableView = UITableView()
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupUI()
	}
}

private extension WeatherDiaryViewController {
	func setupUI() {
		let image = UIImageView(image: UIImage(named: "background"))
		image.contentMode = .scaleAspectFill
		self.view.addSubview(image)
		image.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		self.setupNav()
		self.setupTable()
		self.configureTable()
	}
	
	func setupNav() {
		let image = UIImage(named: "edit")

		let nav = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(self.onNewNoteTapped))
		nav.tintColor = .white
		self.navigationItem.setRightBarButton(nav, animated: false)
	}
	
	func setupTable() {
		self.view.addSubview(self.tableView)
		self.tableView.backgroundColor = .clear
		self.tableView.snp.makeConstraints { make in
			make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview()
		}
	}

	func configureTable () {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = .none
		self.tableView.register(WeatherNoteCell.self, forCellReuseIdentifier: WeatherNoteCell.id)
	}

	@objc
	func onNewNoteTapped() {
		let nextVC = WeatherNoteAssembly.build()
		self.navigationController?.pushViewController(nextVC, animated: true)
		self.navigationController?.navigationBar.tintColor = .white
	}
}

extension WeatherDiaryViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell =  tableView.dequeueReusableCell(withIdentifier: WeatherNoteCell.id, for: indexPath) as? WeatherNoteCell else { return UITableViewCell() }
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = WeatherNoteViewCotroller()
		self.present(vc, animated: true)
	}
}

