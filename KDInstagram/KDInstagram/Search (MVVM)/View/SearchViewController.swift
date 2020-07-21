//
//  SecondViewController.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/12/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController, UITableViewDelegate, UICollectionViewDelegate {

    @IBOutlet weak var suggestedPostCollectionView: UICollectionView!
    @IBOutlet weak var gridLayout: GridLayout!
    
    
    var arrInstaBigCells = [Int]()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        return searchBar
    }()
    
    var searchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()

    lazy var tbview: UITableView = {
        let tbview = UITableView()
        tbview.translatesAutoresizingMaskIntoConstraints = false
        tbview.alpha = 0
        tbview.keyboardDismissMode = .onDrag
        tbview.tableFooterView = UIView()
        tbview.register(SearchedUserTableViewCell.self, forCellReuseIdentifier: "searchedUserCell")
        tbview.frame = self.view.bounds
        tbview.separatorStyle = .none
        view.addSubview(tbview)
        return tbview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        DispatchQueue.global(qos: .background).async {
            self.searchViewModel.requestData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupView(){
        navigationItem.titleView = searchBar
        searchBar.rx.cancelButtonClicked.subscribe({ _ in
            self.endEdit()
        }).disposed(by: disposeBag)
        searchBar.rx.textDidBeginEditing.subscribe({ _ in
            self.searchBar.setShowsCancelButton(true, animated: true)
            UIView.animate(withDuration: 0.3, animations:{
                self.tbview.alpha = 1
            })
        }).disposed(by: disposeBag)
        searchBar.rx.textDidEndEditing.subscribe(onNext: {
            self.searchBar.resignFirstResponder()
            if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }).disposed(by: disposeBag)
        searchBar.rx.searchButtonClicked.subscribe(onNext: {
            self.searchBar.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        
        tbview
            .rx
            .itemSelected
            .subscribe(onNext: { index in
                self.tbview.deselectRow(at: index, animated: true)
            }).disposed(by: disposeBag)
        
        
        arrInstaBigCells.append(1)
        var tempStorage = false
        for _ in 1...21 {
            if(tempStorage){
                arrInstaBigCells.append(arrInstaBigCells.last! + 10)
            } else {
                arrInstaBigCells.append(arrInstaBigCells.last! + 8)
            }
            tempStorage = !tempStorage
        }
        
        gridLayout.delegate = self
        gridLayout.itemSpacing = 3
        gridLayout.fixedDivisionCount = 3
        
    }
    
    private func endEdit(){
        UIView.animate(withDuration: 0.3, animations:{
            self.searchBar.setShowsCancelButton(false, animated: true)
            self.searchBar.text = ""
            self.tbview.alpha = 0
        })
        self.searchBar.resignFirstResponder()

    }
    
    // Configure Bindings
    private func setupBinding(){
        
        // Table View Binding
        let searchedUsers = searchBar.rx.text
            .orEmpty
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)  // 0.5 seconds wait
            .distinctUntilChanged()
            .flatMapLatest({ searchText -> Observable<[User]> in
                if searchText == "" {
                    return Observable.just(self.searchViewModel.getAllUsers())
                } else {
                    return self.searchViewModel.search(text: searchText)
                }
            })
            .observeOn(MainScheduler.instance)
        
        searchedUsers
            .asObservable()
            .bind(to: tbview.rx.items(cellIdentifier: "searchedUserCell", cellType: SearchedUserTableViewCell.self)) { (row, user, cell) in
                cell.configure(user: user)
        }.disposed(by: disposeBag)
        
        tbview.rx.modelSelected(User.self)
            .subscribe(onNext: { user in
                self.searchViewModel.navigateToProfile(view: self, user: user)
            }).disposed(by: disposeBag)
        
        tbview.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        // Colelction View Binding
        searchViewModel
            .suggestedPosts
            .asObserver()
            .observeOn(MainScheduler.instance)
            .bind(to: suggestedPostCollectionView.rx.items) { (collectionView, index, post) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedPostCell", for: indexPath) as! SuggestedPostCollectionViewCell
                cell.configure(post: post)
                return cell
        }.disposed(by: disposeBag)
        
        
        // When a cell is selected
        suggestedPostCollectionView
            .rx
            .modelSelected(Post.self)
            .subscribe(onNext: { post in
                self.searchViewModel.navigateToPost(view: self, post: post)
            }).disposed(by: disposeBag)
        
        suggestedPostCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }


}


extension SearchViewController: GridLayoutDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - PrimeGridDelegate
    
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
        if(arrInstaBigCells.contains(indexPath.row) || (indexPath.row == 1)){
            return 2
        } else {
            return 1
        }
    }
    
    func itemFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat {
        return fixedDimension
    }
}
