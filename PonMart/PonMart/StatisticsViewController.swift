//
//  StatisticsViewController.swift
//  PonMart
//
//  Created by Richard Hsu on 1/20/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {

    
    
    @IBOutlet var statsView: LineChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //statsView.noDataText = "You have no sales!"
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        //months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        //let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(dataPoints: months, values: unitsSold)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double])
    {
        statsView.noDataText = "You have no data!"
        statsView.descriptionText = ""
        statsView.xAxis.labelPosition = .bottom
        statsView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        
        var dataEntries: [ChartDataEntry] = []
        
        
        for i in 0..<dataPoints.count
        {
            print(i)
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Number of Sales")
 
        //lineChartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        statsView.data = lineChartData
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
