//
//  Job.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import Foundation

enum JobStatus: String, CaseIterable, Identifiable, Codable {
    case applied = "Applied"
    case interview = "Interview"
    case offer = "Offer"
    case rejected = "Rejected"
    
    var id: String { rawValue }
}

struct Job: Identifiable, Codable {
    let id: UUID
    var title: String
    var company: String
    var status: JobStatus
}

