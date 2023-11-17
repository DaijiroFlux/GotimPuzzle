//
//  ContentView.swift
//  GotimPuzzle
//
//  Created by Daijiro Tsushima on 11/17/23.
//


import SwiftUI

struct Tile: Identifiable {
    let id: Int
    let imageName: String
}

class PuzzleViewModel: ObservableObject {
    @Published var tiles: [Tile] = []

    init() {
        initializeTiles()
    }

    func initializeTiles() {
        // Change "image1", "image2", ..., "image8", "empty" with your image asset names
        let imageNames = (1...8).map { "gotimHand\($0)" } + ["empty"]
        let tileIDs = Array(1...imageNames.count)
        let tiles = zip(tileIDs, imageNames).map { Tile(id: $0, imageName: $1) }
        self.tiles = tiles.shuffled() // Shuffling the tiles at the beginning
    }

    func moveTile(_ tile: Tile) {
        guard let emptyIndex = tiles.firstIndex(where: { $0.imageName == "empty" }),
              let tileIndex = tiles.firstIndex(where: { $0.id == tile.id }) else {
            return
        }

        if isAdjacent(emptyIndex: emptyIndex, tileIndex: tileIndex) {
            tiles.swapAt(emptyIndex, tileIndex)
        }
    }

    func isAdjacent(emptyIndex: Int, tileIndex: Int) -> Bool {
        let gridSize = 3
        let emptyRow = emptyIndex / gridSize
        let emptyColumn = emptyIndex % gridSize

        let tileRow = tileIndex / gridSize
        let tileColumn = tileIndex % gridSize

        return (emptyRow == tileRow && abs(emptyColumn - tileColumn) == 1) ||
               (emptyColumn == tileColumn && abs(emptyRow - tileRow) == 1)
    }
}

struct PuzzleGameView: View {
    @ObservedObject private var viewModel = PuzzleViewModel()

    var body: some View {
        VStack {
            Text("Sliding Puzzle Game")
                .font(.title)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 5) {
                ForEach(viewModel.tiles) { tile in
                    TileView(tile: tile, onTap: { self.viewModel.moveTile(tile) })
                }
            }
        }
        .padding()
    }
}

struct TileView: View {
    let tile: Tile
    let onTap: () -> Void

    var body: some View {
        Image(tile.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .background(Color.blue)
            .cornerRadius(10)
            .onTapGesture {
                onTap()
            }
    }
}

struct PuzzleGameView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGameView()
    }
}
