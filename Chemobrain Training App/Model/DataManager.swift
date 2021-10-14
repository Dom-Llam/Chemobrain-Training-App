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
    var convertedJSON = ""
    
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
    
    func saveAnythingAtAllToFirestore(trial: Int, score: Int, responseTarget: Array<String>, responseTime: Array<Double>) {
        let currentUserNumber = avm.numberOfUsers
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let date = dateFormatter.string(from: Date())
        
        db.collection("users").document(String(currentUserNumber)).collection(String(avm.currentRun ?? 0000)).document("Trial: \(trial)").setData([ "Date": date, "Score": score, "trialNumber": trial, "responseTarget": responseTarget, "responseTime": responseTime])
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
    
    func jsonToString(json: AnyObject){
            do {
                let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                if let convertedString = String(data: data1, encoding: String.Encoding.utf8) { // the data will be converted to the string
                    convertedJSON = convertedString
                    print(convertedString) // <-- here is ur string
                }

            } catch let myJSONError {
                print(myJSONError)
            }

        }

    
    func saveJSONToUserDefaults(jsonStringConverted: String){
      
         UserDefaults.standard.setValue(jsonStringConverted, forKey: "\(avm.currentRun) JSON")
      
   }

    func saveResonseTimeToUserDefaults(array: Array<Double>) {
        UserDefaults.standard.set(array, forKey: "\(avm.currentRun) rt array")
        //save as Date
        UserDefaults.standard.set(Date(), forKey: "\(avm.currentRun) rt date")

    }
    
    func saveResponseTargetToUserDefaults(stringArray: Array<String>) {
        UserDefaults.standard.set(stringArray, forKey: "\(avm.currentRun) targetResponse array")
        //save as Date
        UserDefaults.standard.set(Date(), forKey: "\(avm.currentRun) targetResponse date")

    }
}
