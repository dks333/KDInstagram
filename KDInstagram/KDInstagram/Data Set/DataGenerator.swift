//
//  DataGenerator.swift
//  KDInstagram
//
//  Created by Sam Ding on 7/13/20.
//  Copyright © 2020 Kaishan Ding. All rights reserved.
//

import Foundation
import UIKit

class DataGenerator: NSObject {
    
    private let createdUsers = CreatedUsers()
    private let randomGenerator = RandomGenerator()
    private var users : [User] = []
    
    override init() {
        super.init()
        // Initialize all users
        users = [createdUsers.currentUser, createdUsers.apple, createdUsers.facebook, createdUsers.instagram, createdUsers.league, createdUsers.linkedin, createdUsers.minecraft, createdUsers.spotify, createdUsers.tiktok, createdUsers.wechat, createdUsers.youtube, createdUsers.github, createdUsers.robinhood, createdUsers.uber]
        
        // Add followers and following to each account
        for i in 0..<users.count {
            users[i].followers = createdUsers.getFollowersAndFolloing(except: users[i])
            users[i].following = createdUsers.getFollowersAndFolloing(except: users[i])
        }
        
        // Add post to each account
        if !users.isEmpty {
            for i in 0..<users.count{
                var index = 1
                var imgArr : [UIImage] = []
                // Except for me
                if users[i].username != "dks333" {
                    while let image = UIImage(named: "\(users[i].username)\(index)") {
                        imgArr.append(image)
                        index += 1
                    }
                    if !imgArr.isEmpty{
                        users[i].posts.append(Post(user: users[i], images: imgArr, likedUsers: users[i].followers, caption: randomGenerator.generateCaption(), comments: [], liked: false, bookmarked: false, postTime: randomGenerator.generateDate()))
                    }
                }
            }
            
            // Re-assign users to post
            // TODO: - This initialization is inefficient, needed to be fixed when connecting to database
            for i in 0..<users.count{
                // Except for me
                if users[i].username != "dks333" && users[i].posts.count != 0{
                    for j in 0..<users[i].posts.count {
                        users[i].posts[j].user = users[i]
                    }
                }
            }
        }
        
        // Add post to my account
        var index = 1
        while let image = UIImage(named: "dks333\(index)") {
            users[0].posts.append(Post(user: users[0], images: [image], likedUsers: users[0].followers, caption: randomGenerator.generateCaption(), comments: [], liked: false, bookmarked: false, postTime: randomGenerator.generateDate()))
            index += 1
        }
        index = 1
        for i in 0..<users[0].posts.count {
            users[0].posts[i].user = users[0]
            users[0].posts[i].comments = [Comment(user: users[1], content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed imperdiet ex sapien, a elementum dolor", date: randomGenerator.generateDate(), likes: 0), Comment(user: users[3], content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", date: randomGenerator.generateDate(), likes: 0),]
            index += 1
        }
    }
    
    func getCurrentUser() -> User {
        return users[0]
    }
    
    func getAllUsers() -> [User]{
        return users
    }
    
    func generateData(completion: @escaping ([Post]) -> ()) -> [Post] {
        var posts : [Post] = []
        let unsortedUsers = users.shuffled()
        for user in unsortedUsers{
            posts += user.posts
        }
        completion(posts)
        return posts
    }
}


/**
 Random Text, Mainly used for caption in each Post:
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed imperdiet ex sapien, a elementum dolor dictum eu. Vestibulum nec turpis eget magna luctus laoreet vel a est. Curabitur vitae dui sed arcu commodo semper eget ut quam. Morbi sed dui vel tortor dignissim consectetur. Suspendisse vulputate aliquam ex, in rutrum enim aliquet sit amet. Vestibulum vitae mi lectus. Nunc eget nibh dui. Aliquam vel posuere nulla, quis tincidunt nisl.
 */

