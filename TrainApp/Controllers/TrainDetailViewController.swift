//
//  TrainDetailViewController.swift
//  TrainApp
//
//  Created by IMCS2 on 4/24/19.
//  Copyright © 2019 Shubroto. All rights reserved.
//

import UIKit

class TrainDetailViewController: UIViewController {

    let cellReuseIdentifier: String = "trainDetailCellId"
    var stationTrainInfo: StationTrainInfoModel?
    var displayCellArray: [(name: String, detail: String)] = [] // Array to display cell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDisplayCell()
    }

    // Information to display in each cell
    func setupDisplayCell() {
        displayCellArray = [
            (name: "Train Code", detail: stationTrainInfo?.Traincode ?? "---" ),
            (name: "Date", detail: stationTrainInfo?.Traindate ?? "---" ),
            (name: "Station Code", detail: stationTrainInfo?.Staioncode ?? "---" ),
            (name: "Arriving in", detail: "\(stationTrainInfo?.Duein ?? "---") minutes" ),
            (name: "Origin", detail: stationTrainInfo?.Origin ?? "---" ),
            (name: "Destination", detail: stationTrainInfo?.Destination ?? "---" ),
            (name: "Expected Arrival Time", detail: stationTrainInfo?.Exparrival ?? "---" ),
            (name: "Origin Time", detail: stationTrainInfo?.Origintime ?? "---" ),
            (name: "Destination Time", detail: stationTrainInfo?.Destinationtime ?? "---" ),
            (name: "Direction", detail: stationTrainInfo?.Direction ?? "---" ),
            (name: "Last Location", detail: stationTrainInfo?.Lastlocation ?? "---" ),
            (name: "Location Type", detail: stationTrainInfo?.Locationtype ?? "---" )
        ]
    }
}

extension TrainDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = displayCellArray[indexPath.row].name
        cell.detailTextLabel?.text = displayCellArray[indexPath.row].detail
        return cell
    }
}
