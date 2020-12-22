//
//  ViewController.swift
//  FlickrSearchDemo
//
//  Created by Eugen Lipatov on 22.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl! 
    private var searchBarController: UISearchController!
    private var numberOfColumns: CGFloat = 3.0
    private var viewModel = FlickrViewModel()
    private var isFirstTimeActive = true
    private var filterValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModelClosures()
        let font = UIFont.systemFont(ofSize: 12)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstTimeActive {
            searchBarController.isActive = true
            isFirstTimeActive = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func indexChanged(_ sender: Any) {
    
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            filterValue = ""
            collectionView.reloadData()
            print("case 4:")
        case 1:
            filterValue = "CIDiscBlur"
            collectionView.reloadData()
            print("case 1:")
            print(filterValue)
        case 2:
            filterValue = "CISepiaTone"
            collectionView.reloadData()
            print("case 2:")
            print(filterValue)
        case 3:
            filterValue = "CIZoomBlur"
            collectionView.reloadData()
            print("case 3:")
            print(filterValue)
            
        case 4:
            filterValue = "CIBoxBlur"
            collectionView.reloadData()
            print("case 0:")
            print(filterValue)
        default:
            break
        }
    }

}

//MARK:- Configure UI
extension ViewController {
    
    fileprivate func configureUI() {
        // Do any additional setup after loading the view, typically from a nib.
        
        createSearchBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(nib: FlickrImageCollectionViewCell.nibName)
    }
}

//MARK:- Clousers
extension ViewController {
    
    fileprivate func viewModelClosures() {
        
        viewModel.dataUpdated = { [weak self] in
            print("data source updated")
            self?.collectionView.reloadData()
        }
    }
    
    private func loadNextPage() {
        viewModel.fetchNextPage {
            print("next page fetched")
        }
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.dimsBackgroundDuringPresentation = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        collectionView.reloadData()
        
        viewModel.search(text: text) {
            print("search completed.")
        }
        
        searchBarController.searchBar.resignFirstResponder()
    }
    
}

//MARK:- UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrImageCollectionViewCell.nibName, for: indexPath) as! FlickrImageCollectionViewCell
        cell.imageView.image = nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FlickrImageCollectionViewCell else {
            return
        }
        
        let model = viewModel.photoArray[indexPath.row]
        cell.filterName = filterValue
        cell.model = ImageModel.init(withPhotos: model)
     
          
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)/numberOfColumns, height: (collectionView.bounds.width)/numberOfColumns)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



