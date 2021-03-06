//
//  ReadStreamOperation.swift
//  Rebekka
//
//  Created by Constantine Fry on 25/05/15.
//  Copyright (c) 2015 Constantine Fry. All rights reserved.
//

import Foundation

/** The base class for read stream operations. */
internal class ReadStreamOperation: StreamOperation {
    
    internal lazy var temporaryBuffer: UnsafeMutablePointer<UInt8> = {
        return UnsafeMutablePointer<UInt8>.alloc(1024)
    }()
    
    lazy var readStream: NSInputStream = {
        let cfStream = CFReadStreamCreateWithFTPURL(nil, self.fullURL())
        CFReadStreamSetDispatchQueue(cfStream.takeUnretainedValue(), self.queue)
        let stream: NSInputStream = cfStream.takeRetainedValue()
        return stream
    }()
    
    override func start() {
        self.startOperationWithStream(self.readStream)
    }
}
