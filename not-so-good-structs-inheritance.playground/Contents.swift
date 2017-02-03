import UIKit

// Swift does not define a mechanism to handle
// inheritance for struct-based types

// This playground presents a (not so good) way
// to simulate inheritance among struct types
// and discusses potential drawbacks


protocol SocialMediaPost {
    var author: String { get }
    var date: Date { get }
}

extension SocialMediaPost {
    func formattedContent() -> String {
        return self.author + " - " + DateFormatter.localizedString(from: self.date, dateStyle: .medium, timeStyle: .medium)
    }
}

struct TextPost: SocialMediaPost {
    let author: String
    let date: Date
    
    let text: String
    
    func formattedContent() -> String {
        // We statically type self as a SocialMediaPost, and are thus able to 
        // dispatch a call to the default implementation provided by this protocol
        var result = (self as SocialMediaPost).formattedContent()
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
        // We statically type self as a SocialMediaPost, and are thus able to
        // dispatch a call to the default implementation provided by this protocol
        var result = (self as SocialMediaPost).formattedContent()
        result += ": "
        result += self.image.description
        return result
    }
}

let textPost = TextPost(author: "Vincent", date: Date(), text: "This is a great post!")
textPost.formattedContent()
let imagePost = ImagePost(author: "Vincent", date: Date(), image: UIImage())
imagePost.formattedContent()

// Everything seems to work nicely! But beware appearances...
// Let's try some polymorphism

let posts: [SocialMediaPost] = [textPost, imagePost]
posts[0].formattedContent()
posts[1].formattedContent()

// 😢 looks like that when we do polymorphism, things work the way we'd like them too

// Conclusion

// Basically, we tried to achieve something impossible. Swift simply does not implement dynamic dispatch
// of method calls when it comes to structs (and it makes a lot of sense regardig performances!)
