//
//  PhotoOverviewController.swift
//  PhotoRequest
//
//  Created by skrr on 20.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import UIKit

class PhotoOverviewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tableView: UITableView!
  
  let photos = PhotoList()
  let photoDetailVc = ImagePopoverViewController()
  
  override func viewWillAppear(_ animated: Bool) {
     presentActivityIndicator()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    API.photoList.makeRequest { (data) in
      
      switch data {
        
      case .success(let data):
        API.photoList.decodeJson(data: data, completion: { (decoded) in
          switch decoded {
            
          case .success(let photoList as [PhotoItem]):
            self.updatePhotoList(photoList)
            
          case .failure(let failure):
            print("error \(failure)")
            
          case .success(_):
            print("no photos in response")
          }
        })
        
      case .failure(let failureString):
        print(failureString)
      }
    }
    setupTableView()
  }
  
  func updatePhotoList(_ photoList: [PhotoItem]) {
    photoList.forEach({ [weak self] (item) in
      self?.photos.addPhoto(photo: item)
    })
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.hideActivityIndicator()
    }
  }
}

extension PhotoOverviewController: UITableViewDataSource, UITableViewDelegate  {
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.photos?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoListCell.self), for: indexPath) as? PhotoListCell else { return UITableViewCell() }
    
    cell.cellData = photos.photos?[indexPath.row]
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let urlString = NSString(string: photos.photos?[indexPath.row].url ?? "")
    API.photoItem(urlString.lastPathComponent).makeRequest { (result) in
      switch result {
      case .success(let image):
        print("image")
        
        self.photoDetailVc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.passPhotoData(data: image)
        DispatchQueue.main.async {
          self.presentActivityIndicator()
        }
        self.present(self.photoDetailVc, animated: true, completion: {
          DispatchQueue.main.async {
            self.hideActivityIndicator()
          }
        })
        
      case .failure(let failure):
        print(failure)
      }
    }
  }
  
  func presentActivityIndicator() {
    self.activityIndicator.isHidden = false
    self.tableView.isHidden = true
  }
  
  func hideActivityIndicator() {
    self.activityIndicator.isHidden = true
    self.tableView.isHidden = false
  }
  
  
}

extension PhotoOverviewController: PhotoDelegate {
  
  func setupPhotoPopover() {
    photoDetailVc.delegate = self
  }
  
  func passPhotoData(data: Data) {
    photoDetailVc.imageData = data
  }
  
  
}
