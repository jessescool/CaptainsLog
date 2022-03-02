import Foundation
import RealmSwift

class User: Object, Identifiable {
    static var defaultUser = User()
    // Required:
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var username: String
    @Persisted var customWords = List<String>()
    
    // Added later:
    @Persisted var tags = List<Tag>()
    var statistics = Statistics()
    
    // naively appends a tag to tags
    func addTag(_ tag: Tag) {
        tags.append(tag)
    }
    
    func addCustomWord(_ word: String) {
        customWords.append(word)
    }
    
    convenience init(username: String) {
        self.init()
        self.id = UUID()
        self.username = username
    }

}


class Tag: EmbeddedObject {
    @Persisted var name: String

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

/// A data structure that contains ONLY computed properties.
struct Statistics {
    var minutesRecorded: TimeInterval { return Double.random(in: 1.0..<10.0) }
    var mostUsedWords: [String] { return ["Gucci", "Louie", "YSL"] }
    // and many more to come
}
