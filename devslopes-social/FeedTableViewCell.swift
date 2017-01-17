//
//  FeedTableViewCell.swift
//  devslopes-social
//
//  Created by Preston Grisham on 1/17/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var captionTextField: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.post = post
        self.captionTextField.text = post.caption
        self.numberOfLikesLabel.text = post.likes.description
        OperationQueue().addOperation {
            let imageData = NSData(contentsOf: NSURL(string: post.imageURL) as! URL)
            OperationQueue.main.addOperation {
                self.mainImageView.image = UIImage(data: imageData as! Data)
            }
        }
        
        
        
    }

}
