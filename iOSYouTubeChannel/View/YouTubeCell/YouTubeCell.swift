//
//  YouTubeCell.swift
//  iOSYouTubeChannel
//
//  Created by Angelos Staboulis on 26/12/19.
//  Copyright © 2019 Angelos Staboulis. All rights reserved.
//

import UIKit

class YouTubeCell: UITableViewCell {
    @IBOutlet weak var imgVideo: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    var showList:Bool!=false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblDescription.text = nil
        imgVideo.image = nil
    }
}
