
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Wish.title, order: .forward) private var wishes: [Wish]
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
          
    @State private var completedCount: Int = 0
    
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .fontWeight(.light)
                        .font(.title)
                        .padding(.vertical, 2)
                        .swipeActions(edge: .leading) {
                            Button("Delete", role: .destructive) {
                                //                                modelContext.delete(wish)
                                if let index = wishes.firstIndex(where: { $0.id == wish.id }) {
                                    
                                    modelContext.delete(wish)
                                    if wish.isCompleted{
                                        wish.isCompleted.toggle()
                                    }
                                    updateCompletedCount()
                                }
                                updateCompletedCount()
                            }
                        }
                        .strikethrough(wish.isCompleted, color: .red)
                        .onTapGesture(count: 2) {
                            wish.isCompleted.toggle()
                            updateCompletedCount()
                        }
                    
                }
            }.navigationTitle("Wish List")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isAlertShowing.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "") \(completedCount) completed")
                        
                    }
                } .alert("Create new wish", isPresented: $isAlertShowing) {
                    TextField("Enter wish title", text: $title)
                    
                    Button{
                        if !title.trimmingCharacters(in: .whitespaces).isEmpty {
                            modelContext.insert(Wish(title: title))
                            title = ""
                        }
                        else{
                            print("Empty wish")
                        }
                    } label: {Text("Save Wish")}
                    
                    Button("Cancel", role: .cancel) {
                        print("Clicked")
                    }
                    
                    
                }
                .overlay{
                    if(wishes.isEmpty) {
                        ContentUnavailableView("My Wishlist", systemImage: "heart.circle", description: Text("No data availble yet."))
                            .symbolRenderingMode(.monochrome)
                            .foregroundColor(.blue.opacity(0.5))
                    }
                }
        }
        .onAppear {
            updateCompletedCount()
        }
    }
    private func updateCompletedCount() {
        completedCount = wishes.filter { $0.isCompleted }.count
    }
}

//#Preview("List with Sample Data") {
//    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
//    container.mainContext.insert(Wish(title: "Aptiway"))
//    container.mainContext.insert(Wish(title: "TCL"))
//    container.mainContext.insert(Wish(title: "JOBS"))
//    return ContentView()
//        .modelContainer(container)
//}

#Preview("Empty") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
