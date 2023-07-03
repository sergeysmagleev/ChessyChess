//
//  ContentView.swift
//  ChessSwiftUI
//
//  Created by Sergey Smagleev on 05.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var data = GameGrid()
    
    var body: some View {
        Text("  ").padding(10)
        Grid {
            ForEach(data.grid) { row in
                GridRow {
                    Text("\(row.rowNumber)").padding(10)
                    ForEach(row.viewModels) { viewModel in
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(viewModel.backgroundColor))
                                .frame(width: 100, height: 100, alignment: .center)
//                                .overlay(
//                                        RoundedRectangle(cornerRadius: 4)
//                                            .stroke(Color(viewModel.borderColor), lineWidth: 3)
//                                )
                            Image(uiImage: viewModel.icon ?? UIImage())
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 100, height: 100, alignment: .center)
                        .onTapGesture {
                            viewModel.onTap()
                        }
                    }
                    Text("  ").padding(10)
                }
            }
            GridRow {
                ForEach(GameGrid.columnNames, id: \.self) { name in
                    Text(name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
