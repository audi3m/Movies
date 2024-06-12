//
//  ViewController.swift
//  Movies
//
//  Created by J Oh on 6/11/24.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var page = 1
    var endPage = 0
    var totalResults = 0
    var isSearching = false
    var currentQuery = ""
    
    var list: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        
        setSearchBar()
        setCollectionView()
        
        configHierarchy()
        configLayout()
        
    }
    
    private func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
}

// CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            list.count + 1
        } else {
            0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as! MovieCollectionViewCell
        let noImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyPosterCollectionViewCell.id, for: indexPath) as! EmptyPosterCollectionViewCell
        let endCell = collectionView.dequeueReusableCell(withReuseIdentifier: EndOfListCollectionViewCell.id, for: indexPath) as! EndOfListCollectionViewCell
        
        if indexPath.item < list.count {
            let movie = list[indexPath.item]
            if let path = movie.poster_path {
                let url = URL(string: MovieAPI.posterUrl + path)
                cell.posterImageView.kf.setImage(with: url)
            } else {
                noImageCell.titleLabel.text = movie.title
                return noImageCell
            }
        }
        
        if isSearching {
            endCell.scrollToTopButton.addTarget(self, action: #selector(scrollToTop), for: .touchUpInside)
            if list.isEmpty {
                endCell.endLabel.text = "검색 결과가 없습니다"
                endCell.configure(showButton: false)
            } else {
                endCell.endLabel.text = "마지막\n\(totalResults)개 결과"
                endCell.configure(showButton: true)
            }
        }
        
        if indexPath.item < list.count {
            return cell
        } else {
            return endCell
        }
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        collectionView.register(EmptyPosterCollectionViewCell.self, forCellWithReuseIdentifier: EmptyPosterCollectionViewCell.id)
        collectionView.register(EndOfListCollectionViewCell.self, forCellWithReuseIdentifier: EndOfListCollectionViewCell.id)
        collectionView.keyboardDismissMode = .onDrag
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/3, height: width/2.3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    @objc private func scrollToTop() {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

// Prefetch
extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function)
        for item in indexPaths {
            if list.count - 3 == item.row {
                page += 1
                if page <= endPage {
                    requestMovies(query: searchBar.text!)
                }
                
            }
        }
    }
    
}

// UISearchBar
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text!
        
        if currentQuery != query && !query.isBlank {
            isSearching = true
            page = 1
            requestMovies(query: query)
            currentQuery = query
            view.endEditing(true)
        }
        
    }
    
    private func requestMovies(query: String) {
        let url = MovieAPI.url + "?query=\(query)&page=\(page)"
        AF.request(url, parameters: MovieAPI.param, headers: MovieAPI.header).responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                if self.page == 1 {
                    self.list = value.results
                    self.endPage = value.total_pages
                    self.totalResults = value.total_results
                    if !self.list.isEmpty {
                        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    } else {
                        
                    }
                } else {
                    self.list.append(contentsOf: value.results)
                    print("\(self.page)")
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "영화 제목을 검색해보세요"
        searchBar.backgroundImage = UIImage()
    }
    
}
