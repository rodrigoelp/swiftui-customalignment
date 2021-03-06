//

import SwiftUI
import FetchImage

extension VerticalAlignment {
    enum HandleAccountNameGuide: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(HandleAccountNameGuide.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@rodrigoelp")
                    .alignmentGuide(.midAccountAndName) { $0[VerticalAlignment.center] }
                ImageView(image: FetchImage(
                    regularUrl: URL(string: "https://i.pravatar.cc/300")!,
                    lowDataUrl: URL(string: "https://i.pravatar.cc/100")!))
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
            }

            VStack {
                Text("Account")
                Text("Rod Landaeta")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName) { $0[VerticalAlignment.center] }
            }
        }
    }
}

private struct ImageView: View {
    @ObservedObject var image: FetchImage
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }.animation(.default)
            .onAppear(perform: image.fetch)
            .onDisappear(perform: image.cancel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
