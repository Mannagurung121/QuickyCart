import SwiftUI
import Lottie

struct AddPackageView: View {
    @State private var packageNumber = ""
    @State private var isShowingDetail = false
    @State private var showErrorAlert = false
    @State private var matchedTrack: Tracker? = nil
    @State private var isLoading = false

    @StateObject var viewModel = PackageViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                (colorScheme == .dark ? Color.black : Color.white)
                    .ignoresSafeArea()

                // Gradient bubbles
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                colorScheme == .dark ? Color.purple.opacity(0.15) : Color.purple.opacity(0.25),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 180
                        )
                    )
                    .frame(width: 300, height: 300)
                    .offset(x: -150, y: -250)

                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                colorScheme == .dark ? Color.green.opacity(0.12) : Color.green.opacity(0.2),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 180
                        )
                    )
                    .frame(width: 250, height: 250)
                    .offset(x: 120, y: -200)

                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                colorScheme == .dark ? Color.blue.opacity(0.1) : Color.blue.opacity(0.15),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 10,
                            endRadius: 160
                        )
                    )
                    .frame(width: 220, height: 220)
                    .offset(x: 100, y: 300)

                // Main Content
                VStack(spacing: 20) {
                    Image("canvas")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .padding(.top, 24)

                    HStack(spacing: 8) {
                        Text("QuickCart")
                            .foregroundColor(.indigo)
                            .font(.system(size: 28, weight: .semibold))
                            .minimumScaleFactor(0.9)
                            .lineLimit(1)

                        Image(systemName: "shippingbox")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.indigo)
                    }

                    Text("Enter your package number")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 6)

                    VStack(spacing: 16) {
                        TextField("Package Number", text: $packageNumber)
                            .padding(.horizontal, 14)
                            .frame(height: 48)
                            .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
                            .keyboardType(.default)
                            .submitLabel(.done)

                        Button {
                            isLoading = true
                            viewModel.fetchPackage(trackingNumber: packageNumber) { success in
                                isLoading = false
                                if success, let tracker = viewModel.tracker {
                                    SavedTrackManager.shared.save(tracker)
                                    self.matchedTrack = tracker
                                    self.isShowingDetail = true
                                } else {
                                    self.showErrorAlert = true
                                }
                            }
                        } label: {
                            Label("Track Package", systemImage: "shippingbox.and.arrow.backward")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.indigo)
                                .cornerRadius(10)
                        }
                        .disabled(packageNumber.isEmpty)
                        .alert("No Package Found", isPresented: $showErrorAlert) {
                            Button("OK", role: .cancel) {}
                        }

                        // Navigation
                        NavigationLink(
                            destination: Group {
                                if let track = matchedTrack {
                                    PackageDetailView(track: track)
                                } else {
                                    EmptyView()
                                }
                            },
                            isActive: $isShowingDetail
                        ) {
                            EmptyView()
                        }
                        .hidden()
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.horizontal)

                // Loading Overlay
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.3).ignoresSafeArea()
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .frame(width: 260, height: 260)
                            .overlay(
                                LottieView(asset: "loading-courier", loopMode: .loop)
                                    .frame(width: 200, height: 200)
                            )
                            .shadow(radius: 10)
                    }
                    .transition(.opacity)
                }
            }
            .navigationTitle("Welcome!")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    AddPackageView()
}
