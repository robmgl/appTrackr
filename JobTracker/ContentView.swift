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
    @State private var isReordering = false // Controls the wiggle animation

    var body: some View {
        NavigationView {
            VStack {
                // Search field
                TextField("Search by job title or company", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List {
                    ForEach(viewModel.filteredJobs) { job in
                        JobCardView(viewModel: viewModel, job: job, isWiggling: isReordering)
                            .onTapGesture {
                                if !isReordering {
                                    selectedJob = job
                                    showingJobDetails = true
                                }
                            }
                    }
                    .onMove(perform: moveJob) // Enable drag-to-reorder
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Workfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton() // Toggles reordering mode
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddJobView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .environment(\.editMode, .constant(isReordering ? .active : .inactive)) // Toggle edit mode
            .onChange(of: isReordering) { _ in
                withAnimation {
                    isReordering.toggle() // Toggles wiggle effect on reorder mode
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
    
    private func moveJob(from source: IndexSet, to destination: Int) {
        viewModel.jobs.move(fromOffsets: source, toOffset: destination)
        viewModel.saveJobs() // Ensure this saves the new order
    }

}



#Preview {
    ContentView()
}
