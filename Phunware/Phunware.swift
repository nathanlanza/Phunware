import Moya
import RxSwift

enum Phunware {
    case starWars
}
extension Phunware: TargetType {
    var baseURL: URL { return
        try! "https://raw.githubusercontent.com/phunware/dev-interview-homework/master/".asURL() }
    var path: String { return "feed.json" }
    var method: Moya.Method { return Method.get }
    var parameters: [String : Any]? { return nil }
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    var sampleData: Data { return Data() }
    var task: Task { return .request }
}
