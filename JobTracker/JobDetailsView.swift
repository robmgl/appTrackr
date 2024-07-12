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
    
    // Get the first letter of the company name for the icon
    private var companyInitial: String {
        String(job.company.prefix(1)).lowercased()
    }
    
    // Get the corresponding system image name based on the company initial
    private var companyIconName: String {
        "\(companyInitial).circle.fill"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Large icon for the company
            Image(systemName: companyIconName)
                .font(.system(size: 100))
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            Text("Job Title: \(job.company)")
                .font(.headline)
            Text("Company: \(job.title)")
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
                        .background(Color.clear)
                        .foregroundColor(.blue)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
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
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 15)
        .navigationTitle("Job Details")
    }
}















//#Preview {
//    JobDetailsView()
//}
