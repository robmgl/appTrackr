//
//  JobListViewModel.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var searchText = ""

    private let userDefaultsKey = "jobs"

    init() {
        loadJobs()
    }

    var filteredJobs: [Job] {
        jobs.filter { job in
            searchText.isEmpty || job.title.lowercased().contains(searchText.lowercased())
        }
    }

    func loadJobs() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            do {
                jobs = try decoder.decode([Job].self, from: data)
            } catch {
                print("Failed to load jobs: \(error)")
            }
        }
    }

    func saveJobs() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(jobs)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Failed to save jobs: \(error)")
        }
    }

    func addJob(title: String, company: String, status: JobStatus) {
        let newJob = Job(id: UUID(), title: title, company: company, status: status)
        jobs.append(newJob)
        saveJobs()
    }

    func deleteJob(at offsets: IndexSet) {
        jobs.remove(atOffsets: offsets)
        saveJobs()
    }

    func updateJob(job: Job, newTitle: String, newCompany: String, newStatus: JobStatus) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index].title = newTitle
            jobs[index].company = newCompany
            jobs[index].status = newStatus
            saveJobs()
        }
    }
}

