import Foundation

struct LDAExecutors {
    
    private init() {}
    
    // MARK: LDA
    struct Immediate: InstructionExecutor {
        func execute(cpu: inout CPU, cycles: inout UInt32, memory: inout Memory) throws {
            // cycle: fetch value
            let byte = cpu.fetchByte(cycles: &cycles, memory: &memory)
            
            cpu.registers.a = byte
            
            LDAExecutors.ldaSetStatus(cpu: &cpu)
        }
    }
    
    // MARK: LDA Zero Page
    struct ZeroPage: InstructionExecutor {
        func execute(cpu: inout CPU, cycles: inout UInt32, memory: inout Memory) throws {
            // cycle: fetch address
            let zeroPageAddress = cpu.fetchByte(cycles: &cycles, memory: &memory)
            
            // cycle: read value
            let byte = cpu.readByte(cycles: &cycles, address: Word(zeroPageAddress), memory: memory)
            
            cpu.registers.a = byte
            
            LDAExecutors.ldaSetStatus(cpu: &cpu)
        }
    }
    
    // MARK: LDA Zero Page X
    struct ZeroPageX: InstructionExecutor {
        func execute(cpu: inout CPU, cycles: inout UInt32, memory: inout Memory) throws {
            // cycle: fetch address
            var zeroPageAddress = cpu.fetchByte(cycles: &cycles, memory: &memory)
            
            // cycle: add x to address
            zeroPageAddress += cpu.registers.x
            cycles -= 1
            
            // cycle: read value
            let byte = cpu.readByte(cycles: &cycles, address: Word(zeroPageAddress), memory: memory)
            
            cpu.registers.a = byte
            
            LDAExecutors.ldaSetStatus(cpu: &cpu)
        }
    }
    
}

// MARK: Common Methods
extension LDAExecutors {
    static func ldaSetStatus(cpu: inout CPU) {
        if cpu.registers.a == 0 {
            cpu.processorStatus.insert(.zero)
        }
        
        if ((cpu.registers.a & 0b10000000) > 0) {
            cpu.processorStatus.insert(.negative)
        }
    }
}
