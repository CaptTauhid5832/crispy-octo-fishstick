import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    var onToggleFavorite: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: recipe.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure(_):
                    Image(systemName: "photo").resizable().scaledToFit().foregroundStyle(.secondary).padding(12)
                default:
                    ProgressView()
                }
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name).font(.headline)
                Text(recipe.description).font(.subheadline).foregroundStyle(.secondary).lineLimit(2)
            }

            Spacer()

            Button {
                onToggleFavorite()
            } label: {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(recipe.isFavorite ? .red : .gray)
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    RecipeRowView(recipe: Recipe(name: "Margherita Pizza", description: "Classic Neapolitan pizza.", ingredients: ["Dough", "Tomatoes", "Mozzarella"], imageURL: "https://images.unsplash.com/photo-1574071318508-1cdbab80d002", isFavorite: true), onToggleFavorite: {})
}
