//
//  Job.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import Foundation

enum JobStatus: String, CaseIterable, Identifiable {
    case applied = "Applied"
    case interview = "Interview"
    case offered = "Offered"
    case rejected = "Rejected"
    
    var id: String { self.rawValue }
}

struct Job: Identifiable {
    let id = UUID()
    var title: String
    var company: String
    var status: JobStatus
}
