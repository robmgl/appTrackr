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

    @State private var editedTitle: String
    @State private var editedCompany: String
    @State private var editedStatus: JobStatus

    init(viewModel: JobListViewModel, job: Binding<Job>) {
        self.viewModel = viewModel
        self._job = job
        self._editedTitle = State(initialValue: job.wrappedValue.title)
        self._editedCompany = State(initialValue: job.wrappedValue.company)
        self._editedStatus = State(initialValue: job.wrappedValue.status)
    }

    var body: some View {
        Form {
            Section(header: Text("Edit Job")) {
                TextField("Company", text: $editedCompany) // Company name is first
                TextField("Title", text: $editedTitle) // Job title is second
                Picker("Status", selection: $editedStatus) {
                    ForEach(JobStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
            }

            Section {
                Button(action: {
                    viewModel.updateJob(job: job, newTitle: editedTitle, newCompany: editedCompany, newStatus: editedStatus)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Changes")
                }
            }
        }
        .navigationTitle("Edit Job")
        .onChange(of: job) { _ in
            // This will trigger whenever the job binding changes, which should be handled in the parent view
        }
    }
}








