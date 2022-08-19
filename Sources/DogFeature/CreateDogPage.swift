import Styleguide
import SwiftUI
import SharedComponents
import SharedModels

public struct CreateDogPage: View {
  private struct UiState {
    var biologicalSex: BiologicalSex = .male
    var bitrhDate: Date = .init()
    var name: String = ""
  }

  @Environment(\.dismiss) var dismiss
  @State private var image: UIImage?
  @State private var showCamera: Bool = false
  @State private var uiState = UiState()

  public init() {}

  public var body: some View {
    NavigationView {
      ScrollView {
        VStack {
          HeaderSection(image: image)
            .onTapGesture {
              showCamera.toggle()
            }

          NameSection(name: $uiState.name)

          BirthDateSection(birthDate: $uiState.bitrhDate)

          BiologicalSexSection(biologicalSex: $uiState.biologicalSex)
        }
        .padding(Padding.xSmall)
      }
      .background(Color.Background.primary)
      .navigationTitle("ワンちゃん迎い入れ")
      .navigationBarTitleDisplayMode(.inline)
      .sheet(isPresented: $showCamera) {
        CameraView(image: $image)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            dismiss()
          } label: {
            Text("キャンセル")
          }
        }

        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
          } label: {
            Text("保存")
          }
        }
      }
    }
  }

  private struct HeaderSection: View {
    let image: UIImage?

    var body: some View {
      if let image = image {
        Image(uiImage: image)
          .resizable()
          .frame(width: 100, height: 100)
          .scaledToFit()
          .clipShape(Circle())
      } else {
        Image.person
          .resizable()
          .frame(width: 100, height: 100)
      }
    }
  }

  private struct NameSection: View {
    @Binding var name: String

    var body: some View {
      VStack(alignment: .leading, spacing: Padding.xSmall) {
        HStack {
          Text("名前")
            .font(.caption)
            .foregroundColor(Color.Label.secondary)

          Spacer()
        }

        TextField("名前", text: $name)
          .padding(Padding.small)
          .background(Color.Background.secondary)
          .clipShape(
            RoundedRectangle(cornerRadius: 8)
          )
      }
      .padding(Padding.small)
    }
  }

  private struct BirthDateSection: View {
    @Binding var birthDate: Date
    @State var openDatePicker: Bool = false

    var body: some View {
      VStack(alignment: .leading, spacing: Padding.xSmall) {
        HStack(spacing: Padding.xxSmall) {
          Text("誕生日")
            .font(.caption)
            .foregroundColor(Color.Label.secondary)

          Spacer()
        }

        VStack {
          Button {
            withAnimation {
              openDatePicker.toggle()
            }
          } label: {
            HStack {
              Text(birthDate.formatted(date: .complete, time: .omitted))
              Spacer()
            }
          }
          .foregroundColor(Color.Label.primary)

          if openDatePicker {
            DatePicker(
              selection: $birthDate,
              displayedComponents: [.date]
            ) {
            }
            .datePickerStyle(.graphical)
          }
        }
        .padding(Padding.small)
        .background(Color.Background.secondary)
        .clipShape(
          RoundedRectangle(cornerRadius: 8)
        )
      }
      .padding(Padding.small)
    }
  }

  private struct BiologicalSexSection: View {
    @Binding var biologicalSex: BiologicalSex
    
    var body: some View {
      VStack(alignment: .leading, spacing: Padding.xSmall) {
        HStack {
          Text("性別")
            .font(.caption)
            .foregroundColor(Color.Label.secondary)

          Spacer()
        }

        Picker("性別", selection: $biologicalSex) {
          Text("オス").tag(BiologicalSex.male)
          Text("メス").tag(BiologicalSex.female)
        }
        .pickerStyle(.segmented)
        .padding(Padding.small)
        .background(Color.Background.secondary)
        .clipShape(
          RoundedRectangle(cornerRadius: 8)
        )
      }
      .padding(Padding.small)
    }
  }
}
