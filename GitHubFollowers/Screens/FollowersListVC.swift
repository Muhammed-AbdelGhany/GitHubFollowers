//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/20/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section{case main}
    
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username ,page: page)
        configureDataSource()
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreecolumnFlowLayout())
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func createThreecolumnFlowLayout()  -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    
    
    func configureSearchController (){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Seach for a username"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    
    
    func getFollowers(username :String , page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username , page: page) { [weak self] result in
            guard let self = self else {return}
            self.dimissLoadinView()
            switch result{
            case .success(let followers) :
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: "You Got No Followers", view: self.view)}
                    return
                }
                self.updateData(followers: followers)
                
            case .failure(let error) :
            self.presentGFAlertOnMainThread(title: "cant get the follower", body: error.rawValue, buttonTitle: "ok")
                           return
            }
            }
    }
    
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    
    
}
extension FollowersListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}



extension FollowersListVC: UISearchResultsUpdating , UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {return}
        
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(followers: filteredFollowers)
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(followers: followers)
    }
    
    
}
