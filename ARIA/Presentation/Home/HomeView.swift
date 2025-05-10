import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            Color(.bg).ignoresSafeArea()

            VStack(spacing: 0) {
                if !viewModel.showResults {
                    inputSection
                } else {
                    resultsSection
                }

                Spacer()

                footerSection
            }
            .padding(.top, 32)
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private var inputSection: some View {
        VStack(spacing: 32) {
            Text("What images should I help with?")
                .font(.title)
                .monospaced()
                .bold()
                .foregroundColor(.white)

            Spacer().frame(height: 20)

            VStack(spacing: 16) {
                HStack(alignment: .center) {
                    GrowingTextField(
                        text: $viewModel.messageText,
                        placeholder: "Ask anything"
                    )
                    .padding(.vertical, 4)

                    Spacer()

                    Button(action: {
                        viewModel.sendMessage()
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title3)
                            .foregroundColor(viewModel.isInputEmpty ? .gray : .white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(viewModel.isInputEmpty)
                    .opacity(viewModel.isInputEmpty ? 0.3 : 1.0)
                }
                .padding()
                .background(Color(.cardBg))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)

                VStack(spacing: 8) {
                    HStack {
                        Spacer()

                        HStack(spacing: 8) {
                            ForEach(0..<viewModel.selectedImages.count, id: \.self) { index in
                                ImageThumbnail(
                                    image: viewModel.selectedImages[index],
                                    onRemove: {
                                        viewModel.removeImage(at: index)
                                    }
                                )
                            }

                            TagButton(
                                label: "Add Images",
                                icon: "photo.stack.fill",
                                action: {
                                    viewModel.addImages()
                                },
                                isDisabled: viewModel.selectedImages.count >= 4
                            )
                            .shake(trigger: viewModel.showImageRequiredError)
                        }

                        Spacer()
                    }

                    if viewModel.showImageRequiredError {
                        Text("Please add at least one image")
                            .font(.caption)
                            .monospaced()
                            .foregroundColor(.red)
                            .padding(.top, 4)
                    }
                }
            }
            .padding(.horizontal, 32)
        }
    }

    private var resultsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {
                    viewModel.resetChat()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                        Text("New Request")
                            .font(.callout)
                    }
                    .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accent)

                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 8)

            let columns = [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ]

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.imageResponses) { response in
                    ResponseCard(response: response)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 32)
        }
    }

    private var footerSection: some View {
        HStack(spacing: 0) {
            Text("Created by ")
                .font(.caption)
                .monospaced()
                .foregroundColor(.gray)
            Text("Felipe Oliveira")
                .font(.caption)
                .monospaced()
                .bold()
                .foregroundColor(.gray)
            Text(". © 2025. All rights reserved.")
                .font(.caption)
                .monospaced()
                .foregroundColor(.gray)
        }
        .padding(.bottom, 20)
        .padding(.top, 16)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
