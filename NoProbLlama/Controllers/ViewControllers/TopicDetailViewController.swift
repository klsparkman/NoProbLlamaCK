//
//  TopicDetailViewController.swift
//  NoProbLlama
//
//  Created by Kelsey Sparkman on 5/10/21.
//

import UIKit

class TopicDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var topicDescriptionLabel: UITextView!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var topicDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var topic: Topic? {
        didSet {
            guard let topic = topic else {return}
            updateViews(with: topic)
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTopicButtonTapped(_ sender: Any) {
    }
    

    // MARK: - Functions
    func updateViews(with topic: Topic) {
        
    }
}
