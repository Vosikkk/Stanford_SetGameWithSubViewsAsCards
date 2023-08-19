//
//  BorderView.swift
//  SetGame
//
//  Created by Саша Восколович on 14.08.2023.
//

import UIKit

class BorderView: UIView {
    
    // An array to hold the SetCardView instances that will be displayed in this BorderView.
    var cardViews = [SetCardView]() {
        willSet {
            // Before setting new cardViews, remove existing subviews.
            removeSubviews()
        }
        didSet {
            // After setting new cardViews, add them as subviews and trigger a layout update.
            addSubviews(); setNeedsLayout()
        }
    }
    
    // Function to remove all subviews (cards) from the BorderView.
    private func removeSubviews() {
        for card in cardViews {
            card.removeFromSuperview()
        }
    }
    
    // Function to add the cardViews as subviews to the BorderView.
    private func addSubviews() {
        for card in cardViews {
            addSubview(card)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Create a grid to arrange the cards based on the aspect ratio and the frame of the BorderView.
        var grid = Grid(
            layout: Grid.Layout.aspectRatio(Constant.cellAspectRatio),
            frame: bounds)
        // Set the cell count based on the number of cardViews.
        grid.cellCount = cardViews.count
       
        // Loop through rows and columns to position the cards within the grid.
        for row in 0..<grid.dimensions.rowCount {
            for column in 0..<grid.dimensions.columnCount {
                
                if cardViews.count > (row * grid.dimensions.columnCount + column) {
                    // Position and size each card within its grid cell with some spacing.
                    cardViews[row * grid.dimensions.columnCount + column].frame = grid[row,column]!.insetBy(
                        dx: Constant.spacingDx, dy: Constant.spacingDy)
                }
            }
        }
    }
    
    // Constants for aspect ratio and spacing values.
    struct Constant {
        static let cellAspectRatio: CGFloat = 0.6
        static let spacingDx: CGFloat = 3.0
        static let spacingDy: CGFloat = 3.0
        
    }
    
}
