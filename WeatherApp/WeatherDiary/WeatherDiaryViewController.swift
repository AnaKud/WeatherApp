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
		self.view.insertSubview(UIImageView(image: UIImage(named: "background")), at: 0)
		self.setupTable()
		self.configureTable()
	}
}

private extension WeatherDiaryViewController {
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
}

extension WeatherDiaryViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell =  tableView.dequeueReusableCell(withIdentifier: WeatherNoteCell.id, for: indexPath) as? WeatherNoteCell else { return UITableViewCell() }
		return cell
	}
}

