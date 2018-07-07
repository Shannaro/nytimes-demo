//
//  ArticleTableViewCell.swift
//  nytimes
//
//  Created by Shantanu Khanwalkar on 07/07/18.
//  Copyright © 2018 Shantanu Khanwalkar. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblByline: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setArticleImageView(withMedia: [Media]) {
        let media = withMedia[0]
        let metadata = media.mediaMetadata.filter { $0.format == "square320" }.first
        if let url = metadata?.url {
            self.imgView.sd_setImage(with: URL(string: url))
        }
    }
}
