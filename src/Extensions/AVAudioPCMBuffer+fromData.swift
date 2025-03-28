import AVFoundation

extension AVAudioPCMBuffer {
	static func fromData(_ data: Data, format: AVAudioFormat) -> AVAudioPCMBuffer? {
		let frameCount = UInt32(data.count) / format.streamDescription.pointee.mBytesPerFrame

		guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
			print("Error: Failed to create AVAudioPCMBuffer")
			return nil
		}

		buffer.frameLength = frameCount
		let audioBuffer = buffer.audioBufferList.pointee.mBuffers

		data.withUnsafeBytes { bufferPointer in
			guard let address = bufferPointer.baseAddress else {
				print("Error: Failed to get base address of data")
				return
			}

			audioBuffer.mData?.copyMemory(from: address, byteCount: Int(audioBuffer.mDataByteSize))
		}

		return buffer
	}

    func averagePower() -> Float {
        guard let channelData = floatChannelData?[0] else { return -100 }
        let count = Int(frameLength)

        let channelDataArray = Array(UnsafeBufferPointer(start: channelData, count: count))

        let sumOfSquares = channelDataArray.map { $0 * $0 }.reduce(0, +)
        let rms = sqrt(sumOfSquares / Float(count))

        let db = 20 * log10(rms)
        return db.isFinite ? db : -100
    }
}
