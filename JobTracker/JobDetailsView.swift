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
    let job: Job
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Job Title: \(job.title)")
                .font(.headline)
            Text("Company: \(job.company)")
                .font(.subheadline)
            Text("Status: \(job.status.rawValue)")
                .font(.subheadline)
            
            Spacer()
            
            NavigationLink(destination: EditJobView(viewModel: viewModel, job: job)) {
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