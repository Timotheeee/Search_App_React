//
//  ContentView.swift
//  MOBA2 - Mini Project
//  GitHub Repository Search_App
//
//  Created by Gabriele Pace (pacegab1) & Timothé Laborie (labortim)
//

import SwiftUI

struct Owner : Decodable, Identifiable {
    var login: String
    var avatar_url: String
    var id: String {
        get {
            return login;
        }
    }
}

struct RepositoryOverview : Decodable, Identifiable {
    var name: String
    var description: String?
    //var owner: [Owner]
    var created_at: String
    var forks: Int64
    var id: String {
        get {
            return name;
        }
    }
}

struct RepositoryList : Decodable {
    var items: [RepositoryOverview]
}

struct ContentView: View {
    
    @State var repos = RepositoryList(items: [RepositoryOverview]())
    @State var selected = 0
    @State private var search: String = ""

    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for Repositories", text: $search)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(UIKeyboardType.default).padding()
                Button(action: {
                    repos = loadJSON(s: search)
                    print("loaded the json")
                })
                {
                    Text("Search")
                }
                
                List(repos.items){r in
                    NavigationLink(r.name,destination:DetailView(repo:r))
                }
                
            }
            //.border(Color.black, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .navigationTitle("GitHub Repo Search")
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    struct DetailView : View {
        
        @State var repo : RepositoryOverview
        
        var body: some View {
                VStack(alignment: .leading) {
                    Text("\(repo.name)").font(Font.system(size:30, design: .default))
                    Text("\(repo.description ?? "null")")
                    //Text("\(repo.owner.login)")
                    Text("created: \(repo.created_at)")
                    Text("forks: \(repo.forks)")
                }
        }
    }
}

func loadJSON(s: String) -> RepositoryList {
    do {
        if let url = URL(string: "https://api.github.com/search/repositories?q=" + s) {
            let data = try Data(contentsOf: url)
            print("loaded data")
            let decoder = JSONDecoder()
            print("decoding the json")
            return try decoder.decode(RepositoryList.self, from: data)
        }
    } catch {
        fatalError("Couldn't load file from url bundle:\n\(error)")
    }
    return RepositoryList(items: [RepositoryOverview]())
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
