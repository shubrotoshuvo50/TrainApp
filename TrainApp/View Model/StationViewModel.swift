//
//  GetStationViewModel.swift
//  TrainApp
//
//  Created by IMCS2 on 4/24/19.
//  Copyright © 2019 Shubroto. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class StationViewModel {
    
    private var stationList: [StationModel] = []
    private var stationTrainInfoList: [StationTrainInfoModel] = []
    
    init() {
        
    }
    
    // Gets a list of the station matching the station name
    func getStationList(stationName: String, completionHandler: @escaping (_ stationList: [StationModel]) -> Void) {
        let requestString = "\(service.mainUrl)getStationsFilterXML?StationText=\(stationName)"
        guard let url = URL(string: requestString) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { //Check error for http response
                return
            }
            guard let data = data else { // No Data from http response
                print("Could not return data")
                return
            }
            self.stationList = [] // Empty all the data before fetching new one
            let xml = XML.parse(data) // Get xml data
            let stationObjectArray = xml.ArrayOfObjStationFilter.objStationFilter // Gets all the station Object
            for station in stationObjectArray {
                let stationName = station.StationDesc.text ?? "Not Found"
                let stationCode = station.StationCode.text
                self.stationList.append(StationModel.init(StationDesc: stationName, StationCode: stationCode))
            }
            DispatchQueue.main.async {
                completionHandler(self.stationList)
            }
            
        }
        dataTask.resume()
    }
    
    // Get the list of all the train of an station by code
    func getTrainListFromStationBy(code: String?, completionHandler: @escaping (_ stationTrainList: [StationTrainInfoModel]) -> Void) {
        guard let code = code else { return } // Check code exist
        let requestString = "\(service.mainUrl)getStationDataByCodeXML?StationCode=\(code)"
        guard let url = URL(string: requestString) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { //Check error for http response
                return
            }
            guard let data = data else { // No Data from http response
                print("Could not return data")
                return
            }
            
            let xml = XML.parse(data) // Get xml data
            let stationTrainObjectArray = xml.ArrayOfObjStationData.objStationData // Gets all the station Object
            for stationTrain in stationTrainObjectArray {
                self.stationTrainInfoList.append(StationTrainInfoModel.init(
                    Traincode: stationTrain.Traincode.text,
                    Staioncode: stationTrain.Stationcode.text,
                    Traindate: stationTrain.Traindate.text,
                    Origin: stationTrain.Origin.text,
                    Destination: stationTrain.Destination.text,
                    Origintime: stationTrain.Origintime.text,
                    Destinationtime: stationTrain.Destinationtime.text,
                    Lastlocation: stationTrain.Lastlocation.text,
                    Duein: stationTrain.Duein.text,
                    Exparrival: stationTrain.Exparrival.text,
                    Direction: stationTrain.Direction.text,
                    Locationtype: stationTrain.Locationtype.text)
                )
            }
            DispatchQueue.main.async {
                completionHandler(self.stationTrainInfoList)
            }
        }
        dataTask.resume()
    }
}
