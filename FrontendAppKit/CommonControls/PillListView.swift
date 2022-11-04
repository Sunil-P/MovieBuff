//
//  PillListView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/2/22.
//

import UIKit

final class PillListView: UIView {

    func addPillLabel(_ title: String) {

        defer { rearrangeViews() }
        addPillLabel(createNewPillView(title))
    }

    // MARK: Overrides:

    override var intrinsicContentSize: CGSize {

        var height = CGFloat(rows) * (pillViewHeight + marginY)
        if rows > 0 {
            height -= marginY
        }
        return CGSize(width: frame.width, height: height)
    }

    private(set) var pillViews: [PillLabel] = []
    private(set) var rowViews: [UIView] = []
    private(set) var pillViewHeight: CGFloat = 0
    private(set) var rows = 0 {

        didSet {

            invalidateIntrinsicContentSize()
        }
    }

    override func layoutSubviews() {

        defer { rearrangeViews() }
        super.layoutSubviews()
    }

    // MARK: Privates:

    private let marginX: CGFloat = 6
    private let marginY: CGFloat = 6
    private let minWidth: CGFloat = 0

    private func rearrangeViews() {

        let views = pillViews as [UIView] + rowViews
        views.forEach {

            $0.removeFromSuperview()
        }
        rowViews.removeAll(keepingCapacity: true)

        var currentRow = 0
        var currentRowView: UIView!
        var currentRowPillCount = 0
        var currentRowWidth: CGFloat = 0
        let frameWidth = frame.width

        for pillView in pillViews {

            pillView.frame.size = pillView.intrinsicContentSize
            pillViewHeight = pillView.frame.height

            // If creating new row, then update row properties, else proceed with appending pillView.
            //
            // New row is created, if its very first row OR currentRow cannot accomodate any more pill views.
            //
            if currentRowPillCount == 0 || currentRowWidth + pillView.frame.width > frameWidth {

                currentRow += 1
                currentRowWidth = 0
                currentRowPillCount = 0
                currentRowView = UIView()
                currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (pillViewHeight + marginY)
                rowViews.append(currentRowView)
                addSubview(currentRowView)
            }

            // Update `pillView` origin and add it to row.
            pillView.frame.origin = CGPoint(x: currentRowWidth, y: 0)
            currentRowView.addSubview(pillView)

            // Update `currentRowWidth`.
            currentRowPillCount += 1
            currentRowWidth += pillView.frame.width + marginX

            // Center the entire row.
            currentRowView.frame.origin.x = (frameWidth - (currentRowWidth - marginX)) / 2

            // Assign width and height.
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(pillViewHeight, currentRowView.frame.height)
        }

        rows = currentRow
        invalidateIntrinsicContentSize()
    }

    private func addPillLabel(_ pillLabel: PillLabel) {

        defer { rearrangeViews() }

        pillViews.append(pillLabel)
    }

    private func createNewPillView(_ title: String) -> PillLabel {

        PillLabel(title: title)
    }
}
