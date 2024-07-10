//
//  JobListViewModel.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import Foundation

class JobListViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    
    func addJob(title: String, company: String, status: JobStatus) {
        let newJob = Job(title: title, company: company, status: status)
        jobs.append(newJob)
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
}
