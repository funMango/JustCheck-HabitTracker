//
//  ColorSelectionView.swift
//  JustCheck-HabitTracker
//
//  Created by 이민호 on 2/28/25.
//

import SwiftUI

struct ColorSelectionView: View {
    @ObservedObject var viewModel: ColorSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    dismiss()
                } label: {
                    BackButton()
                }
                Spacer()
                
                Text(String(localized: "color"))
                    .font(.headline)
                
                Spacer()
            }
            .padding()
                            
            List(HabitColor.allCases) { color in
                Button {
                    viewModel.setSelectedColor(color)
                } label: {
                    HStack {
                        HabitColorCircle(color: color.hex, size: 10)
                        
                        Text(color.localized)
                            .foregroundStyle(.blackWhite)
                        
                        Spacer()
                        
                        if color.id == viewModel.selectedColor.id {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(.red)
                        }
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let dataContainer = DataContainer()    
    let container = VmContainer(modelContainer: dataContainer.getModelContainer())
    ColorSelectionView(viewModel: container.getColorSelectioinViewModel())
        
}
