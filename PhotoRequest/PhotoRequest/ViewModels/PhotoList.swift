//
//  PhotoList.swift
//  PhotoRequest
//
//  Created by skrr on 21.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import Foundation

class PhotoList {
  var photos: [PhotoItem]? = []
  
  func addPhoto(photo: PhotoItem) {
    photos?.append(photo)
  }
}
