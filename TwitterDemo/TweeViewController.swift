//
//  TweeViewController.swift
//  TwitterDemo
//
//  Created by Jose Villanuva on 10/30/16.
//  Copyright © 2016 Jose Villanuva. All rights reserved.
//

import UIKit

class TweeViewController: UIViewController {

    var currentTweet : Tweet!
    
    @IBOutlet weak var retweetedScreenName: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!

    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetsCountLabel: UILabel!
    
    @IBOutlet weak var favoritesCount: UILabel!
    
    
    @IBOutlet weak var replyIconImageView: UIImageView!
    
    @IBOutlet weak var favoriteIconImageView: UIImageView!
    
    @IBOutlet weak var retweetIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let twittercolor = UIColor.init(red: 85/250.0, green: 172/250.0, blue: 238/50.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = twittercolor
       
        loadDisplay()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(TweeViewController.onReplyIcon))
        replyIconImageView.addGestureRecognizer(tapGestureRecognizer)
        replyIconImageView.isUserInteractionEnabled = true
        
        let tapRetweetGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(TweeViewController.onRetweetIcon))
        retweetIconImageView.addGestureRecognizer(tapRetweetGestureRecognizer)
        retweetIconImageView.isUserInteractionEnabled = true
        
        let tapFavoriteGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(TweeViewController.onFavoriteIcon))
        favoriteIconImageView.addGestureRecognizer(tapFavoriteGestureRecognizer)
        favoriteIconImageView.isUserInteractionEnabled = true
        
        
    }
    
    func onReplyIcon()
    {
        print("repying..")
        
        self.performSegue(withIdentifier: "composingSegue", sender: nil)
    }
    
    func onRetweetIcon()
    {
        TwitterClient.sharedInstance?.retweet(id: currentTweet.id!, idstr: currentTweet.idString, succedd: { (response:NSDictionary) in
            
            }, faliure: { (error:NSError) in
                        })
    }
    
    func onFavoriteIcon()
    {
        print("favoriting..")
        TwitterClient.sharedInstance?.favoriteTweet(id: currentTweet.id!, succedd: { (response:NSDictionary) in
                print("succesfully favorited tweet with id \(self.currentTweet.id)")
            }, faliure: { (error:NSError) in
                print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDisplay(){
        
        userImageView.layer.cornerRadius = 4
        userImageView.clipsToBounds = true
        
        if(currentTweet != nil) {
            userImageView.setImageWith(currentTweet.user.profileUrl as! URL)
            userFullNameLabel.text = currentTweet.user.name as? String
            userScreenNameLabel.text = currentTweet.user.screenname as? String
        }
        
        tweetTextLabel.text = currentTweet.text
        
        if let ts = currentTweet.timestamp {
            timestampLabel.text = String(describing: ts)
        }
        
        
        retweetsCountLabel.text = String(currentTweet.retweetCount)
        favoritesCount.text = String(currentTweet.favoritesCount)
    }
    
    @IBAction func onHomeButton(_ sender: AnyObject) {
        dismiss(animated: true) {
        }
    }
    
    
    @IBAction func onReplyButton(_ sender: AnyObject) {
        print("replying...")
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

}
