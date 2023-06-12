import Foundation

// TODO: Check for accuracy of these values
enum Instruction: Byte {
    // ADC - Add with Carry
    case adcImmediate = 0x69
    case adcZeroPage = 0x65
    case adcZeroPageX = 0x75
    case adcAbsolute = 0x6D
    case adcAbsoluteX = 0x7D
    case adcAbsoluteY = 0x79
    case adcIndirectX = 0x61
    case adcIndirectY = 0x71

    // AND - Logical AND
    case andImmediate = 0x29
    case andZeroPage = 0x25
    case andZeroPageX = 0x35
    case andAbsolute = 0x2D
    case andAbsoluteX = 0x3D
    case andAbsoluteY = 0x39
    case andIndirectX = 0x21
    case andIndirectY = 0x31

    // ASL - Arithmetic Shift Left
    case aslAccumulator = 0x0A
    case aslZeroPage = 0x06
    case aslZeroPageX = 0x16
    case aslAbsolute = 0x0E
    case aslAbsoluteX = 0x1E

    // BCC - Branch if Carry Clear
    case bccRelative = 0x90

    // BCS - Branch if Carry Set
    case bcsRelative = 0xB0

    // BEQ - Branch if Equal
    case beqRelative = 0xF0

    // BIT - Bit Test
    case bitZeroPage = 0x24
    case bitAbsolute = 0x2C

    // BMI - Branch if Minus
    case bmiRelative = 0x30

    // BNE - Branch if Not Equal
    case bneRelative = 0xD0

    // BPL - Branch if Positive
    case bplRelative = 0x10

    // BRK - Force Interrupt
    case brkImplied = 0x00

    // BVC - Branch if Overflow Clear
    case bvcRelative = 0x50

    // BVS - Branch if Overflow Set
    case bvsRelative = 0x70

    // CLC - Clear Carry Flag
    case clcImplied = 0x18

    // CLD - Clear Decimal Mode
    case cldImplied = 0xD8

    // CLI - Clear Interrupt Disable
    case cliImplied = 0x58

    // CLV - Clear Overflow Flag
    case clvImplied = 0xB8

    // CMP - Compare
    case cmpImmediate = 0xC9
    case cmpZeroPage = 0xC5
    case cmpZeroPageX = 0xD5
    case cmpAbsolute = 0xCD
    case cmpAbsoluteX = 0xDD
    case cmpAbsoluteY = 0xD9
    case cmpIndirectX = 0xC1
    case cmpIndirectY = 0xD1

    // CPX - Compare X Register
    case cpxImmediate = 0xE0
    case cpxZeroPage = 0xE4
    case cpxAbsolute = 0xEC

    // CPY - Compare Y Register
    case cpyImmediate = 0xC0
    case cpyZeroPage = 0xC4
    case cpyAbsolute = 0xCC

    // DEC - Decrement Memory
    case decZeroPage = 0xC6
    case decZeroPageX = 0xD6
    case decAbsolute = 0xCE
    case decAbsoluteX = 0xDE

    // DEX - Decrement X Register
    case dexImplied = 0xCA

    // DEY - Decrement Y Register
    case deyImplied = 0x88

    // EOR - Exclusive OR
    case eorImmediate = 0x49
    case eorZeroPage = 0x45
    case eorZeroPageX = 0x55
    case eorAbsolute = 0x4D
    case eorAbsoluteX = 0x5D
    case eorAbsoluteY = 0x59
    case eorIndirectX = 0x41
    case eorIndirectY = 0x51

    // INC - Increment Memory
    case incZeroPage = 0xE6
    case incZeroPageX = 0xF6
    case incAbsolute = 0xEE
    case incAbsoluteX = 0xFE

    // INX - Increment X Register
    case inxImplied = 0xE8

    // INY - Increment Y Register
    case inyImplied = 0xC8

    // JMP - Jump
    case jmpAbsolute = 0x4C
    case jmpIndirect = 0x6C

    // JSR - Jump to Subroutine
    case jsrAbsolute = 0x20

