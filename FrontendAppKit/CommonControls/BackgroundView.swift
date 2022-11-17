//
//  BackgroundView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/5/22.
//

import UIKit

final class BackgroundView: UIView {

    let points: [CGPoint] = [

        CGPoint(x: 0, y: 0.5),
        CGPoint(x: 1, y: 0.27),
        CGPoint(x: 1, y: 1),
        CGPoint(x: 0, y: 1)
    ]
    let controlPoint = CGPoint(x: 0.65, y: 0.3)


    private lazy var shapeLayer: CAShapeLayer = {

        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer

    }()

    override public func layoutSubviews() {

        shapeLayer.fillColor = Styles.ColorIds.highEmphasis.cgColor

        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }

        let path = UIBezierPath()

        path.move(to: convert(relativePoint: points[0]))

        let relativeControlPoint = convert(relativePoint: controlPoint)

        path.addQuadCurve(to: convert(relativePoint: points[1]), controlPoint: relativeControlPoint)

        for point in points.dropFirst(2) {

            path.addLine(to: convert(relativePoint: point))
        }
        path.close()

        shapeLayer.path = path.cgPath
    }

    private func convert(relativePoint point: CGPoint) -> CGPoint {

        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }

} // BackgroundView
