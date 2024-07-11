//
//  ContentView.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JobListViewModel()
    @State private var showingAddJobView = false
    @State private var selectedJob: Job? = nil
    @State private var showingJobDetails = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search by job title", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List {
                    ForEach(viewModel.filteredJobs) { job in
                        VStack(alignment: .leading) {
                            Text(job.title)
                                .font(.headline)
                            Text("Company: \(job.company)")
                            Text("Status: \(job.status.rawValue)")
                            Text("Date Added: \(dateFormatter.string(from: job.dateAdded))") // New line
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            selectedJob = job
                            showingJobDetails = true
                        }
                    }
                    .onDelete(perform: viewModel.deleteJob)
                }
            }
            .navigationTitle("Job Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddJobView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddJobView) {
                AddJobView(viewModel: viewModel)
            }
            .background(
                NavigationLink(
                    destination: selectedJob.map { JobDetailsView(viewModel: viewModel, job: .constant($0)) },
                    isActive: $showingJobDetails,
                    label: { EmptyView() }
                )
                .hidden()
            )
            .onChange(of: selectedJob) { newJob in
                // Ensure that the selected job is updated correctly
                if let updatedJob = newJob {
                    if let index = viewModel.jobs.firstIndex(where: { $0.id == updatedJob.id }) {
                        viewModel.jobs[index] = updatedJob
                        viewModel.saveJobs()
                    }
                }
            }
        }
    }
}







#Preview {
    ContentView()
}
