----------------------------- MODULE ClockSpec ------------------------------
EXTENDS Integers
CONSTANT N
ASSUME (N \in Nat) /\ (N > 0)

(***************************************************************************
--algorithm ClockSpec {
  variable c = 0;
  
  process ( Tick \in 0 .. (N-1) )  
    {  t: while ( TRUE )
            {  await c = self;
               c := (self + 1) % N
            }
    }
}
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLE c

vars == << c >>

ProcSet == (0 .. (N-1))

Init == (* Global variables *)
        /\ c = 0

Tick(self) == /\ c = self
              /\ c' = (self + 1) % N

Next == (\E self \in 0 .. (N-1): Tick(self))

Spec == Init /\ [][Next]_vars

\* END TRANSLATION
=============================================================================
