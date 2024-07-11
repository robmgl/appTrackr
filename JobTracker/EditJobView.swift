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
    @Binding var job: Job
    
    @State private var title: String
    @State private var company: String
    @State private var selectedStatus: JobStatus
    
    init(viewModel: JobListViewModel, job: Binding<Job>) {
        self.viewModel = viewModel
        _job = job
        _title = State(initialValue: job.wrappedValue.title)
        _company = State(initialValue: job.wrappedValue.company)
        _selectedStatus = State(initialValue: job.wrappedValue.status)
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
                    job.title = title
                    job.company = company
                    job.status = selectedStatus
                    viewModel.updateJob(job: job, newTitle: title, newCompany: company, newStatus: selectedStatus)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty || company.isEmpty)
            }
            .navigationTitle("Edit Job")
        }
    }
}






