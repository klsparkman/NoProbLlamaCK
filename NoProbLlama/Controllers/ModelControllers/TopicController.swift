//
//  TopicController.swift
//  NoProbLlama
//
//  Created by Kelsey Sparkman on 5/10/21.
//

import CloudKit

class TopicController {
    
    // MARK: - Properties
    var topics: [Topic] = []
    static let shared = TopicController()
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - CRUD
    func createTopic(with title: String, dueDate: Date, description: String, completion: @escaping (Result<Topic?, TopicError>) -> Void) {
        let newTopic = Topic(title: title, dueDate: dueDate, description: description)
        let record = CKRecord(topic: newTopic)
        
        privateDB.save(record) { record, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedTopic = Topic(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            self.topics.append(savedTopic)
            completion(.success(savedTopic))
        }
    }
    
    func fetchAllTopics(completion: @escaping (Result<[Topic]?, TopicError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: TopicStrings.recordTypeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            
            let fetchedTopics = records.compactMap({ Topic(ckRecord: $0) })
            self.topics = fetchedTopics
            completion(.success(fetchedTopics))
        }
    }
    
//    func updateTopic(topic: Topic, completion: @escaping (Result<Topic, TopicError>) -> Void) {
//        let record = CKRecord(topic: topic)
//
//        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
//        operation.savePolicy = .changedKeys
//        operation.qualityOfService = .userInteractive
//        operation.mo
//    }
}
