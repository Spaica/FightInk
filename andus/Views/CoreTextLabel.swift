//
//  CoreTextLabel.swift
//  andus
//
//  Created by Adriano Oliviero on 07/04/2026.
//
import SwiftUI

struct CoreTextLabel: NSViewRepresentable {
    var text: String
    var fontName: String
    var fontSize: CGFloat
    var strokeColor: NSColor
    var fillColor: NSColor
    var strokeWidth: CGFloat

    func makeNSView(context: Context) -> NSTextField {
        let label = NSTextField(labelWithString: "")
        label.drawsBackground = false
        label.isBordered = false
        label.isEditable = false
        label.isSelectable = false
        return label
    }

    func updateNSView(_ nsView: NSTextField, context: Context) {
        let font =
            NSFont(name: fontName, size: fontSize)
            ?? .systemFont(ofSize: fontSize, weight: .heavy)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: fillColor,
            .strokeColor: strokeColor,
            .strokeWidth: strokeWidth,
        ]

        nsView.attributedStringValue = NSAttributedString(
            string: text,
            attributes: attributes
        )
    }
}
