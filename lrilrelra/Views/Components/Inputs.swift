//
//  Inputs.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 23.01.2025.
//

import Foundation
import SwiftUI

struct YearPickerField: View {
  let title: String
  @Binding var selection: Int

  @State private var showPicker = false

  var body: some View {
    VStack {
      Button(action: {
        showPicker = true
      }) {
        Text("\(title): \(selection)")
      }
      .sheet(isPresented: $showPicker) {
        YearPicker(selection: $selection, title: title)
          .toolbar {
            ToolbarItem(placement: .confirmationAction) {
              Button(action: {
                showPicker = false
              }) {
                Text("Done")
              }
            }
          }
          .presentationDetents([.fraction(0.25)])  // 25% of the screen height
          .presentationDragIndicator(.visible)
      }
    }
  }
}

struct YearPicker: View {
  @Binding var selection: Int
  let title: String

  var body: some View {
    Picker(title, selection: $selection) {
      ForEach((1900...Calendar.current.component(.year, from: Date())).reversed(), id: \.self) {
        year in
        Text("\(year)").tag(year)
      }
    }
    .pickerStyle(WheelPickerStyle())  // Use WheelPickerStyle for a scrollable list
  }
}
