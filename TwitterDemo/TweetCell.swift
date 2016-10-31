//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Jose Villanuva on 10/29/16.
//  Copyright © 2016 Jose Villanuva. All rights reserved.
//

import UIKit

protocol myTableDelegate {
    func myTableDelegate(index: Int)
}

class TweetCell: UITableViewCell {

    var indexNumber : Int!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var retweetedScreenNamaLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var replyIconImageView: UIImageView!
    
    @IBOutlet weak var retweetIconImageView: UIImageView!
    
    @IBOutlet weak var favoriteIconImageView: UIImageView!

    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    var delegate: myTableDelegate?
    
    var tweet : Tweet! {
        didSet {
            
            tweetTextLabel.text = tweet.text! as String

            timeElapsedLabel.text = elapsedTime(postTime: tweet.timestamp!)
            
            if let usr = tweet.user {
                usernameLabel.text = usr.name as String?
                let screenNAme = usr.screenname as String?
                let atScreenname = "@" + screenNAme!
                userScreenNameLabel.text = atScreenname as String?
                userImageView.setImageWith(usr.profileUrl as! URL)
            }
    
        }
    }
    
    func elapsedTime(postTime: NSDate) -> String{
        let interval = postTime.timeIntervalSinceNow
        let ti = NSInteger(interval * -1)
        let seconds = ti % 60
        let minutes = (ti/60) % 60
        let hours = (ti/3600)
        
        if(hours == 0){
            if(minutes == 0){
                return String(seconds) + "s"
            }
            
            return String(minutes) + "m"
        }
        
        return String(hours) + "h"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 4
        userImageView.clipsToBounds = true
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TweetCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
        
        
        // Initialization code
    }
    
    func tapEdit(sender: UITapGestureRecognizer) {
        
        print("printing from cell")
       
        delegate?.myTableDelegate(index: indexNumber)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
