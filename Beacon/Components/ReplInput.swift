import SwiftUI

struct ReplInput: View {
    @Binding var text: String
    @Binding var helpOpen: Bool
    @Binding var settingsOpen: Bool
    @Binding var buffersOpen: Bool
    var lang: Language
    var onSubmit: (() -> Void)?
    var font: Font
    var letters: [String] {
        lang == .bqn ? glyphs : ["'", "/", "\\", "%", "*", "+", "-", "=", "!", "\"", ":"]
    }

    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(letters, id: \.self) { letter in
                        Button(letter) {
                            text.append(letter)
                        }
                        .font(.custom("BQN386 Unicode", size: 16))
                        .padding(8)
                        .background(.gray.opacity(0.1))
                        .foregroundStyle(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }

            HStack {
                Button(action: { text = "" }) {
                    Image(systemName: "arrow.left.square.fill")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                }
                Button(action: { helpOpen.toggle() }) {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                }
                Button(action: { buffersOpen.toggle() }) {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                }
                Button(action: { settingsOpen.toggle() }) {
                    Image(systemName: "command.square.fill")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                }
            }
        }

        HStack {
            TextField("Type some \(languageToString(l: lang)) code..", text: $text, axis: .vertical)
                .onSubmit {
                    onSubmit?()
                }
                .lineLimit(1 ... 8)
                .keyboardType(.asciiCapable)
                .submitLabel(.done)
                .disableAutocorrection(true)
                .font(font)
                .frame(minHeight: 48)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.gray.opacity(0.25), lineWidth: 1)
                ).modifier(EvalButton(onSubmit: onSubmit))
        }
    }
}

struct EvalButton: ViewModifier {
    var onSubmit: (() -> Void)?

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            Button(action: {
                onSubmit?()
            }) {
                Image(systemName: "restart.circle")
                    .resizable()
                    .frame(width: 24.0, height: 24.0)
            }
            .padding(8)
        }
    }
}
