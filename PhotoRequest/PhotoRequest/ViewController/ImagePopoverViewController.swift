//
//  ImagePopoverViewController.swift
//  PhotoRequest
//
//  Created by skrr on 26.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import UIKit

protocol PhotoDelegate
{
  func passPhotoData(data: Data)
}

class ImagePopoverViewController: UIViewController {
  
  @IBOutlet weak var buttonClose: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  var delegate: PhotoDelegate?
  var imageData: Data?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateImageView()
  }
  func updateImageView() {
    guard let data = imageData else { return }
    imageView.image = UIImage(data: data)
  }
  
}
