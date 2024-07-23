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
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Company: \(job.company)")
                .font(.system(size: 30))
                .bold()
            Text("Position: \(job.title)")
                .font(.system(size: 30))
            Text("Status: \(job.status.rawValue)")
                .font(.system(size: 20))
                .bold()
            if let updatedDate = job.updatedDate {
                Text("Updated: \(dateFormatter.string(from: updatedDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Text("Date Added: \(dateFormatter.string(from: job.dateAdded))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: EditJobView(viewModel: viewModel, job: $job)) {
                    Text("Update Job")
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.blue)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                        .cornerRadius(8)
                        .padding(.bottom, 20)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 15)
        .navigationTitle("Job Details")
    }
}

