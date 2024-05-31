#if canImport(CocoaChain)
import CocoaChain
import Foundation


extension Chain where T: EllipsisLabel {
    
    @discardableResult
    public func replaceText(_ replaceText: String?) -> Self {
        base.replaceText = replaceText
        return self
    }
}

#endif
