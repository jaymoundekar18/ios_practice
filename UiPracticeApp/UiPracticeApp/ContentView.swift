import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack{
            List(networkManager.posts){post in
                NavigationLink(destination: DetailedView(url: post.url ?? "https://blog.thomasnet.com/hs-fs/hubfs/shutterstock_774749455.jpg?width=1200&name=shutterstock_774749455.jpg")){
                    NewsView(title: post.title ?? "No Title", author: "Author: \(post.author ?? "UNKNOWN")")
                        .swipeActions(edge: .leading){
                            Button("", systemImage:"hands.and.sparkles"){
                                print("\(post.title ?? "none") Liked")
                            }
                            .tint(.teal)
                        }
                }
                
            }
            .navigationTitle("News App")
            .padding(.bottom, 10)
            
            
        }
        
        .onAppear{
            self.networkManager.fetchData()
        }
    }
}


#Preview {
    ContentView()
}

struct NewsView: View {
    var title: String
    var author: String
    
    
    var body: some View {
        HStack{
            Image(systemName: "doc.richtext")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.purple)
                .padding(.trailing, 10)
            VStack(alignment: .leading){
                Text(title)
                    .font(.title)
                
                    Text(author)
                        .foregroundColor(.gray)
            }
        }
    }
}

























 
