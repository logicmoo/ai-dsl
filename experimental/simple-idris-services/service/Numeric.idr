module Numeric
import Data.Nat

%default total

-- Well-founded Integer
-- All Integers are either a natural number
-- or the inversion of a positive number.
public export
data WFInt : Type where
     Nat : (n : Nat) -> WFInt
     Neg : (n : Nat) -> WFInt --Note: In the negative case, n=Z represents -1.

-- Implement casting back and forth from normal Integer type
public export
Cast WFInt Integer where
     cast (Nat n) = cast n
     cast (Neg n) = negate $ cast (S n)


public export
Cast Integer WFInt where
     cast n = case (compare n 0) of
           EQ => Nat (fromInteger n)
           GT => Nat (fromInteger n)
           LT => Neg (fromInteger $ negate $ n + 1)


-- For arithmetic operations, cast to Integer and then cast back
public export
Num WFInt where
   (+) a b = cast $ (cast a) + (cast b)
   (*) a b = cast $ (cast a) * (cast b)
   fromInteger a = cast a


public export
Neg WFInt where
    negate a = cast $ negate $ (the Integer $ cast a)
    (-) a b = cast $ (the Integer $ cast a) - (the Integer $ cast b)

