//
//  JobListViewModel.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import Foundation

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = [] {
        didSet {
            saveJobs()
        }
    }
    @Published var searchText = ""

    private let userDefaultsKey = "jobs"

    init() {
        loadJobs()
    }

    func addJob(_ job: Job) {
        jobs.append(job)
    }

    func deleteJob(at offsets: IndexSet) {
        jobs.remove(atOffsets: offsets)
    }

    func updateJob(job: Job, newTitle: String, newCompany: String, newStatus: JobStatus) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index].title = newTitle
            jobs[index].company = newCompany
            jobs[index].status = newStatus
        }
    }

    func toggleLike(job: Job) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index].liked.toggle()
        }
    }

    var filteredJobs: [Job] {
        if searchText.isEmpty {
            return jobs
        } else {
            return jobs.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    private func saveJobs() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601 // Use ISO8601 date encoding strategy
            let data = try encoder.encode(jobs)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Failed to encode jobs: \(error.localizedDescription)")
        }
    }

    private func loadJobs() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Use ISO8601 date decoding strategy
            jobs = try decoder.decode([Job].self, from: data)
        } catch {
            print("Failed to decode jobs: \(error.localizedDescription)")
        }
    }
}






