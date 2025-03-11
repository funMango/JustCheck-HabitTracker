//
//  ColorSelectionView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import SwiftUI

struct ColorSelectionCellView: View {
    @ObservedObject var viewModel: ColorSelectionViewModel
            
    var body: some View {
        NavigationLink {
            ColorSelectionView(viewModel: viewModel)
        } label: {
            VStack {
                CaptionText(text: String(localized: "color"))
                    .padding(.bottom, 5)
                
                HStack {
                    ColorDetailView(
                        colorName: viewModel.selectedColor.localized,
                        colorHex: viewModel.selectedColor.hex,
                        size: 10
                    )
                                                            
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                    
                }
            }
        }
    }
}

struct ColorDetailView: View {
    var colorName: String
    var colorHex: String
    var size: CGFloat
        
    var body: some View {
        HStack {
            HabitColorCircle(
                color: colorHex,
                size: size
            )
            
            Text(colorName)
                .foregroundStyle(.blackWhite)
            
            Spacer()
        }
    }
}

#Preview {
    let dataContainer = DataContainer()
    let container = VmContainer(modelContainer: dataContainer.getModelContainer())
    ColorSelectionCellView(viewModel: container.getColorSelectioinViewModel())
        
}
