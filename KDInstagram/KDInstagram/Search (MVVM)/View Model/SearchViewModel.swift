//
//  SearchCollectionViewModel.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/16/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewModel {

    let suggestedPosts = PublishSubject<[Post]>()
    
    var searchTextObservable = BehaviorRelay<String>(value: "")
    var users : [User]
    
    init() {
        users = dataGenerator.getAllUsers()
    }
    
    func requestData(){
        DispatchQueue.global(qos: .background).async {
            let _ = dataGenerator.generateData() { posts in
                self.suggestedPosts.onNext(posts)
            }
        }
    }
    
    func navigateToPost(view: UIViewController, post: Post){
        let vc = PostDetailTableViewController()
        vc.posts = [post]
        vc.index = IndexPath(item: 0, section: 0)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToProfile(view: UIViewController, user: User){
        let vc = ProfileViewController()
        vc.user = user
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getAllUsers() -> [User] {
        return dataGenerator.getAllUsers()
    }
    
    func search( text: String) -> Observable<[User]>{
        let editedText = text.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " "))
        return Observable.create { observer in
            // TODO: - Network Calls
            var searchedUsers = [User]()
            if (editedText.count > 0) {
                searchedUsers = self.users.filter({ $0.username.hasPrefix(editedText) || $0.username.contains(editedText) || $0.name.hasPrefix(editedText) || $0.name.contains(editedText) })
            }
            observer.onNext(searchedUsers)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}
