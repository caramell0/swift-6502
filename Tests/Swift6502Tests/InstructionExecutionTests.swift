import XCTest
@testable import Swift6502

final class InstructionExecutionTests: XCTestCase {
    
    // MARK: JSR
    
    func test_jsrAbsolute() throws {
        var memory = Memory()
        var cpu = CPU()
        cpu.reset(memory: &memory)
        
        memory[0xfffc] = Instruction.jsrAbsolute.rawValue
        memory[0xfffd] = 0x42
        memory[0xfffe] = 0x42
        memory[0x4242] = Instruction.ldaImmediate.rawValue
        memory[0x4243] = 0x69
        
        try cpu.execute(cycles: 9, memory: &memory)
        
        XCTAssertEqual(cpu.registers.a, 0x69)
        XCTAssertFalse(cpu.processorStatus.contains(.zero))
        XCTAssertFalse(cpu.processorStatus.contains(.negative))
    }
    
    // MARK: LDA
    
    func test_ldaImmediate() throws {
        var memory = Memory()
        var cpu = CPU()
        cpu.reset(memory: &memory)
        
        memory[0xfffc] = Instruction.ldaImmediate.rawValue
        memory[0xfffd] = 0x42
        
        try cpu.execute(cycles: 2, memory: &memory)
        
        XCTAssertEqual(cpu.registers.a, 0x42)
        XCTAssertFalse(cpu.processorStatus.contains(.zero))
        XCTAssertFalse(cpu.processorStatus.contains(.negative))
    }
    
    func test_ldaZeroPage() throws {
        var memory = Memory()
        var cpu = CPU()
        cpu.reset(memory: &memory)
        
        memory[0xfffc] = Instruction.ldaZeroPage.rawValue
        memory[0xfffd] = 0x42
        memory[0x0042] = 0x69
        
        try cpu.execute(cycles: 3, memory: &memory)
        
        XCTAssertEqual(cpu.registers.a, 0x69)
        XCTAssertFalse(cpu.processorStatus.contains(.zero))
        XCTAssertFalse(cpu.processorStatus.contains(.negative))
    }
    
    func test_ldaZeroPageX() throws {
        var memory = Memory()
        var cpu = CPU()
        cpu.reset(memory: &memory)
        cpu.registers.x = 0x1
        
        memory[0xfffc] = Instruction.ldaZeroPageX.rawValue
        memory[0xfffd] = 0x42
        memory[0x0043] = 0x69
        
        try cpu.execute(cycles: 4, memory: &memory)
        
        XCTAssertEqual(cpu.registers.a, 0x69)
        XCTAssertFalse(cpu.processorStatus.contains(.zero))
        XCTAssertFalse(cpu.processorStatus.contains(.negative))
    }
}
