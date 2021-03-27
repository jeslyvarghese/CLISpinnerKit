//
//  main.swift
//  CLIAnimationKitExample
//
//  Created by Jesly Varghese on 25/03/21.
//
import Foundation
import CLISpinnerKit

guard let spinner = Spinner.spinner(withName: "layer") else {
    fatalError()
}
spinner.start()
spinner.log("Starting to do something")
sleep(10)
spinner.log("Doing the thing")
sleep(10)
spinner.stop(withStatusFrame: "✅", message: "Successfully Done The Thing!")
