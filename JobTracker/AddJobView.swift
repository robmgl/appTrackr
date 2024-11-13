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

    @State private var company: String = ""
    @State private var title: String = ""
    @State private var status: JobStatus = .toApply

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Job Details")) {
                    TextField("Company Name", text: $company)
                    TextField("Job Title", text: $title)
                    Picker("Status", selection: $status) {
                        ForEach(JobStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                }
                Button(action: {
                    if !company.isEmpty && !title.isEmpty {
                        viewModel.addJob(company: company, title: title, status: status)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add Job")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.headline)
                }
            }
            .navigationTitle("Add Job")
        }
    }
}




