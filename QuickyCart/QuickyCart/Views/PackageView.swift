import SwiftUI

struct PackageView: View {
    @State private var selectedTab = 0
    @Namespace private var animation

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                AddPackageView()
                    .tag(0)
                    .tabItem { EmptyView() }

                TrackingListView()
                    .tag(1)
                    .tabItem { EmptyView() }

                HistoryView()
                    .tag(2)
                    .tabItem { EmptyView() }
            }

            HStack {
                TabBarButton(icon: "house", title: "Home", tag: 0, selectedTab: $selectedTab, animation: animation)
                Spacer()
                TabBarButton(icon: "archivebox", title: "Trackings", tag: 1, selectedTab: $selectedTab, animation: animation)
                Spacer()
                TabBarButton(icon: "checkmark.circle", title: "Delivered", tag: 2, selectedTab: $selectedTab, animation: animation)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
            .padding(.bottom, 18)
        }
        .ignoresSafeArea(.keyboard)
        .background(Color(.systemGroupedBackground))
    }
}

struct TabBarButton: View {
    var icon: String
    var title: String
    var tag: Int
    @Binding var selectedTab: Int
    var animation: Namespace.ID

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                selectedTab = tag
            }
        } label: {
            VStack(spacing: 4) {
                ZStack {
                    if selectedTab == tag {
                        Circle()
                            .fill(Color.IgColor)
                            .matchedGeometryEffect(id: "background", in: animation)
                            .frame(width: 50, height: 50)
                            .offset(y: -10) // ⬆️ Lift on active
                    }

                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(selectedTab == tag ? .white : .gray)
                        .frame(width: 44, height: 44)
                        .background(
                            selectedTab == tag ? Color.clear : Color.clear
                        )
                        .clipShape(Circle())
                        .offset(y: selectedTab == tag ? -10 : 0)
                }

                Text(title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(selectedTab == tag ? .IgColor : .gray)
                    .offset(y: selectedTab == tag ? -6 : 0)
            }
        }
    }
}

#Preview {
    PackageView()
}
