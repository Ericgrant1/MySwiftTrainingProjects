//
//  FirstViewController.swift
//  MySearchImageApp
//
//  Created by Eric on 22.12.2019.
//  Copyright © 2019 Eric Grant. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class FirstViewController: UIViewController {
    
    var pictures: [Model] = []
    var modelType: ModelType = .icons
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFlickrImages()
    }
    
    // Передача фото на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let imageViewController = segue.destination as? ImageViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first {
            imageViewController.image = pictures[indexPath.row]
        }
    }
    
    // Подключение Segment Control
    @IBAction func segmentControlSwitched(_ sender: UISegmentedControl) {
        self.modelType = ModelType(rawValue: sender.selectedSegmentIndex) ?? .icons
        
        collectionView.reloadData()
    }
}

// MARK: - CollectionView
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureCell
        
        let modelPicture = pictures[indexPath.row]
        cell.pictureURL = modelType == .icons ? modelPicture.smallPictureURL : modelPicture.bigPictureURL
        
        return cell
    }
    
    // Добавление CollectionReusableView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        
        if kind == UICollectionView.elementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Searcher", for: indexPath)
        }
        
        return reusableView
    }
    
}

// MARK: - CollectionViewDelegateFlowLayout
// Метод отвечающий за раскладку
extension FirstViewController: UICollectionViewDelegateFlowLayout {
    enum ModelType: Int {
        case icons
        case list
    }
    
    struct Parameters {
        static let numberOfColumns: CGFloat = 3
        static let listRowHeight: CGFloat = 200
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if modelType == .icons {
            let objectWidth = collectionView.bounds.width / Parameters.numberOfColumns
            return CGSize(width: objectWidth, height: objectWidth)
        } else {
            return CGSize(width: collectionView.bounds.width, height: Parameters.listRowHeight)
        }
    }
}

// MARK: - SearchBar
extension FirstViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getFlickrImages(searchText: searchBar.text)
    }
}

// MARK: - Networing
extension FirstViewController {

    // Метод вызывающий и добовляющий activityIndicator
    func getFlickrImages(searchText: String? = nil) {
        MBProgressHUD.showAdded(to: view, animated: true)
        
        fetchFlickrImages(searchText: searchText) { [weak self] pictures in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            
            if let pictures = pictures {
                strongSelf.pictures = pictures
                strongSelf.collectionView.reloadData()
            }
        }
    }
    
    // Метод загружающий данные от сервиса Flickr
    func fetchFlickrImages(searchText: String? = nil, completionHandler: (([Model]?) -> Void)? = nil) {
        let url = URL(string: "https://api.flickr.com/services/rest/")!
        var arguments = [
            "method" : "flickr.interestingness.getList",
            "api_key" : "afe3414b7cefe1feea312ad7e7ec48ab",
            "sort": "relevance",
            "per_page" : "60",
            "format" : "json",
            "nojsoncallback" : "1",
            "extras": "url_q,url_z"
        ]
        
        if let searchText = searchText {
            arguments["method"] = "flickr.photos.search"
            arguments["text"] = searchText
        }
        
        Alamofire.request(url, method: .get, parameters: arguments).validate().responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.data, let json = try? JSON(data: data) else {
                    print("Error while parsing Flickr response")
                    completionHandler?(nil)
                    return
                }
                
                let picturesJSON = json["photos"]["photo"]
                let pictures = picturesJSON.arrayValue.compactMap { Model(json: $0) }
                completionHandler?(pictures)
                
            case .failure(let error):
                print("Error while fetching images: \(error.localizedDescription)")
                completionHandler?(nil)
            }
        }
    }
}
