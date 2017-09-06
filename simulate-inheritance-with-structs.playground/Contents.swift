//: Playground - noun: a place where people can play

import Foundation

protocol Renderable {
    func render() -> String
}

struct SocialMediaPost {
    let authorName: String
    let creationDate: Date
    
    let specificData: SocialMediaSpecific
    
    init(authorName: String, creationDate: Date, text: String) {
        self.authorName = authorName
        self.creationDate = creationDate
        self.specificData = .text(TextPostData(text: text))
    }
    
    init(authorName: String, creationDate: Date, imageURL: URL) {
        self.authorName = authorName
        self.creationDate = creationDate
        self.specificData = .image(ImagePostData(imageURL: imageURL))
    }
    
    init(authorName: String, creationDate: Date, videoURL: URL) {
        self.authorName = authorName
        self.creationDate = creationDate
        self.specificData = .video(VideoPostData(videoURL: videoURL))
    }
}

enum SocialMediaSpecific {
    case text(TextPostData)
    case image(ImagePostData)
    case video(VideoPostData)
}

struct TextPostData {
    let text: String
}

struct ImagePostData {
    let imageURL: URL
}

struct VideoPostData {
    let videoURL: URL
}

extension TextPostData: Renderable {
    func render() -> String {
        return "<p>\(text)</p>"
    }
}

extension ImagePostData: Renderable {
    func render() -> String {
        return "<img src=\"\(imageURL)\"/>"
    }
}

extension VideoPostData: Renderable {
    func render() -> String {
        return "<video src=\"\(videoURL)\"/>"
    }
}

extension SocialMediaSpecific: Renderable {
    func render() -> String {
        switch self {
        case let .text(specificData):
            return specificData.render()
        case let .image(specificData):
            return specificData.render()
        case let .video(specificData):
            return specificData.render()
        }
    }
}

extension SocialMediaPost: Renderable {
    func render() -> String {
        return "<div>" +
            "<p>\(authorName) - \(creationDate)</p>" +
            specificData.render() +
        "</div>"
    }
}

let textPost = SocialMediaPost(authorName: "Vincent", creationDate: Date(), text: "This is my profile pic.")
let imagePost = SocialMediaPost(authorName: "Vincent", creationDate: Date(), imageURL: URL(string: "https://avatars3.githubusercontent.com/u/5090957?v=4&s=460")!)

let renderedPosts = [textPost, imagePost].map { $0.render() }.joined()
print(renderedPosts)
