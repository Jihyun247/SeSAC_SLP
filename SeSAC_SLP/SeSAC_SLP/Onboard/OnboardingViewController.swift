//
//  OnboardingViewController.swift
//  SeSAC_SLP
//
//  Created by 김지현 on 2022/01/21.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    var currentPage = 0
    let deviceWidthRatio = UIScreen.main.bounds.width / 375
    let deviceHeightRatio = UIScreen.main.bounds.height / 812
    
    let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        // default 가 0이 아닌듯, 명시해주지 않으니 조금씩 밀린다.
        // minimumLineSpacing & minimumInteritemSpacing 차이점
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return cv
    }()
    let pageControl = UIPageControl()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        constraints()
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {

        let rootVC = UINavigationController(rootViewController: PhoneNumViewController())
        rootVC.modalPresentationStyle = .fullScreen
        self.present(rootVC, animated: true) {
            UserDefaults.beforeAuth = true
        }
    }
    
    func setup() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // register 까먹지말자 !
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
        // cell size == screen size 시 이거 하면 잘 멈춤
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = .sesacGray5
        pageControl.currentPageIndicatorTintColor = .sesacBlack
        
        startButton.fill(text: "시작하기")
        
        [collectionView, pageControl, startButton].forEach { self.view.addSubview($0) }
    }
    
    func constraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-(48 * deviceHeightRatio))
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            // 인디케이터 안보였던 이유 ! width를 greaterThanOrEqualTo 로
            make.width.greaterThanOrEqualTo(100)
            make.bottom.equalTo(startButton.snp.top).offset(-(20 * deviceHeightRatio))
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48 * deviceHeightRatio)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        cell.setup(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}
