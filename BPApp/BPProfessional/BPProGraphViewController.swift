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

    // Systolic and Diastolic Line Charts
    @IBOutlet weak var systolicLineChartView: LineChartView!
    @IBOutlet weak var diastolicLineChartView: LineChartView!

    var systolicDataEntry: [ChartDataEntry] = []
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Systolic Chart Dummy Data
    // Use Patient Object data from previous to index into norms table
    let age = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
    let BP = [86.0, 89.0, 90.0, 92.0, 94.0, 95.0, 97.0, 98.0, 99.0, 100.0, 102.0, 104.0, 105.0, 109.0, 113.0, 115.0, 117.0]
    
    // Prepare data before view loads
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Present graphs once the view loads
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
            let dataPoint = ChartDataEntry(x: Double(dataPoints[i]), y: Double(values[i]))
            systolicDataEntry.append(dataPoint)
        }
        let fifty_DataSet = LineChartDataSet(values: systolicDataEntry, label: "50th Percentile Systolic BP")
        let fifty_Data = LineChartData()
        fifty_Data.addDataSet(fifty_DataSet)
        fifty_Data.setDrawValues(true)
        fifty_DataSet.colors = [UIColor.red]
        fifty_DataSet.setCircleColor(UIColor.red)
        fifty_DataSet.circleHoleColor = UIColor.red
        fifty_DataSet.circleRadius = 0.0
        fifty_DataSet.lineWidth = 5.0
        
        // Gradient Fill
        let gradientColors = [UIColor.red.cgColor, UIColor.red.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let red_gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("Gradient error"); return }
        fifty_DataSet.fill = Fill.fillWithLinearGradient(red_gradient, angle: 90.0)
        fifty_DataSet.drawFilledEnabled = true
        
        // Axes Setup
        systolicLineChartView.chartDescription?.enabled = false
        systolicLineChartView.legend.enabled = true
        
        systolicLineChartView.xAxis.drawGridLinesEnabled = false
        systolicLineChartView.xAxis.granularity = 1.0
        systolicLineChartView.xAxis.labelCount = dataPoints.count
        systolicLineChartView.xAxis.labelPosition = .bottom
        systolicLineChartView.xAxis.xOffset = 1.0
        
        systolicLineChartView.rightAxis.enabled = true
        systolicLineChartView.rightAxis.drawGridLinesEnabled = false
        systolicLineChartView.leftAxis.drawGridLinesEnabled = false
        systolicLineChartView.leftAxis.drawLabelsEnabled = true
        systolicLineChartView.leftAxis.xOffset = 1.0
        //systolicLineChartView.extraTopOffset = 10.0
        //systolicLineChartView.extraLeftOffset = 35.0
        
        systolicLineChartView.data = fifty_Data
    }

}
