//
//  JobListViewModel.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI
import Combine

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var searchText: String = ""

    var filteredJobs: [Job] {
        if searchText.isEmpty {
            return jobs
        } else {
            return jobs.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.company.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func addJob(company: String, title: String, status: JobStatus) {
        let newJob = Job(company: company, title: title, status: status, dateAdded: Date())
        jobs.append(newJob)
        saveJobs()
    }

    func updateJob(_ job: Job, newStatus: JobStatus) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index].status = newStatus
            jobs[index].updatedDate = Date()  // Update the date when the status changes
            saveJobs()
        }
    }

    func deleteJob(at offsets: IndexSet) {
        jobs.remove(atOffsets: offsets)
        saveJobs()
    }
    
    private func saveJobs() {
        do {
            let data = try JSONEncoder.custom.encode(jobs)
            UserDefaults.standard.set(data, forKey: "jobs")
        } catch {
            print("Failed to encode jobs: \(error)")
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "jobs") {
            do {
                jobs = try JSONDecoder.custom.decode([Job].self, from: data)
            } catch {
                print("Failed to decode jobs: \(error)")
            }
        }
    }
}

extension JSONEncoder {
    static let custom: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}

extension JSONDecoder {
    static let custom: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}










