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
    @State private var selectedStatus: JobStatus = .applied
    
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
                
                Button("Add Job") {
                    viewModel.addJob(title: title, company: company, status: selectedStatus)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty || company.isEmpty)
            }
            .navigationTitle("Add New Job")
        }
    }
}

