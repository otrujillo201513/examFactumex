//
//  GraphicsViewController.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import UIKit
import AnyChartiOS

class GraphicsViewController: UIViewController {
    
    var anyChartView: AnyChartView!
    var responseData: InformationResponse?
    var indexGraphic: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
    }
    
    func addComponents() {
        anyChartView = AnyChartView()
        anyChartView.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        view.addSubview(anyChartView)
        view.backgroundColor = .white
        
        let title: String = responseData?.questions[indexGraphic].text ?? ""
        let chart = AnyChart.pie3d()
        var data: Array<DataEntry> = []
        
        let chartData = responseData!.questions[indexGraphic].chartData
        for ind in chartData {
            let valueChart = ValueDataEntry(x: ind.text, value: ind.percetnage)
            data.append(valueChart)
        }
        chart.data(data: data)
        chart.title(settings: title)
        anyChartView.setChart(chart: chart)
    }
    
}
