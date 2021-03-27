//
//  File.swift
//  
//
//  Created by Jesly Varghese on 27/03/21.
//

import Foundation
import let Foundation.stdout

public class Spinner {
    private var delay: UInt32
    private var frames: [String]
    private var logText: String?
    private var canRender: Bool = true
    private var isRendering: Bool = false
    private var queue: DispatchQueue = DispatchQueue(label: "com.spinnerkit.log")
    
    static public func spinner(withName name: String) -> Spinner? {
        guard let spinnerEntry = SpinnerList[name] else {
            return nil
        }
        guard let frames: [String] = spinnerEntry["frames"] as? [String],
              let delay: Int = spinnerEntry["interval"] as? Int else {
            return nil
        }
        return Self(frames: frames, delay: UInt32(delay))
    }
    
    required public init(frames: [String], delay: UInt32) {
        self.frames = frames
        self.delay = delay * 1000
    }
    
    private func render() {
        guard !isRendering else {
            return
        }
        isRendering = true
        var index = 0
        queue.async { [self] in
            repeat {
                fflush(stdout)
                if let text = logText {
                    print("\r\(self.frames[index % (self.frames.count - 1)]) \(text)", terminator: "")
                } else {
                    print("\r\(self.frames[index % (self.frames.count - 1)])", terminator: "")
                }
                fflush(stdout)
                usleep(self.delay)
                index += 1
            } while self.canRender
        }
    }
    
    public func start() {
        render()
    }
    
    public func stop(withStatusFrame statusFrame: String? = nil, message: String? = nil) {
        canRender = false
        usleep(delay)
        let statusFrame = statusFrame ?? ""
        let message = message ?? ""
        print("\r\(statusFrame) \(message)")
        fflush(stdout)
    }
    
    public func log(_ text: String) {
        logText = text
        print("\r\(String(repeating: " ", count: (self.logText?.count ?? 0) * 10))", terminator: "")
        fflush(stdout)
    }
}
