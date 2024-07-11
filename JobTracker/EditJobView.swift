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

    @State private var newTitle: String
    @State private var newCompany: String
    @State private var newStatus: JobStatus

    init(viewModel: JobListViewModel, job: Binding<Job>) {
        self.viewModel = viewModel
        _job = job
        _newTitle = State(initialValue: job.wrappedValue.title)
        _newCompany = State(initialValue: job.wrappedValue.company)
        _newStatus = State(initialValue: job.wrappedValue.status)
    }

    var body: some View {
        Form {
            Section(header: Text("Edit Job Details")) {
                TextField("Company", text: $newCompany)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)
                TextField("Title", text: $newTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)
                Picker("Status", selection: $newStatus) {
                    ForEach(JobStatus.allCases) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }

            Section {
                Button(action: {
                    // Perform the save action
                    withAnimation {
                        viewModel.updateJob(job: job, newTitle: newTitle, newCompany: newCompany, newStatus: newStatus)
                        // Animate the transition back to the previous screen
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .scaleEffect(1.1) // Slightly increase the button size
                        .animation(.easeInOut(duration: 0.2), value: 1.1) // Add an animation to the button
                }
            }
        }
        .navigationTitle("Edit Job")
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
}










