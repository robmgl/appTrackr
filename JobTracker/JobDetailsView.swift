//
//  JobDetailsView.swift
//  JobTracker
//
//  Created by Rob Miguel on 7/10/24.
//

import SwiftUI

struct JobDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: JobListViewModel
    @Binding var job: Job
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Company: \(job.company)")
                .font(.headline)
            Text("Job Title: \(job.title)")
                .font(.subheadline)
            Text("Status: \(job.status.rawValue)")
                .font(.subheadline)
            Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: EditJobView(viewModel: viewModel, job: $job)) {
                    Text("Edit Job")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 20)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleLike(job: job)
                }) {
                    Image(systemName: job.liked ? "heart.fill" : "heart")
                        .foregroundColor(job.liked ? .red : .gray)
                        .font(.title)
                        .scaleEffect(job.liked ? 1.2 : 1.0) // Slightly increase size when liked
                        .animation(.easeInOut(duration: 0.2)) // Add animation
                }
            }
        }
        .padding()
        .navigationTitle("Job Details") // Unchanged title
    }
}










//#Preview {
//    JobDetailsView(viewModel: <#JobListViewModel#>, job: <#Job#>)
//}
