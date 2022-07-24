//
//  HomeViewController.swift
//  Rx_NetflixCloneApp
//
//  Created by anies1212 on 2022/07/24.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

enum Section: String {
    case trendingMovies
    case trendingTVs
    case popular
    case upcomingMovies
    case topRated
}

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    private let viewModel = HomeViewModel()
    private var titles = [Title]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        viewModel.getTrendingMovies()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func bind(){
        viewModel.titles
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: TitleTableViewCell.identifier, cellType: TitleTableViewCell.self)) { row, element, cell in
                cell.configure(element: [element])
            }
            .disposed(by: disposeBag)
    }
}
