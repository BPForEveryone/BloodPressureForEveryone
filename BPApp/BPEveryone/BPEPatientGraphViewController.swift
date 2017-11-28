//
//  BPEPatientGraphViewController.swift
//  BPForEveryone
//
//  Created by MiningMarsh on 11/28/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit
import CorePlot

class BPEPatientGraphViewController : UIViewController, CPTScatterPlotDataSource, CPTAxisDelegate {
    
    var patientId: Int = 0
    
    // Holds our reference the graph we are rendering,
    private var scatterGraph : CPTXYGraph? = nil
    
    // The graph displays doubles.
    typealias plotDataType = [CPTScatterPlotField : Double]
    
    // Holds the measurements we want to plot.
    private var dataForPlot = [plotDataType]()
    
    // The container that we render the graph to.
    @IBOutlet weak var graphContainer: CPTGraphHostingView!
    
    // Internal function responsible for setting up the graph.
    private func setupGraph() {
        
        // Create the graph, use a dark theme for it.
        let graph = CPTXYGraph(frame: .zero)
        graph.apply(CPTTheme(named: .plainWhiteTheme))
        
        // Assign the created graph to the view we are in.
        let hostingView = self.graphContainer
        hostingView!.hostedGraph = graph
        
        // Pad the graph.
        graph.paddingLeft   = 10.0
        graph.paddingRight  = 10.0
        graph.paddingTop    = 10.0
        graph.paddingBottom = 10.0
        
        // The space for the plot. Some values currently assumed.
        let plotSpace = graph.defaultPlotSpace as! CPTXYPlotSpace
        plotSpace.allowsUserInteraction = true
        plotSpace.yRange = CPTPlotRange(location:1.0, length:4.0)
        plotSpace.xRange = CPTPlotRange(location:1.0, length:5.0)
        
        // Create the axis for the graph.
        let axisSet = graph.axisSet as! CPTXYAxisSet
        
        // Create the x axis.
        if let x = axisSet.xAxis {
            x.majorIntervalLength   = 0.5
            x.orthogonalPosition    = 2.0
            x.minorTicksPerInterval = 2
            x.labelExclusionRanges  = [
                CPTPlotRange(location: 0.99, length: 0.02),
                CPTPlotRange(location: 1.99, length: 0.02),
                CPTPlotRange(location: 2.99, length: 0.02)
            ]
        }
        
        // Create the y axis.
        if let y = axisSet.xAxis {
            y.majorIntervalLength   = 0.5
            y.minorTicksPerInterval = 5
            y.orthogonalPosition    = 2.0
            y.labelExclusionRanges  = [
                CPTPlotRange(location: 0.99, length: 0.02),
                CPTPlotRange(location: 1.99, length: 0.02),
                CPTPlotRange(location: 3.99, length: 0.02)
            ]
            y.delegate = self
        }
        
        // Create a blue plot area
        let boundLinePlot = CPTScatterPlot(frame: .zero)
        let blueLineStyle = CPTMutableLineStyle()
        blueLineStyle.miterLimit    = 1.0
        blueLineStyle.lineWidth     = 3.0
        blueLineStyle.lineColor     = .blue()
        boundLinePlot.dataLineStyle = blueLineStyle
        boundLinePlot.identifier    = NSString.init(string: "Blue Plot")
        boundLinePlot.dataSource    = self
        graph.add(boundLinePlot)
        
        /* We don't currently want a background image.
         let fillImage = CPTImage(named:"BlueTexture")
         fillImage.isTiled = true
         boundLinePlot.areaFill      = CPTFill(image: fillImage)
         boundLinePlot.areaBaseValue = 0.0
         */
        
        // Add plot symbols
        let symbolLineStyle = CPTMutableLineStyle()
        symbolLineStyle.lineColor = .black()
        let plotSymbol = CPTPlotSymbol.ellipse()
        plotSymbol.fill          = CPTFill(color: .blue())
        plotSymbol.lineStyle     = symbolLineStyle
        plotSymbol.size          = CGSize(width: 10.0, height: 10.0)
        boundLinePlot.plotSymbol = plotSymbol
        
        // Create a green plot area
        let dataSourceLinePlot = CPTScatterPlot(frame: .zero)
        let greenLineStyle               = CPTMutableLineStyle()
        greenLineStyle.lineWidth         = 3.0
        greenLineStyle.lineColor         = .green()
        greenLineStyle.dashPattern       = [5.0, 5.0]
        dataSourceLinePlot.dataLineStyle = greenLineStyle
        dataSourceLinePlot.identifier    = NSString.init(string: "Green Plot")
        dataSourceLinePlot.dataSource    = self
        
        // Put an area gradient under the plot above
        let areaColor    = CPTColor(componentRed: 0.3, green: 1.0, blue: 0.3, alpha: 0.8)
        let areaGradient = CPTGradient(beginning: areaColor, ending: .clear())
        areaGradient.angle = -90.0
        let areaGradientFill = CPTFill(gradient: areaGradient)
        dataSourceLinePlot.areaFill      = areaGradientFill
        dataSourceLinePlot.areaBaseValue = 1.75
        
        // Animate in the new plot, as an example
        dataSourceLinePlot.opacity = 0.0
        graph.add(dataSourceLinePlot)
        
        // Add some initial data
        var contentArray = [plotDataType]()
        for i in 0 ..< 60 {
            let x = 1.0 + Double(i) * 0.05
            let y = 1.2 * Double(arc4random()) / Double(UInt32.max) + 1.2
            let dataPoint: plotDataType = [.X: x, .Y: y]
            contentArray.append(dataPoint)
        }
        self.dataForPlot = contentArray
        
        self.scatterGraph = graph    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupGraph()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        // This is the name of the segue in the storyboard.
        if (segue.identifier == "patientEditDetailView") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEPatientEditViewController
            
            controller.patientId = self.patientId
        }
        
