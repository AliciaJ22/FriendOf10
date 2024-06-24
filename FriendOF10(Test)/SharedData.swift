import Foundation
import Combine
class SharedData: ObservableObject {
    static let shared = SharedData()
    //This is variables which are shared between screens


    @Published var PointTotal: Int = 10
    @Published var items: [Item] = [
        Item(id: 1, imageName: "1", pointValue: 20, offset: CGSize(width: -30, height: 350)),
        Item(id: 2, imageName: "2", pointValue: 5, offset: CGSize(width: -120, height: 330)),
        Item(id: 3, imageName: "3", pointValue: 10, offset: CGSize(width: 60, height: 330))]
    @Published var Name : String = ""
   
    struct Item: Identifiable {
        let id: Int
        let imageName: String
        let pointValue: Int
        let offset: CGSize
        var isPurchased: Bool = false
        var isSelected: Bool = false
    }

    private init() {}
}

