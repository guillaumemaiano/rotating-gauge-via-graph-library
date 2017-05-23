//
//  ViewController.swift
//  Demo
//
//  Created by guillaume MAIANO on 20/03/2017.
//  Copyright © 2017 Pumpkin. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var pieView: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPCV()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {

                pieView.noDataText = "Oops"
        //                setupPCV()
        super.viewWillAppear(animated)
    }

    func setupPCV() {

        pieView.delegate = self
        pieView.holeColor = UIColor.clear
        pieView.transparentCircleColor = UIColor.clear
        pieView.transparentCircleRadiusPercent = 0 // no transparency on circle
        pieView.drawSlicesUnderHoleEnabled = false
        pieView.holeRadiusPercent = 0.98
        pieView.rotationEnabled = false
        pieView.highlightPerTapEnabled = false
        pieView.maxAngle = 280
        pieView.rotationAngle = 130
        // animation does not fill data set on demand :/
        pieView.animate(xAxisDuration: 1.4, easingOption: .easeOutCirc)
        pieView.drawHoleEnabled = true
        pieView.chartDescription?.text = ""
        pieView.drawEntryLabelsEnabled = false
        pieView.legend.enabled = false

        setData(value: 40.0, range: 100.0)
    }

    func setData(value: Double, range: Double) {

        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.

        var values: [ChartDataEntry] = []

        let value: Double = value
        values.append( PieChartDataEntry.init(value: value))
        values.append( PieChartDataEntry.init(value: range - value))‹

        let dataSet: PieChartDataSet = PieChartDataSet(values: values, label: nil)

        //dataSet.colors = ChartColorTemplates.joyful() // table of NSUIColors to be set according to Nico's design, store in Globals.PKAStyle
        dataSet.colors = PumpkinStyle.greenBar()

        dataSet.sliceSpace = 0 // space between slices (assumption!)
        dataSet.selectionShift = 0 // space between slices when selection is enabled and activated by touch (assumption)
        dataSet.drawValuesEnabled = false
        dataSet.entryLabelColor = nil

        let builtData: PieChartData = PieChartData.init(dataSets: [dataSet])
        // here, can add a label using setValueFormatter, setValueFont and setValueTextColor
        pieView.data = builtData
        pieView.setNeedsDisplay()
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase) {

    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

    }

    @IBAction func IWothCliked(_ sender: Any) {
        pieView.rotationAngle += 10
        pieView.chartDescription?.text =  "\(pieView.rotationAngle)"
        pieView.setNeedsDisplay()
    }

}

class PumpkinStyle {

    static func greenBar() -> [NSUIColor] {
        return [
            NSUIColor(red: 149/255.0, green: 165/255.0, blue: 124/255.0, alpha: 1.0),
            NSUIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.10)
        ]

    }
}
