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
                        }
                        .onTapGesture {
                            selectedJob = job
                        }
                    }
                    .onDelete(perform: viewModel.deleteJob) // Ensure this is here
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
                    destination: JobDetailsView(viewModel: viewModel, job: selectedJob ?? Job(id: UUID(), title: "", company: "", status: .applied)),
                    isActive: Binding(
                        get: { selectedJob != nil },
                        set: { isActive in
                            if !isActive { selectedJob = nil }
                        }
                    ),
                    label: { EmptyView() }
                )
                .hidden()
            )
            .onChange(of: selectedJob) { newJob in
                if newJob == nil {
                    // If selectedJob is nil, pop back to the ContentView
                    // This action is handled by the NavigationLink in the background
                }
            }
        }
    }
}






#Preview {
    ContentView()
}
