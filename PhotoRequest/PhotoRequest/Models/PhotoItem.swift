//
//  PhotoResponse.swift
//  PhotoRequest
//
//  Created by skrr on 20.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import Foundation

struct PhotoItem: Codable {
  let albumId: Int
  let id: Int
  let title: String
  let thumbnailUrl: String
  let url: String
}
