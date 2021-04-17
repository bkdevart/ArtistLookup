//
//  ContentView.swift
//  ArtistLookup
//
//  Created by Brandon Knox on 4/14/21.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State var value = ""
    @State var key = ""
    @State var media = ""
    @State var results = [Result]()
    @ObservedObject var query = Query()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("\(Query.media[self.query.media])")
                    .resizable()
                    .scaledToFit()
                Form {
                    Section {
                        Picker("Select media", selection: $query.media) {
                            ForEach(0..<Query.media.count) {
                                Text(Query.media[$0])
                            }
                        }
                        Picker("Select key", selection: $query.key) {
                            ForEach(0..<Query.keys.count) {
                                Text(Query.keys[$0])
                            }
                        }
                        TextField("\(Query.keys[self.query.key]) value", text: $value)
                    }
                    
                    Section {
                        Button("Search \(Query.media[self.query.media])") {
                            loadData(media: Query.media[self.query.media],
                                     key: Query.keys[self.query.key],
                                     value: value)
                            print("Searching \(Query.media[self.query.media])...")
                        }
                    }
                    .disabled(value.isEmpty)
                    
                    List(results, id: \.trackId) { item in
                        VStack(alignment: .leading) {
                            Text(item.trackName)
                                .font(.headline)
                            
                            Text(item.collectionName)
                        }
                        
                    }
                }
            }
        }
    }
    
    func loadData(media: String, key: String, value: String) {
        // fix strings with spaces, weird chars
        let fixedValue = value.replacingOccurrences(of: " ", with: "+")
        // https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
        // https://itunes.apple.com/search?term=jack+johnson&limit=25
        guard let url = URL(string: "https://itunes.apple.com/search?\(key)=\(fixedValue)&media=\(media)&limit=25") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try?JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    print("\(media) results returned")
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            print(request)
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