        // Blood pressure list also requires a patient id.
        if (segue.identifier == "bloodPressureList") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEBPListViewController
            
            controller.patientId = self.patientId
        }
    }
    
    // MARK: - Plot Data Source Methods
    func numberOfRecords(for plot: CPTPlot) -> UInt
    {
        return UInt(self.dataForPlot.count)
    }
    
    func number(for plot: CPTPlot, field: UInt, record: UInt) -> Any?
    {
        let plotField = CPTScatterPlotField(rawValue: Int(field))
        
        if let num = self.dataForPlot[Int(record)][plotField!] {
            let plotID = plot.identifier as! String
            if (plotField! == .Y) && (plotID == "Green Plot") {
                return (num + 1.0) as NSNumber
            }
            else {
                return num as NSNumber
            }
        }
        else {
            return nil
        }
    }
    
    // MARK: - Axis Delegate Methods
    private func axis(_ axis: CPTAxis, shouldUpdateAxisLabelsAtLocations locations: NSSet!) -> Bool
    {
        if let formatter = axis.labelFormatter {
            let labelOffset = axis.labelOffset
            
            var newLabels = Set<CPTAxisLabel>()
            
            if let labelTextStyle = axis.labelTextStyle?.mutableCopy() as? CPTMutableTextStyle {
                for location in locations {
                    if let tickLocation = location as? NSNumber {
                        if tickLocation.doubleValue >= 0.0 {
                            labelTextStyle.color = .green()
                        }
                        else {
                            labelTextStyle.color = .red()
                        }
                        
                        let labelString   = formatter.string(for:tickLocation)
                        let newLabelLayer = CPTTextLayer(text: labelString, style: labelTextStyle)
                        
                        let newLabel = CPTAxisLabel(contentLayer: newLabelLayer)
                        newLabel.tickLocation = tickLocation
                        newLabel.offset       = labelOffset
                        
                        newLabels.insert(newLabel)
                    }
                }
                
                axis.axisLabels = newLabels
            }
        }
        
        return false
    }
}
