import Foundation

protocol SignedCardinal {
    var sign: FloatingPointSign { get }
    
    init(sign: FloatingPointSign)
}

extension SignedCardinal {
    static var plus: Self { Self(sign: .plus) }
    static var minus: Self { Self(sign: .minus) }
}
