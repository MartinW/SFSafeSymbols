
@testable import SFSafeSymbols
import XCTest

@available(iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, *)
class CodableTests: XCTestCase {
    struct SymbolWrapper: Codable {
        let foo: SFSymbol
    }

    func testEncoding() throws {
        let randomSymbol = SFSymbol.allSymbols.randomElement()!
        print("Testing encoding of \(randomSymbol.rawValue)")
        let jsonData = #"{"foo":"\#(randomSymbol.rawValue)"}"#.data(using: .utf8)
        let wrapper = SymbolWrapper(foo: randomSymbol)
        let encodedData = try JSONEncoder().encode(wrapper)
        XCTAssertEqual(encodedData, jsonData)
    }

    func testDecoding() throws {
        let randomSymbol = SFSymbol.allSymbols.randomElement()!
        print("Testing decoding of \(randomSymbol.rawValue)")
        let jsonData = #"{"foo":"\#(randomSymbol.rawValue)"}"#.data(using: .utf8)
        let symbol = try jsonData.flatMap { try JSONDecoder().decode(SymbolWrapper.self, from: $0) }
        XCTAssertEqual(symbol?.foo, randomSymbol)
    }
}

@available(iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, *)
extension SFSymbol: Codable { }
