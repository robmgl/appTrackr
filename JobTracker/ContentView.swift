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
            List {
                ForEach(viewModel.jobs) { job in
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
                .onDelete(perform: viewModel.deleteJob)
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
            .sheet(item: $selectedJob) { job in
                EditJobView(viewModel: viewModel, job: job)
            }
        }
    }
}


#Preview {
    ContentView()
}
