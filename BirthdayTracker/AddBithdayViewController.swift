//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by chvorda on 4/3/19.
//  Copyright © 2019 chvorda. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var birthdatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        birthdatePicker.maximumDate = Date()
    }
    
    @IBAction func saveTaped(_ sender: UIBarButtonItem) {
        print("Taped Save button")
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdate = birthdatePicker.date
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdate = birthdate as Date?
        newBirthday.dirthdayId = UUID().uuidString
        
        if let uniqueId = newBirthday.dirthdayId {
            print("birthdayId:\(uniqueId)")
        }
        
        do {
            try context.save()
            let message = "Today \(firstName) \(lastName) celebrates birthday!"
            let content = UNMutableNotificationContent()
            content.body = message
            content.sound = UNNotificationSound.default
            var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthdate)
            dateComponents.hour = 21
            dateComponents.minute = 40
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            if let identifier = newBirthday.dirthdayId {
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
                
            }
            
        } catch let error {
            print("Failed to save due to error: \(error)")
        }
        
        dismiss(animated: true, completion: nil)
        
        print("New birthday created")
//        print("Name: \(newBirthday.firstName)")
//        print("Last name: \(newBirthday.lastName)")
//        print("Birthdate: \(newBirthday.birthdate)")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

