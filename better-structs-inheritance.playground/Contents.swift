import UIKit

// Swift does not define a mechanism to handle
// inheritance for struct-based types

// This playground presents an interresting way
// to simulate inheritance among struct types

protocol SocialMediaPost {
    var author: String { get }
    var date: Date { get }
    
    func formattedContent() -> String
}

extension SocialMediaPost {
    func formattedMetaData() -> String {
        return self.author + " - " + DateFormatter.localizedString(from: self.date, dateStyle: .medium, timeStyle: .medium)
    }
}

struct TextPost: SocialMediaPost {
    let author: String
    let date: Date
    
    let text: String
    
    func formattedContent() -> String {
        var result = self.formattedMetaData()
        result += ": "
        result += self.text
        return result
    }
}

struct ImagePost: SocialMediaPost {
    let author: String
    let date: Date
    
    let image: UIImage
    
    func formattedContent() -> String {
        var result = self.formattedMetaData()
        result += ": "
        result += self.image.description
        return result
    }
}

let textPost = TextPost(author: "Vincent", date: Date(), text: "This is a great post!")
textPost.formattedContent()
let imagePost = ImagePost(author: "Vincent", date: Date(), image: UIImage())
imagePost.formattedContent()

// Until now, everything looks nice
// Let's try some polymorphism

let posts: [SocialMediaPost] = [textPost, imagePost]
posts[0].formattedContent()
posts[1].formattedContent()

// It's working 😍

// Let's recap on what happened.
// The goal was to simulate an inheritance mechanism for structs.
// ✅ We achieved to factor out common business logic into the protocol SocialMediaPost
// ✅ We are indeed able to call this common logic from the sub-types
// ✅ We are able to use polymorphism when calling a method declared in the protocol SocialMediaPost
// ❌ Common data field still have to be defined within each sub-type (but they are checked at compile-time, so no risk to forget or mispell one)
