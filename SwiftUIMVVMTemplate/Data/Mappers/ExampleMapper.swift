import Foundation

enum ExampleMapper {
    static func map(_ dto: ExampleDTO) -> ExampleModel {
        ExampleModel(
            id: UUID(uuidString: dto.id) ?? UUID(),
            title: dto.title,
            message: dto.message
        )
    }
}

