//
//  ContentView.swift
//  MOBA2 - Mini Project
//  GitHub Repository Search_App
//
//  Created by Gabriele Pace (pacegab1) & Timothé Laborie (labortim)
//

import SwiftUI

struct RepositoryOverview : Decodable, Identifiable {
    var name: String
    var description: String
    var owner: String
    var avatar_url: String
    var created_at: String
    var forks: String
    var id: String {
        get {
            return name;
        }
    }
}

struct RepositoryList : Decodable {
    var repoList: [RepositoryOverview]
}

struct ContentView: View {
    
    @State var repo = [RepositoryList]()
    
    var body: some View {
        NavigationView {
            VStack {
                // TextField("Search for Repositories", text: $repo.name)
                  //  .textFieldStyle(RoundedBorderTextFieldStyle())
                  //  .keyboardType(UIKeyboardType.default).padding()
                
                NavigationLink(destination: DetailView()) {
                    Button(action: {
                        
                    }) {
                        Text("Search")
                    }
                }
            }.navigationTitle("GitHub Repo Search")
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    struct DetailView : View {
        
        @State var repo = [RepositoryList]()
        
        var body: some View {
            //List ($repo.repoList) { entry in
                VStack(alignment: .leading) {
                    //Text("\(entry.name)")
                    //Text("\(entry.description)").foot(.footnote)
                }
        /*}*/.onAppear {
                // self.repo = loadJSON()!
            }
        }
    }
}

func loadJSON() -> RepositoryList? {
    do {
        if let url = URL(string: "https://api.github.com/search/repositories?q=") {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(RepositoryList.self, from: data)
        }
    } catch {
        fatalError("Couldn't load file from url bundle:\n\(error)")
    }
    return nil
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
