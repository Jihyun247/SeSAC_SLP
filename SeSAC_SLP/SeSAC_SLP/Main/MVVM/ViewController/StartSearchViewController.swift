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
    let httpViewModel = MapHTTPViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationController?.navigationBarWithSearchBar(navigationItem: self.navigationItem, searchBar: mainView.searchBar)
        setCollectionView()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        httpViewModel.onqueue(region: UserDefaults.region, lat: UserDefaults.lat, long: UserDefaults.long)
    }
    
    func binding() {
        
        let input = StartSearchViewModel.Input(aroundQueue: httpViewModel.exploreResult , hobbyText: mainView.searchBar.rx.text)
        let output = viewModel.transform(input: input)
        
        output.othersHobby.bind(to: mainView.otherHobbyCollectionView.rx.items(cellIdentifier: HobbyCollectionViewCell.identifier, cellType: HobbyCollectionViewCell.self)) { (row, element, cell) in
            
            cell.setup(hobbyType: .otherHobby)
            row < self.viewModel.recommendHobby.value.count ? cell.hobbyButton.recommended() : cell.hobbyButton.near()
            cell.hobbyButton.setTitle(element, for: .normal)
        }
        .disposed(by: disposeBag)
        
        output.recommendHobby.bind(to: mainView.myHobbyCollectionView.rx.items(cellIdentifier: HobbyCollectionViewCell.identifier, cellType: HobbyCollectionViewCell.self)) { (row, element, cell) in

            cell.setup(hobbyType: .myHobby)
            cell.hobbyButton.setTitle(element, for: .normal)
        }
        .disposed(by: disposeBag)
    }
    
    func setCollectionView() {
        
        mainView.otherHobbyCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
        mainView.myHobbyCollectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
        mainView.otherHobbyCollectionView.delegate = self
        mainView.myHobbyCollectionView.delegate = self
    }
}

extension StartSearchViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        if collectionView == mainView.myHobbyCollectionView {
//            cell.setup(hobbyType: .myHobby)
//            cell.hobbyButton.rx.tap
//                .subscribe { _ in
//                   // ADD
//                }
//                .disposed(by: disposeBag)
//
//        } else if collectionView == mainView.otherHobbyCollectionView {
//            cell.setup(hobbyType: .otherHobby)
//            cell.hobbyButton.rx.tap
//                .subscribe { _ in
//                    // DELETE
//                }
//                .disposed(by: disposeBag)
//        }
//
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            let label = UILabel()
            label.font = .title4_R14
            if collectionView == mainView.otherHobbyCollectionView {
                label.text = viewModel.othersHobby.value[indexPath.item]
            } else {
                label.text = "example!!"
            }
            //tagList[indexPath.item]
            label.sizeToFit()
            return label
        }()
        
        let size = label.frame.size
        return CGSize(width: size.width + 16, height: size.height + 16)
    }
}
