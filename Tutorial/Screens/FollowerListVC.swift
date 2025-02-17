//
//  FollowerListVCViewController.swift
//  Tutorial
//
//  Created by Apple on 01/02/25.
//

import UIKit
import Foundation

class FollowerListVC: UIViewController {

    enum Section{
        case main
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
        
    }
    
    init(userName: String) {
            self.userName = userName
            super.init(nibName: nil, bundle: nil)
        }
    
    var userName: String!
    var page: Int = 1
    var hasMoreFollowers = true
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching: Bool = false
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()

        configureDataSource() // Initialize dataSource after calling super.init
        getFollowers(page: page)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false,animated:false)

    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView?.register(FollowerCellCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCellCollectionViewCell.reuseId)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search for a username"
        searchController.searchBar.delegate = self  // 🔹 Set delegate here
        navigationItem.hidesSearchBarWhenScrolling = false // Ensure it always appears
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
 
    func getFollowers( page:Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) {[weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.dismissLoadingView()
                }

            switch result{
            case .success(let followers):
                if followers.count < 100{self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty{
                    let message = "This user dosen't have any Followers.Go Follow them😄."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                }
                self.updateData(on:self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stull Happened", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCellCollectionViewCell.reuseId, for: indexPath) as! FollowerCellCollectionViewCell
            cell.set(follower: follower)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVCViewController()
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func updateData(on followers:[Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async{
            self.dataSource?.apply(snapShot, animatingDifferences: true)
        }
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        guard hasMoreFollowers else {return}
        if offsetY > contentHeight - height {
            page += 1
            getFollowers(page:page)
        }
    }
    
    
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController){
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}
