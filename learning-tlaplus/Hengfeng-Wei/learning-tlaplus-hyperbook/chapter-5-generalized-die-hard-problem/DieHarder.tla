------------------------------- MODULE DieHarder ----------------------------------
EXTENDS Integers

Min(m,n) == IF m < n THEN m ELSE n

CONSTANTS Goal, Jugs, Capacity

ASSUME /\ Goal \in Nat
       /\ Capacity \in [Jugs -> Nat \ {0}]

(***************************************************************************
--algorithm DieHarder {
  variable injug; \* = [j \in Jugs |-> 0] ;
  { while (TRUE)
     { either with (j \in Jugs) \* fill jug j
                { injug[j] := Capacity[j] }
       or
              with (j \in Jugs) \* empty jug j
                { injug[j] := 0 }
       or
              with (j \in Jugs, k \in Jugs \ {j}) \* pour from jug j to jug k
               { with ( poured =
                         Min(injug[j] + injug[k], Capacity[k]) - injug[k] )
                   { injug[j] := injug[j] - poured ||
                     injug[k] := injug[k] + poured
                   }
               }
     }
  }
}
***************************************************************************)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLE injug

vars == << injug >>

Init == (* Global variables *)
        /\ injug = defaultInitValue

Next == \/ /\ \E j \in Jugs:
                injug' = [injug EXCEPT ![j] = Capacity[j]]
        \/ /\ \E j \in Jugs:
                injug' = [injug EXCEPT ![j] = 0]
        \/ /\ \E j \in Jugs:
                \E k \in Jugs \ {j}:
                  LET poured == Min(injug[j] + injug[k], Capacity[k]) - injug[k] IN
                    injug' = [injug EXCEPT ![j] = injug[j] - poured,
                                           ![k] = injug[k] + poured]

Spec == Init /\ [][Next]_vars

\* END TRANSLATION


===================================================================================
