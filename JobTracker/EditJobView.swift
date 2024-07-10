//
//  EditJobView.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI

struct EditJobView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: JobListViewModel
    let job: Job
    
    @State private var title: String
    @State private var company: String
    @State private var selectedStatus: JobStatus
    
    init(viewModel: JobListViewModel, job: Job) {
        self.viewModel = viewModel
        self.job = job
        _title = State(initialValue: job.title)
        _company = State(initialValue: job.company)
        _selectedStatus = State(initialValue: job.status)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Job Title", text: $title)
                    TextField("Company", text: $company)
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(JobStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                }
                
                Button("Save Changes") {
                    viewModel.updateJob(job: job, newTitle: title, newCompany: company, newStatus: selectedStatus)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty || company.isEmpty)
            }
            .navigationTitle("Edit Job")
        }
    }
}


