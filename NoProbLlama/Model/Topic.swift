//
//  Topic.swift
//  NoProbLlama
//
//  Created by Kelsey Sparkman on 5/10/21.
//

import CloudKit

struct TopicStrings {
    static let recordTypeKey = "Topic"
    fileprivate static let titleKey = "title"
    fileprivate static let dueDateKey = "dueDate"
    fileprivate static let descriptionKey = "description"
}

class Topic {
    
    let title: String
    let dueDate: Date?
    let description: String?
    
    init(title: String, dueDate: Date, description: String) {
        self.title = title
        self.dueDate = dueDate
        self.description = description
    }
}

extension Topic {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[TopicStrings.titleKey] as? String,
              let dueDate = ckRecord[TopicStrings.dueDateKey] as? Date,
              let description = ckRecord[TopicStrings.descriptionKey] as? String else {return nil}
        
        self.init(title: title, dueDate: dueDate, description: description)
    }
}

extension CKRecord {
    convenience init(topic: Topic) {
        self.init(recordType: TopicStrings.recordTypeKey)
        
        self.setValuesForKeys([
            TopicStrings.titleKey : topic.title,
            TopicStrings.dueDateKey : topic.dueDate ?? Date(),
            TopicStrings.descriptionKey : topic.description ?? ""
        ])
    }
}
