//
//  AddJobView.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI

struct AddJobView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: JobListViewModel
    
    @State private var title = ""
    @State private var company = ""
    @State private var status: JobStatus = .applied

    var body: some View {
        Form {
            Section(header: Text("Add New Job")) {
                TextField("Company", text: $company)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 4)
                Picker("Status", selection: $status) {
                    ForEach(JobStatus.allCases) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }

            Section {
                Button(action: {
                    let newJob = Job(title: title, company: company, status: status, dateAdded: Date())
                    viewModel.addJob(newJob)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Job")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle("Add Job")
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
}



