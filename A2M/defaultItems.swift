//
//  defaultItems.swift
//  A2M
//
import Foundation

struct DefaultItems {
    static let items = [
        ChecklistItemData(name: "Item 1", detail: "This is the first item", isChecked: false, imageData: nil),
        ChecklistItemData(name: "Item 2", detail: "This is the second item", isChecked: false, imageData: nil),
        ChecklistItemData(name: "Item 3", detail: "This is the third item", isChecked: false, imageData: nil)
    ]
}

struct ChecklistItemData {
    var name: String
    var detail: String
    var isChecked: Bool
    var imageData: Data?
}

