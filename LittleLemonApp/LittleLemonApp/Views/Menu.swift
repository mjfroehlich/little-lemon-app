//
//  Menu.swift
//  LittleLemonApp
//
//  Created by mf on 26.02.24.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    @State var loaded = false
    
    @State var isKeyboardVisible = false
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    func getMenuData(viewContext: NSManagedObjectContext) {
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let fullMenu = try? decoder.decode(MenuList.self, from: data) {
                    for dish in fullMenu.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = dish.title
                        newDish.price = dish.price
                        newDish.image = dish.image
                    }
                    try? viewContext.save()
                } else {
                    print(error.debugDescription.description)
                }
            } else {
                print(error.debugDescription.description)
            }
        }
        dataTask.resume()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Little Lemon")
                .foregroundColor(Color.primaryColor2)
                .font(.displayFont())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Chicago")
                .foregroundColor(.white)
                .font(.subTitleFont())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("""
             We are a family owned Mediterranean restaurant, just the best for our customers.
             """)
            .foregroundColor(.white)
            .font(.leadText())
            .frame(maxWidth: .infinity, alignment: .leading)
            Text("ORDER FOR DELIVERY!")
                .font(.sectionTitle())
                .foregroundColor(.highlightColor2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading)
            TextField("Search menu", text: $searchText)
                .textFieldStyle(.roundedBorder)

            
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List(dishes) { dish in
                    NavigationLink(destination: DetailItem(dish: dish)) {
                        HStack {
                            VStack {
                                Text(dish.title ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.sectionCategories())
                                    .foregroundColor(.black)
                                Spacer(minLength: 10)
                                Spacer(minLength: 5)
                                Text("$" + (dish.price ?? ""))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.highlightText())
                                    .foregroundColor(.primaryColor1)
                                    .monospaced()
                            }
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(maxWidth: 90, maxHeight: 90)
                            .clipShape(Rectangle())
                        }
                        .padding(.vertical)
                        .frame(maxHeight: 150)

                    }
                }
                .listStyle(.plain)
            }
            
        }
        .background(Color.primaryColor1)
        .frame(maxWidth: .infinity)
        .onAppear {
            if !loaded {
                getMenuData(viewContext: viewContext)
                loaded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                  ascending: true,
                                  selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
