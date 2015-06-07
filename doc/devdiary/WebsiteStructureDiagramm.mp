input metauml;
beginfig(1);

Class.Index("Index")()();
Class.Warenkorb("Warenkorb")()();
Class.Registrierung("Registrierung")()();
Class.UserEinstellung("UserEinstellung")()();
Class.Produkte("Produkte")()();
Class.Suche("Suche")()();


drawObjects(Index,Warenkorb,Registrierung,UserEinstellung,Produkte,Suche);
clink(association)(Index,Registrierung);
clink(Registrierung,Index);
clink(Index,Usereinstellung);
clink(Usereinstellung,Index);
clink(Index,Produkte);
clink(Produkte,Index);
clink(Index,Warenkorb);
clink(Warenkorb,Index);

endfig;
end


%Class.P("Person")()();
%Class.C("Company")()();
%
%leftToRight(150)(P, C);
%
%drawObjects(P, C);
%
%clink(association)(P, C);
%
%item(iAssoc)("employee")(obj.sw = P.e);
%item(iAssoc)("1..*")(obj.nw = P.e);
%
%item(iAssoc)("employer")(obj.se = C.w);
%item(iAssoc)("0..*")(obj.ne = C.w);
%
%item(iAssoc)("works for")(obj.s =.5[P.e,C.w]);