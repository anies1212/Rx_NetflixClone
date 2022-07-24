//
//  TitleTableViewCell.swift
//  Rx_NetflixCloneApp
//
//  Created by anies1212 on 2022/07/24.
//

import UIKit
import RxSwift
import RxCocoa

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    var models = [Title]()
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 144, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    var viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        models = []
    }
    
    func configure(element: [Title]){
        viewModel.titles
            .bind(to: collectionView.rx.items(cellIdentifier: TitleCollectionViewCell.identifier, cellType: TitleCollectionViewCell.self)) {[weak self] row, element, cell in
                cell.configure(model: element)
            }
            .disposed(by: disposeBag)
    }

}
