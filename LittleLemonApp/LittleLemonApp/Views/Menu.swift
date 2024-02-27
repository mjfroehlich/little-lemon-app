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
        }
        .padding()
        .background(Color.primaryColor1)
        .frame(maxWidth: .infinity, maxHeight: 200)
        .onAppear { getMenuData(viewContext: viewContext )}
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
