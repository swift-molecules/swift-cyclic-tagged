import Testing

import Cyclic
import Cyclic_Group_Static
import Cyclic_Group_Static_Element
import Cyclic_Test_Support
import Cyclic_Tagged
import Ordinal
import Tagged

private enum Slot {}

@Suite("Cyclic × Tagged")
struct Cyclic_Tagged_Tests {}

extension Cyclic_Tagged_Tests {

    @Test
    func `init from Element`() {
        let element: Cyclic::Cyclic.Group.Static<5>.Element = 3
        let tagged: Tagged::Tagged<
            Slot,
            Cyclic::Cyclic.Group.Static<5>.Element
        > = .init(element)
        #expect(tagged.underlying == element)
    }

    @Test
    func `init from Ordinal succeeds within bounds`() throws(
        Cyclic::Cyclic.Group.Static<5>.Element.Error
    ) {
        let tagged: Tagged::Tagged<
            Slot,
            Cyclic::Cyclic.Group.Static<5>.Element
        > = try .init(Ordinal::Ordinal(2))
        #expect(tagged.underlying.position.rawValue == 2)
    }

    @Test
    func `init wrapping reduces position`() {
        let tagged: Tagged::Tagged<
            Slot,
            Cyclic::Cyclic.Group.Static<5>.Element
        > = .init(wrapping: Ordinal::Ordinal(7))
        #expect(tagged.underlying.position.rawValue == 2)
    }

    @Test
    func `addition wraps modulo N`() {
        let a: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(4))
        )
        let b: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(3))
        )
        let sum = a + b
        #expect(sum.underlying.position.rawValue == 2)
    }

    @Test
    func `subtraction wraps modulo N`() {
        let a: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(1))
        )
        let b: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(3))
        )
        let diff = a - b
        #expect(diff.underlying.position.rawValue == 3)
    }

    @Test
    func `compound addition wraps`() {
        var a: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(3))
        )
        let b: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(4))
        )
        a += b
        #expect(a.underlying.position.rawValue == 2)
    }

    @Test
    func `compound subtraction wraps`() {
        var a: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(0))
        )
        let b: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<5>.Element> = .init(
            Cyclic::Cyclic.Group.Static<5>.Element(__unchecked: Ordinal::Ordinal(1))
        )
        a -= b
        #expect(a.underlying.position.rawValue == 4)
    }

    @Test
    func `inverse property a plus inverse equals zero`() {
        let a: Tagged::Tagged<Slot, Cyclic::Cyclic.Group.Static<7>.Element> = .init(
            Cyclic::Cyclic.Group.Static<7>.Element(__unchecked: Ordinal::Ordinal(4))
        )
        let sum = a + a.inverse()
        #expect(sum.underlying.position.rawValue == 0)
    }
}

extension Cyclic_Tagged_Tests {

    @Test
    func `init from Ordinal throws out of bounds`() {
        #expect(
            throws: Cyclic::Cyclic.Group.Static<5>.Element.Error.outOfBounds(5)
        ) {
            _ = try Tagged::Tagged<
                Slot,
                Cyclic::Cyclic.Group.Static<5>.Element
            >(Ordinal::Ordinal(5))
        }
    }
}
