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
        lang == .bqn ? glyphs : ["`", "'", "/", "\\", "%", "*", "+", "-", "=", "!", "\"", ":", "@"]
    }

    var body: some View {
        let toolbar = ToolbarItemGroup(placement: .keyboard) {
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

                Button(action: { text = "" }) {
                    Image(systemName: "arrow.left.square.fill")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                }
                Button(action: { helpOpen.toggle() }) {
                    Image(systemName: "questionmark.app.fill")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                }
                Button(action: { buffersOpen.toggle() }) {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                }
                Button(action: { settingsOpen.toggle() }) {
                    Image(systemName: "command.square.fill")
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                }
            }
        }

        HStack {
            Spacer()
            TextField("", text: $text, axis: .vertical)
                .onSubmit {
                    onSubmit?()
                }
                .toolbar {
                    toolbar
                }
                .placeholder(when: text.isEmpty) {
                    Text("Type \(languageToString(l: lang))...").font(.monospaced(.system(size: 16))()).opacity(0.3)
                }
                .lineLimit(1 ... 8)
                .keyboardType(.asciiCapable)
                .submitLabel(.done)
                .disableAutocorrection(true)
                .font(font)
                .frame(minHeight: 36)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)) //
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.gray.opacity(0.2), lineWidth: 1)
                )
            Button(action: {
                onSubmit?()
            }) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .foregroundStyle(.blue.opacity(0.9))
            }
            .padding(4)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