    // LDA - Load Accumulator
    case ldaImmediate = 0xA9
    case ldaZeroPage = 0xA5
    case ldaZeroPageX = 0xB5
    case ldaAbsolute = 0xAD
    case ldaAbsoluteX = 0xBD
    case ldaAbsoluteY = 0xB9
    case ldaIndirectX = 0xA1
    case ldaIndirectY = 0xB1

    // LDX - Load X Register
    case ldxImmediate = 0xA2
    case ldxZeroPage = 0xA6
    case ldxZeroPageY = 0xB6
    case ldxAbsolute = 0xAE
    case ldxAbsoluteY = 0xBE

    // LDY - Load Y Register
    case ldyImmediate = 0xA0
    case ldyZeroPage = 0xA4
    case ldyZeroPageX = 0xB4
    case ldyAbsolute = 0xAC
    case ldyAbsoluteX = 0xBC

    // LSR - Logical Shift Right
    case lsrAccumulator = 0x4A
    case lsrZeroPage = 0x46
    case lsrZeroPageX = 0x56
    case lsrAbsolute = 0x4E
    case lsrAbsoluteX = 0x5E

    // NOP - No Operation
    case nopImplied = 0xEA

    // ORA - Logical OR
    case oraImmediate = 0x09
    case oraZeroPage = 0x05
    case oraZeroPageX = 0x15
    case oraAbsolute = 0x0D
    case oraAbsoluteX = 0x1D
    case oraAbsoluteY = 0x19
    case oraIndirectX = 0x01
    case oraIndirectY = 0x11

    // PHA - Push Accumulator
    case phaImplied = 0x48

    // PHP - Push Processor Status
    case phpImplied = 0x08

    // PLA - Pull Accumulator
    case plaImplied = 0x68

    // PLP - Pull Processor Status
    case plpImplied = 0x28

    // ROL - Rotate Left
    case rolAccumulator = 0x2A
    case rolZeroPage = 0x26
    case rolZeroPageX = 0x36
    case rolAbsolute = 0x2E
    case rolAbsoluteX = 0x3E

    // ROR - Rotate Right
    case rorAccumulator = 0x6A
    case rorZeroPage = 0x66
    case rorZeroPageX = 0x76
    case rorAbsolute = 0x6E
    case rorAbsoluteX = 0x7E

    // RTI - Return from Interrupt
    case rtiImplied = 0x40

    // RTS - Return from Subroutine
    case rtsImplied = 0x60

    // SBC - Subtract with Carry
    case sbcImmediate = 0xE9
    case sbcZeroPage = 0xE5
    case sbcZeroPageX = 0xF5
    case sbcAbsolute = 0xED
    case sbcAbsoluteX = 0xFD
    case sbcAbsoluteY = 0xF9
    case sbcIndirectX = 0xE1
    case sbcIndirectY = 0xF1

    // SEC - Set Carry Flag
    case secImplied = 0x38

    // SED - Set Decimal Flag
    case sedImplied = 0xF8

    // SEI - Set Interrupt Disable
    case seiImplied = 0x78

    // STA - Store Accumulator
    case staZeroPage = 0x85
    case staZeroPageX = 0x95
    case staAbsolute = 0x8D
    case staAbsoluteX = 0x9D
    case staAbsoluteY = 0x99
    case staIndirectX = 0x81
    case staIndirectY = 0x91

    // STX - Store X Register
    case stxZeroPage = 0x86
    case stxZeroPageY = 0x96
    case stxAbsolute = 0x8E

    // STY - Store Y Register
    case styZeroPage = 0x84
    case styZeroPageX = 0x94
    case styAbsolute = 0x8C

    // TAX - Transfer Accumulator to X
    case taxImplied = 0xAA

    // TAY - Transfer Accumulator to Y
    case tayImplied = 0xA8

    // TSX - Transfer Stack Pointer to X
    case tsxImplied = 0xBA

    // TXA - Transfer X to Accumulator
    case txaImplied = 0x8A

    // TXS - Transfer X to Stack Pointer
    case txsImplied = 0x9A

    // TYA - Transfer Y to Accumulator
    case tyaImplied = 0x98
}
