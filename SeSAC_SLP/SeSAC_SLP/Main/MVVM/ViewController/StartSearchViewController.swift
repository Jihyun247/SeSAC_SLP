//
//  StartSearchViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/02/11.
//

import Foundation
import UIKit
import RxSwift

class StartSearchViewController: UIViewController {
    
    // MARK: - 인스턴스
    let mainView = StartSearchView()
    let viewModel = StartSearchViewModel()
    //let httpViewModel = MapHTTPViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationController?.navigationBarWithSearchBar(navigationItem: self.navigationItem, searchBar: mainView.searchBar)
        setCollectionView()
    }
    
    func binding() {
        
        let input = StartSearchViewModel.Input(hobbyText: mainView.searchBar.rx.text)
        let output = viewModel.transform(input: input)
        
        output.recommendHobby.subscribe { recommended in
            //
        }
        .disposed(by: disposeBag)

    }
    
    func setCollectionView() {
        
        mainView.otherHobbyCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
        mainView.myHobbyCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
        mainView.otherHobbyCollectionView.delegate = self
        mainView.otherHobbyCollectionView.dataSource = self
        mainView.myHobbyCollectionView.delegate = self
        mainView.myHobbyCollectionView.dataSource = self
    }
}

extension StartSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("개수는 ? \(collectionView.tag)")
        
        if collectionView == mainView.myHobbyCollectionView {
            return 10
        } else if collectionView == mainView.otherHobbyCollectionView {
            return 20
        }
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == mainView.myHobbyCollectionView {
            cell.setup(hobbyType: .myHobby)
            cell.hobbyButton.rx.tap
                .subscribe { _ in
                    // ADD
                }
                .disposed(by: disposeBag)

        } else if collectionView == mainView.otherHobbyCollectionView {
            cell.setup(hobbyType: .otherHobby)
            cell.hobbyButton.rx.tap
                .subscribe { _ in
                    // DELETE
                }
                .disposed(by: disposeBag)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            let label = UILabel()
            label.font = .title4_R14
            label.text = "example text"
            //tagList[indexPath.item]
            label.sizeToFit()
            return label
        }()
        
        let size = label.frame.size
        return CGSize(width: size.width + 16, height: size.height + 16)
    }
}
