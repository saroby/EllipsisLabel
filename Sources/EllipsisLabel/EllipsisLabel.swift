import UIKit


public class EllipsisLabel: UILabel {
    
    private var originText: String? = nil
    
    private var ellipsis: String = "⋯"
    
    public override var text: String? {
        willSet {
            self.originText = newValue
        }
        didSet {
            self.updateText()
        }
    }
    
    public var replaceText: String? {
        didSet {
            self.updateText()
        }
    }
    
    public override var font: UIFont! {
        didSet {
            self.updateText()
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.sharedInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.sharedInit()
    }
    
    private func sharedInit() {
        self.lineBreakMode = .byCharWrapping
    }
    
    public override var lineBreakMode: NSLineBreakMode {
        didSet {
            /// lineBreakMode should be byCharWrapping always.
            if self.lineBreakMode != .byCharWrapping {
                self.lineBreakMode = .byCharWrapping
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateText()
    }
    
    private func updateText() {
        guard let replaceText else {
            super.text = originText
            return
        }
        
        guard let originText else { return }
        
        guard self.frame.size != .zero else { return }
        
        guard let firstRange = originText.range(of: replaceText) else {
            super.text = originText
            return
        }
        
        let anchorIndex = firstRange.upperBound
        var modifiedText = originText
        
        let originTextStartIndex = originText.startIndex
        var ellipsisLeftOffset = 0
        while self.isTruncated(modifiedText),
              let ellipsisLeftIndex = originText.index(anchorIndex, offsetBy: ellipsisLeftOffset - 1, limitedBy: originTextStartIndex),
              ellipsisLeftIndex >= originTextStartIndex {
            ellipsisLeftOffset -= 1
            
            modifiedText = originText
            modifiedText.replaceSubrange(ellipsisLeftIndex..<anchorIndex, with: self.ellipsis)
        }
        
        let originTextEndIndex = originText.endIndex
        var ellipsisRightOffset = 0
        let ellipsisLeftIndex = originText.index(anchorIndex, offsetBy: ellipsisLeftOffset)
        
        while self.isTruncated(modifiedText),
              let ellipsisRightIndex = originText.index(anchorIndex, offsetBy: ellipsisRightOffset + 1, limitedBy: originTextEndIndex),
              ellipsisRightIndex <= originTextEndIndex {
            ellipsisRightOffset += 1
            
            modifiedText = originText
            modifiedText.replaceSubrange(ellipsisLeftIndex...ellipsisRightIndex, with: self.ellipsis)
            modifiedText.replaceSubrange(ellipsisLeftIndex..<ellipsisRightIndex, with: self.ellipsis)
        }
        
        super.text = modifiedText
    }
    
    private func isTruncated(_ value: String?) -> Bool {
        guard let value else { return false }
        guard let font else { return false }
        
        let labelTextSize = (value as NSString)
            .boundingRect(
                with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: font],
                context: nil
            )
            .size
        
        return labelTextSize.height > bounds.size.height
    }
}
