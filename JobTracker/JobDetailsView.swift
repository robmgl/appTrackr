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
            Text("Job Title: \(job.title)")
                .font(.title2)
                .foregroundColor(.primary)
            Text("Company: \(job.company)")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("Status: \(job.status.rawValue)")
                .font(.body)
                .foregroundColor(.gray)
            Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: EditJobView(viewModel: viewModel, job: $job)) {
                    Text("Edit Job")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .border(Color.accentColor, width: 2)
                        .cornerRadius(10)  // Pill shape
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleLike(job: job)
                }) {
                    Image(systemName: job.liked ? "heart.fill" : "heart")
                        .foregroundColor(job.liked ? Color("HeartColor") : .gray)
                        .font(.system(size: 28)) // Make the heart bigger
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .navigationTitle("Job Details")
    }
}















//#Preview {
//    JobDetailsView(viewModel: <#JobListViewModel#>, job: <#Job#>)
//}
