import SwiftUI

struct Recipe: Identifiable {
    let id: UUID = UUID()
    var name: String
    var description: String
    var ingredients: [String]
    var imageURL: String
    var isFavorite: Bool
}

struct ContentView: View {
    @State private var recipes: [Recipe] = [
        Recipe(name: "Margherita Pizza", description: "Classic Neapolitan pizza with fresh basil, mozzarella, and tomato sauce.", ingredients: ["Pizza dough", "San Marzano tomatoes", "Fresh mozzarella", "Basil leaves", "Olive oil", "Salt"], imageURL: "https://images.unsplash.com/photo-1574071318508-1cdbab80d002", isFavorite: false),
        Recipe(name: "Chicken Tikka Masala", description: "Tender grilled chicken in a rich, creamy spiced tomato sauce.", ingredients: ["Chicken breast", "Yogurt", "Garam masala", "Tomato puree", "Heavy cream", "Garlic", "Ginger"], imageURL: "https://images.unsplash.com/photo-1601050690597-df0568f70950", isFavorite: true),
        Recipe(name: "Caesar Salad", description: "Crisp romaine lettuce tossed in a creamy Caesar dressing with croutons and parmesan.", ingredients: ["Romaine lettuce", "Parmesan cheese", "Croutons", "Caesar dressing", "Black pepper"], imageURL: "https://images.unsplash.com/photo-1550304943-4f24f54ddde9", isFavorite: false),
        Recipe(name: "Beef Tacos", description: "Seasoned ground beef in soft corn tortillas with fresh toppings.", ingredients: ["Ground beef", "Corn tortillas", "Taco seasoning", "Lettuce", "Cheddar cheese", "Salsa"], imageURL: "https://images.unsplash.com/photo-1551504734-5ee1c4a1479b", isFavorite: false),
        Recipe(name: "Vegetable Stir Fry", description: "A colorful mix of crisp vegetables tossed in a savory garlic-soy sauce.", ingredients: ["Broccoli", "Bell peppers", "Carrots", "Soy sauce", "Garlic", "Ginger", "Sesame oil"], imageURL: "https://images.unsplash.com/photo-1512058564366-18510be2db19", isFavorite: true),
        Recipe(name: "Chocolate Lava Cake", description: "A decadent dessert with a warm, molten chocolate center.", ingredients: ["Dark chocolate", "Butter", "Eggs", "Sugar", "Flour", "Vanilla extract"], imageURL: "https://images.unsplash.com/photo-1624353365286-3f8d62daad51", isFavorite: false)
    ]

    @State private var searchText: String = ""

    private var filteredRecipes: [Recipe] {
        if searchText.isEmpty { return recipes }
        return recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    private func toggleFavorite(for recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredRecipes) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe, onToggleFavorite: { toggleFavorite(for: recipe) })
                } label: {
                    RecipeRowView(recipe: recipe, onToggleFavorite: { toggleFavorite(for: recipe) })
                }
            }
            .navigationTitle("My Recipes")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search recipes")
        }
    }
}

#Preview {
    ContentView()
}
