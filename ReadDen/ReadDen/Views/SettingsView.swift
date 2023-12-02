//
//  SettingsView.swift
//  ReadDen
//
//  Created by Shashank Sharma on 11/25/23.
//

import SwiftUI

struct SettingsView: View {
  @Binding var isDarkModeOn: Bool
  @State private var isOnboardingSetting = false
  @AppStorage("isOnboarding")
  var isOnboarding: Bool?

  var body: some View {
    NavigationStack {
      VStack {
        Toggle("Dark mode:", isOn: $isDarkModeOn)
          .onChange(of: isDarkModeOn) { _ in
            UserDefaults.standard.set(isDarkModeOn, forKey: "isDarkModeOn")
          }
          .font(Font.custom("NewYork-Regular", size: 20))
          .accessibilityIdentifier("darkModeToggle")
        Toggle("Reset Onboarding Screen:", isOn: $isOnboardingSetting)
          .onChange(of: isOnboardingSetting) { _ in
            isOnboarding = isOnboardingSetting
          }
          .font(Font.custom("NewYork-Regular", size: 20))
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color("AmbientColor"))
    }
    .navigationBarTitle("Settings", displayMode: .inline)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    // Text("s")
    SettingsView(isDarkModeOn: .constant(false))
  }
}
