import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    var onToggleFavorite: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: recipe.imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure(_):
                        Image(systemName: "photo").resizable().scaledToFit().foregroundStyle(.secondary).padding(40)
                    default:
                        ProgressView()
                    }
                }
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                Text(recipe.name).font(.title).fontWeight(.bold)

                HStack(spacing: 6) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(recipe.isFavorite ? .red : .gray)
                    Text(recipe.isFavorite ? "Favorited" : "Not Favorited")
                        .font(.subheadline).foregroundStyle(.secondary)
                }

                Text(recipe.description).font(.body)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients").font(.headline)
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "circle.fill").font(.system(size: 6)).padding(.top, 6)
                            Text(ingredient)
                        }
                    }
                }

                Button {
                    onToggleFavorite()
                } label: {
                    Label(recipe.isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: recipe.isFavorite ? "heart.slash" : "heart.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(recipe.isFavorite ? Color.gray.opacity(0.2) : Color.red)
                        .foregroundStyle(recipe.isFavorite ? Color.primary : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: Recipe(name: "Margherita Pizza", description: "Classic Neapolitan pizza with fresh basil, mozzarella, and tomato sauce.", ingredients: ["Pizza dough", "Tomatoes", "Mozzarella", "Basil", "Olive oil", "Salt"], imageURL: "https://images.unsplash.com/photo-1574071318508-1cdbab80d002", isFavorite: true), onToggleFavorite: {})
    }
}
