//
//  DataManager.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 9/8/21.
//

import Foundation
import FirebaseFirestore

class DataManager {
    var trialNumberUserDefaults = 0
    var trialNumberFireStore = 0
    var doubleTrialString = "00"
    var stringTrialString = "000"
    
    let db = Firestore.firestore()
    let avm = AppViewModel()
    
    
    // Struct for custom object to save to firestore
    public struct TrialRun: Codable {
        
        let trialNumber: String
        let trial: Int
        let responseTarget: Array<String>
        let responseTime: Array<Double>
        
        enum CodingKeys: String, CodingKey {
            case trialNumber
            case trial
            case responseTarget
            case responseTime
        }
    }
    
    func saveAnythingAtAllToFirestore(trial: Int, responseTarget: Array<String>, responseTime: Array<Double>) {
        let currentUserNumber = avm.numberOfUsers

        
        db.collection("users").document(String(currentUserNumber)).collection(String(avm.currentRun ?? 00000)).document("Trial: \(trial)").setData(["trialNumber": trial, "responseTarget": responseTarget, "responseTime": responseTime ])
    }
    
    func saveResponseTimeToFireStore(trial: Int, responseTarget: Array<String>, responseTime: Array<Double>) {
        let docData: [String: Any] = [
            "trialOne" : trial,
            "responseTimeArray" : responseTime,
            "responseTargetArray" : responseTarget,
        ]
        
        db.collection("users").document("test").setData(docData) { err in
            if let err = err {
            print("Error writing to fireStore: \(err)")
            } else {
                print("Document successfully written")
            }
    }
    }
    

    func saveResonseTimeToUserDefaults(array: Array<Double>) {
        UserDefaults.standard.set(array, forKey: "rt for runNumber: \(avm.currentRun))")
        //save as Date
        UserDefaults.standard.set(Date(), forKey: "rt date for runNumber: \(avm.currentRun)")

    }
    
    func saveResponseTargetToUserDefaults(stringArray: Array<String>) {
        UserDefaults.standard.set(stringArray, forKey: "targetResponse for runNumber: \(avm.currentRun)")
        //save as Date
        UserDefaults.standard.set(Date(), forKey: "targetResponse date for runNumber: \(avm.currentRun)")

    }
}
