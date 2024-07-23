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
    @State private var showingJobDetails = false
    @State private var selectedJob: Job?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by job title or company", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                if viewModel.filteredJobs.isEmpty {
                    VStack {
                        Image(systemName: "briefcase.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No Applications")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                } else {
                    
                    List {
                        ForEach(viewModel.filteredJobs) { job in
                            JobCardView(viewModel: viewModel, job: job)
                                .onTapGesture {
                                    selectedJob = job
                                    showingJobDetails = true
                                }
                        }
                        .onDelete(perform: viewModel.deleteJob)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("AppTrackr")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddJobView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
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
        }
    }
}


#Preview {
    ContentView()
}