class CreatedUsers: NSObject {
    // MARK: - Users
    var currentUser = User(profilePic: UIImage(named: "profile")!, username: "dks333", description: "Hello Everyone, welcome to KDInstagram. \nIf you have any question, open an issue on github or email me dingkaishan@gmail.com \nSupport with a star🌟", name: "Sam", followers: [], following: [], posts: [], stories: [])
    var apple = User(profilePic: UIImage(named: "AppleProfile")!, username: "apple", description: "Watch Tim Cook's video statement and learn about the actions we are taking", name: "apple", followers: [], following: [], posts: [], stories: [])
    var facebook = User(profilePic: UIImage(named: "FacebookProfile")!, username: "facebookapp", description: "Let's find more that brings us together. \nFacebook location", name: "Facebook App", followers: [], following: [], posts: [], stories: [])
    var instagram = User(profilePic: UIImage(named: "InstagramProfile")!, username: "instagram", description: "#ShareBlackStories", name: "Instagram", followers: [], following: [], posts: [], stories: [])
    var linkedin = User(profilePic: UIImage(named: "LinkedInProfile")!, username: "linkedin", description: "When we work together, we can work through anything", name: "LinkedIn", followers: [], following: [], posts: [], stories: [])
    var league = User(profilePic: UIImage(named: "LolProfile")!, username: "leagueoflegends", description: "Download and Play Free #leagueoflegends \nsignup.leagueoflegends.com", name: "League of Legends", followers: [], following: [], posts: [], stories: [])
    var minecraft = User(profilePic: UIImage(named: "MinecraftProfile")!, username: "minecraft", description: "A game about placing blocks and going on adventures. \nCreate! Explore! Survive! Here's how you do it! \nESRB Rating: Everyone 10+ with Fantasy Violence", name: "Minecraft", followers: [], following: [], posts: [], stories: [])
    var spotify = User(profilePic: UIImage(named: "SpotifyProfile")!, username: "spotify", description: "Music and podcasts for every moment \nPlay, discover and share for free", name: "Spotify", followers: [], following: [], posts: [], stories: [])
    var tiktok = User(profilePic: UIImage(named: "TiktokProfile")!, username: "tiktok", description: "Make Your Day \nbit.ly/TikTokProgressReport", name: "Tiktok", followers: [], following: [], posts: [], stories: [])
    var wechat = User(profilePic: UIImage(named: "WechatProfile")!, username: "wechat", description: "Communication App", name: "WeChat", followers: [], following: [], posts: [], stories: [])
    var youtube = User(profilePic: UIImage(named: "YoutubeProfile")!, username: "youtube", description: "Like and subscribe. \nlinkin.bio/youtube", name: "Youtube", followers: [], following: [], posts: [], stories: [])
    var github = User(profilePic: UIImage(named: "GithubProfile")!, username: "github", description: "How people build software. The home of Hithub design. \nvimeo.com/githubanimation", name: "Github", followers: [], following: [], posts: [], stories: [])
    var robinhood = User(profilePic: UIImage(named: "RobinhoodProfile")!, username: "robinhoodapp", description: "Democratizing finance for all. \nSecurities by Robinhood Financial (Member SIPC) \nCrypto by Robinhood Crypto (licensed by NY Dept Financial Services)", name: "Robinhood", followers: [], following: [], posts: [], stories: [])
    var uber = User(profilePic: UIImage(named: "UberProfile")!, username: "uber", description: "For information about the steps we are taking to help keep communities safe in the cities we serve go to -> \nuber.com", name: "Uber", followers: [], following: [], posts: [], stories: [])
    
    func getFollowersAndFolloing(except user: User) -> [User] {
        var arr = [currentUser, apple, facebook, instagram, league, linkedin, minecraft, spotify, tiktok, wechat, youtube, github, robinhood, uber]
        arr.removeAll(where: {$0 == user})
        return arr
    }
}



class RandomGenerator: NSObject {
    
    var randomNum = 0
    
    func generateCaption() -> String{
        let str = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed imperdiet ex sapien, a elementum dolor dictum eu. Vestibulum nec turpis eget magna luctus laoreet vel a est. Curabitur vitae dui sed arcu commodo semper eget ut quam."
        randomNum = Int.random(in: 10..<str.count)
        return str[0..<randomNum]
    }
    
    func generateDate() -> Date{
        randomNum = Int.random(in: 0..<100000)
        return Date().advanced(by: TimeInterval(-randomNum))
    }
}
