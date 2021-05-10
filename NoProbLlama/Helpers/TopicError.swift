//
//  TopicError.swift
//  NoProbLlama
//
//  Created by Kelsey Sparkman on 5/10/21.
//

import Foundation

enum TopicError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .couldNotUnwrap:
            return "There was an error unwrapping the topic!"
        }
    }
}
