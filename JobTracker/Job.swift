//
//  Job.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import Foundation

enum JobStatus: String, Codable, CaseIterable, Identifiable {
    case applied, interviewed, offer, rejected
    
    var id: String { rawValue }
}

struct Job: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var company: String
    var status: JobStatus
    let dateAdded: Date // New property
    var liked: Bool // New property to track if the job is liked
    
    init(id: UUID, title: String, company: String, status: JobStatus, dateAdded: Date = Date(), liked: Bool = false) {
        self.id = id
        self.title = title
        self.company = company
        self.status = status
        self.dateAdded = dateAdded
        self.liked = liked
    }
}




