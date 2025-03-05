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
                HStack {
                    Text(String(localized: "color"))
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                HStack {
                    HabitColorCircle(color: viewModel.selectedColor.hex, size: 10)
                    
                    Text(viewModel.selectedColor.localized)
                        .foregroundStyle(.blackWhite)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                    
                }
            }
        }
    }
}

#Preview {
    let dataContainer = DataContainer()
    let container = VmContainer(modelContainer: dataContainer.getModelContainer())
    ColorSelectionCellView(viewModel: container.getColorSelectioinViewModel())
        
}
