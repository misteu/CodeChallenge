//
//  PhotoRequestTests.swift
//  PhotoRequestTests
//
//  Created by skrr on 20.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import XCTest
@testable import PhotoRequest

class PhotoRequestTests: XCTestCase {

  
  func testAddPhotoItems() {
    let photoList = PhotoList()
    
    let photoItem1 = PhotoItem(albumId: 1, id: 1, title: "1", thumbnailUrl: "1.de", url: "11.de")
    let photoItem2 = PhotoItem(albumId: 1, id: 2, title: "2", thumbnailUrl: "2.de", url: "22.de")
    let photoItem3 = PhotoItem(albumId: 1, id: 3, title: "3", thumbnailUrl: "3.de", url: "33.de")
    
    photoList.addPhoto(photo: photoItem1)
    photoList.addPhoto(photo: photoItem2)
    photoList.addPhoto(photo: photoItem3)
    
    XCTAssertTrue(photoList.photos?.count == 3, "should have 3 elements")
    
  }
  
  func testParseJson() {
    guard let testJson = """
    [
      {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
      },
      {
        "albumId": 1,
        "id": 2,
        "title": "reprehenderit est deserunt velit ipsam",
        "url": "https://via.placeholder.com/600/771796",
        "thumbnailUrl": "https://via.placeholder.com/150/771796"
      },
      {
        "albumId": 1,
        "id": 3,
        "title": "officia porro iure quia iusto qui ipsa ut modi",
        "url": "https://via.placeholder.com/600/24f355",
        "thumbnailUrl": "https://via.placeholder.com/150/24f355"
      },
      {
        "albumId": 1,
        "id": 4,
        "title": "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
        "url": "https://via.placeholder.com/600/d32776",
        "thumbnailUrl": "https://via.placeholder.com/150/d32776"
      }]
    """.data(using: .utf8) else { return }
    
    var photoItems = [PhotoItem]()
    
    API.photoList.decodeJson(data: testJson) { (result) in
      switch result {
      case .success(let items as [PhotoItem]):
        photoItems = items
        
      default:
        XCTFail("parsing not possible")
      }
    }
    
    XCTAssertTrue(photoItems.count == 4, "should have four items")
  }
  
  func testValidContentOfParsedJson() {
    guard let testJson = """
    [
      {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
      }]
    """.data(using: .utf8) else { return }
    
    var photoItems = [PhotoItem]()
    
    API.photoList.decodeJson(data: testJson) { (result) in
      switch result {
      case .success(let items as [PhotoItem]):
        photoItems = items
        
      default:
        XCTFail("parsing not possible")
      }
    }
    
    XCTAssertTrue(photoItems.first?.albumId == 1, "should be 1")
    XCTAssertTrue(photoItems.first?.id == 1, "should be 1")
    XCTAssertTrue(photoItems.first?.title == "accusamus beatae ad facilis cum similique qui sunt", "should be accusamus beatae ad facilis cum similique qui sunt")
    XCTAssertTrue(photoItems.first?.url == "https://via.placeholder.com/600/92c952", "should be https://via.placeholder.com/600/92c952")
    XCTAssertTrue(photoItems.first?.thumbnailUrl == "https://via.placeholder.com/150/92c952", "should be https://via.placeholder.com/150/92c952")
  }

}
