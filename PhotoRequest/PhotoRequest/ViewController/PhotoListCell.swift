//
//  PhotoListCell.swift
//  PhotoRequest
//
//  Created by skrr on 22.08.19.
//  Copyright © 2019 mic. All rights reserved.
//

import UIKit

class PhotoListCell: UITableViewCell {
  
  @IBOutlet weak var labelAlbumId: UILabel!
  @IBOutlet weak var labelId: UILabel!
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelUrl: UILabel!
  @IBOutlet weak var labelThumbnailUrl: UILabel!
  
  var cellData: PhotoItem? {
    didSet {
      updateCell()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func updateCell() {
    self.labelAlbumId.text = "\(cellData?.albumId ?? 0)"
    self.labelId.text = "\(cellData?.id ?? 0)"
    self.labelThumbnailUrl.text = cellData?.thumbnailUrl
    self.labelTitle.text = cellData?.title
    self.labelUrl.text = cellData?.url
  }
  
}
