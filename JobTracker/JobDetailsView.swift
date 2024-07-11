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
                .font(.headline)
            Text("Company: \(job.company)")
                .font(.subheadline)
            Text("Status: \(job.status.rawValue)")
                .font(.subheadline)
            Text("Date Added: \(dateFormatter.string(from: job.dateAdded))") // New line
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            NavigationLink(destination: EditJobView(viewModel: viewModel, job: $job)) {
                Text("Edit Job")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 20)
            }
        }
        .padding()
        .navigationTitle("Job Details")
    }
}







//#Preview {
//    JobDetailsView(viewModel: <#JobListViewModel#>, job: <#Job#>)
//}
