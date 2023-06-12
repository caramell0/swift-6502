import Foundation

public typealias Byte = UInt8
public typealias Word = UInt16

public struct Memory {
    static let size: Int = 1024 * 64
    static let initialState = Memory(data: Data(count: size))
    
    var data: Data = Data(count: size)
    
    init(data: Data) {
        guard data.count <= Memory.size else {
            fatalError("Initial data is larger than maximum memory capacity.")
        }
        self.data = data
    }
    
    init() {
        self = Memory.initialState
    }
    
    mutating func initialize() {
        self = Memory.initialState
    }
    
    mutating func write(word: Word, address: Word, cycles: inout UInt32) {
        self[address] = Byte(word & 0xff)
        self[address + 1] = Byte(word >> 8)
        cycles -= 2
    }
}

extension Memory: Collection {
    public typealias Index = Word
    public typealias Element = Byte
    
    public var startIndex: Index { Word(data.startIndex) }
    public var endIndex: Index { Word(data.endIndex) }
    
    public subscript(position: Index) -> Element {
        get { data[Int(position)] }
        set(value) { data[Int(position)] = value }
    }
    
    public func index(after i: Index) -> Index {
        let afterIndexInt = Int(i)
        let resultIndexInt = data.index(after: afterIndexInt)
        
        return Word(resultIndexInt)
    }
}

struct Registers {
    var a: Byte
    var x: Byte
    var y: Byte
    
    init(a: Byte = 0x0, x: Byte = 0x0, y: Byte = 0x0) {
        self.a = a
        self.x = x
        self.y = y
    }
}

struct ProcessorStatus: OptionSet {
    let rawValue: UInt8
    
    init(rawValue: UInt8 = 0x0) {
        self.rawValue = rawValue
    }
    
    static let carry = ProcessorStatus(rawValue: 1 << 0)
    static let zero = ProcessorStatus(rawValue: 1 << 1)
    static let interruptDisable = ProcessorStatus(rawValue: 1 << 2)
    static let decimalMode = ProcessorStatus(rawValue: 1 << 3)
    static let `break` = ProcessorStatus(rawValue: 1 << 4)
    static let overflow = ProcessorStatus(rawValue: 1 << 5)
    static let negative = ProcessorStatus(rawValue: 1 << 6)

    static var all: [ProcessorStatus] {
        return [
            .carry,
            .zero,
            .interruptDisable,
            .decimalMode,
            .break,
            .overflow,
            .negative
        ]
    }
}

enum CPUError: Error {
    case unrecognizedInstruction(byte: Byte)
}

public struct CPU {
    var programCounter: Word
    var stackPointer: Word
    var registers: Registers
    var processorStatus: ProcessorStatus
    
    init() {
        self.programCounter = 0x0
        self.stackPointer = 0x0
        self.registers = Registers()
        self.processorStatus = ProcessorStatus()
    }
    
    mutating func reset(memory: inout Memory) {
        // reset program counter to reset vector
        programCounter = 0xfffc
        stackPointer = 0x0100 // TODO: This isn't accurate emulation
        
        ProcessorStatus.all.forEach { processorStatus.remove($0) }
        
        registers.a = 0x0
        registers.x = 0x0
        registers.y = 0x0
        
        memory.initialize()
    }
    
    func readByte(cycles: inout UInt32, address: Word, memory: Memory) -> Byte {
        let byte = memory[address]
        cycles -= 1
        return byte
    }
    
    mutating func fetchByte(cycles: inout UInt32, memory: inout Memory) -> Byte {
        let byte = memory[programCounter]
        programCounter += 1
        cycles -= 1
        return byte
    }
    
    mutating func fetchWord(cycles: inout UInt32, memory: inout Memory) -> Word {
        var word = Word(memory[programCounter])
        programCounter += 1
        
        word |= (word << 8)
        programCounter += 1
        
        cycles -= 2
        
        return word
    }
    
    mutating func fetchInstruction(cycles: inout UInt32, memory: inout Memory) throws -> Instruction {
        let byte = fetchByte(cycles: &cycles, memory: &memory)
        
        guard let instruction = Instruction(rawValue: byte) else {
            throw CPUError.unrecognizedInstruction(byte: byte)
        }
        
        return instruction
    }
    
    mutating public func execute(cycles: UInt32, memory: inout Memory) throws {
        var cycles = cycles
        
        while cycles > 0 {
            let instruction = try fetchInstruction(cycles: &cycles, memory: &memory)
            try instruction.executor.execute(cpu: &self, cycles: &cycles, memory: &memory)
        }
    }
    
}
