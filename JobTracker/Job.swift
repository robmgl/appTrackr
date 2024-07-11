//
//  Job.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import Foundation

enum JobStatus: String, CaseIterable, Identifiable, Codable {
    case applied = "Applied"
    case phoneScreen = "Phone Screen"
    case firstInterview = "First Interview"
    case secondInterview = "Second Interview"
    case finalInterview = "Final Interview"
    case onSite = "On Site"
    case offer = "Offer"
    case questionable = "Questionable"
    case rejected = "Rejected"
    case toApply = "To Apply"
    
    var id: String { rawValue }
}

class Job: Identifiable, ObservableObject, Equatable, Codable {
    let id: UUID
    @Published var title: String
    @Published var company: String
    @Published var status: JobStatus
    @Published var liked: Bool
    let dateAdded: Date

    init(id: UUID = UUID(), title: String, company: String, status: JobStatus, liked: Bool = false, dateAdded: Date) {
        self.id = id
        self.title = title
        self.company = company
        self.status = status
        self.liked = liked
        self.dateAdded = dateAdded
    }

    static func == (lhs: Job, rhs: Job) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case id, title, company, status, liked, dateAdded
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        company = try container.decode(String.self, forKey: .company)
        status = try container.decode(JobStatus.self, forKey: .status)
        liked = try container.decode(Bool.self, forKey: .liked)
        dateAdded = try container.decode(Date.self, forKey: .dateAdded)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(company, forKey: .company)
        try container.encode(status, forKey: .status)
        try container.encode(liked, forKey: .liked)
        try container.encode(dateAdded, forKey: .dateAdded)
    }
}






