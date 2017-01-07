//: Playground - noun: a place where people can play

import Foundation

// MARK: StringConvertible

struct User {
    let name: String
    let id = UUID()
}

extension User: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.name = value
    }
    
    init(unicodeScalarLiteral value: String) {
        self.name = value
    }
    
    init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }
}

let firstUser: User = "first"

// MARK: ArrayConvertible

struct Users {
    let users: [User]
    let id = UUID()
}

extension Users: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: User...) {
        self.users = elements
    }
}

let users = [firstUser, "second"]