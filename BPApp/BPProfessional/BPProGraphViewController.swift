//
//  BPProGraphViewController.swift
//  BPForProfessionals
//
//  Created by Andrew Hu on 10/16/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit
import Charts

class BPProGraphViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var systolicLineChartView: LineChartView!
    @IBOutlet weak var diastolicLineChartView: LineChartView!
    
    var systolicDataEntry: [ChartDataEntry] = []
    
    // Systolic Chart Dummy Data
    let age = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
    let BP = [86.0, 89.0, 90.0, 92.0, 94.0, 95.0, 97.0, 98.0, 99.0, 100.0, 102.0, 104.0, 105.0, 109.0, 113.0, 115.0, 117.0]
    
    // Prepare data before view loads
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Present graphs once the UIView loads
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartSetup()
    }
    
    func lineChartSetup() {
        systolicLineChartView.delegate = self
        systolicLineChartView.backgroundColor = UIColor.white
        systolicLineChartView.translatesAutoresizingMaskIntoConstraints = false
        setLineChart(dataPoints: age, values: BP)
    }
    
    func setLineChart(dataPoints: [Int], values: [Double]) {
        // No Data Available Setup
        systolicLineChartView.noDataTextColor = UIColor.white
        systolicLineChartView.noDataText = "No graph data available"
        systolicLineChartView.backgroundColor = UIColor.white
        
        // Data Point Setup & Color Configuration
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            systolicDataEntry.append(dataPoint)
        }
        let chartDataSet = LineChartDataSet(values: systolicDataEntry, label: "50th Percentile Systolic BP")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.red]
        chartDataSet.setCircleColor(UIColor.red)
        chartDataSet.circleHoleColor = UIColor.red
        chartDataSet.circleRadius = 1.0
        
        // Gradient Fill
        let gradientColors = [UIColor.brown.cgColor, UIColor.red.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("Gradient error"); return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        // Axes Setup
        systolicLineChartView.xAxis.labelPosition = .bottom
        systolicLineChartView.xAxis.xOffset = 1.0
        systolicLineChartView.xAxis.drawGridLinesEnabled = false
        systolicLineChartView.chartDescription?.enabled = false
        systolicLineChartView.legend.enabled = true
        systolicLineChartView.rightAxis.enabled = true
        systolicLineChartView.leftAxis.drawGridLinesEnabled = false
        systolicLineChartView.leftAxis.drawLabelsEnabled = true
        
        systolicLineChartView.data = chartData
    }

}
