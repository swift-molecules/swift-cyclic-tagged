public import Cyclic
public import Ordinal
public import Tagged

extension Tagged where Tag: ~Copyable & ~Escapable {

    /// Creates a tagged value from a validated static cyclic-group element.
    @inlinable
    public init<let N: Int>(_ element: Cyclic.Group.Static<N>.Element)
    where Underlying == Cyclic.Group.Static<N>.Element {
        self.init(_unchecked: element)
    }

    /// Validates an ordinal before storing it as a tagged static cyclic-group element.
    @inlinable
    public init<let N: Int>(_ position: Ordinal) throws(Cyclic.Group.Static<N>.Element.Error)
    where Underlying == Cyclic.Group.Static<N>.Element {
        self.init(_unchecked: try Cyclic.Group.Static<N>.Element(position))
    }

    /// Wraps an ordinal into the static group's range before tagging it.
    @inlinable
    public init<let N: Int>(wrapping position: Ordinal)
    where Underlying == Cyclic.Group.Static<N>.Element {
        self.init(_unchecked: Cyclic.Group.Static<N>.Element(wrapping: position))
    }
}

extension Tagged where Tag: ~Copyable & ~Escapable {

    @inlinable
    public static func + <let N: Int>(lhs: Self, rhs: Self) -> Self
    where Underlying == Cyclic.Group.Static<N>.Element {
        Self(_unchecked: lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func - <let N: Int>(lhs: Self, rhs: Self) -> Self
    where Underlying == Cyclic.Group.Static<N>.Element {
        Self(_unchecked: lhs.underlying - rhs.underlying)
    }

    @inlinable
    public static func += <let N: Int>(lhs: inout Self, rhs: Self)
    where Underlying == Cyclic.Group.Static<N>.Element {
        lhs = lhs + rhs
    }

    @inlinable
    public static func -= <let N: Int>(lhs: inout Self, rhs: Self)
    where Underlying == Cyclic.Group.Static<N>.Element {
        lhs = lhs - rhs
    }
}

extension Tagged where Tag: ~Copyable & ~Escapable {

    /// Returns the additive inverse while preserving the tag.
    @inlinable
    public func inverse<let N: Int>() -> Self where Underlying == Cyclic.Group.Static<N>.Element {
        Self(_unchecked: underlying.inverse)
    }
}
