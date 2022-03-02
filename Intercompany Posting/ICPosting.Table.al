table 50123 "PTE IC Posting"
{
    TableType = Temporary;
    fields
    {
        field(1; Company; Text[30]) { }
        field(2; "Intercompany Dimension"; Enum "PTE Intercompany Dimension") { }
        field(8; Amount; Decimal) { }
        field(11; "Shortcut Dimension 1 Code"; Code[20]) { }
        field(12; "Shortcut Dimension 2 Code"; Code[20]) { }
    }

    keys { key(Key1; Company) { Clustered = true; } }

    procedure CreateICPosting()
    var
        ICDim: Interface "PTE Intercompany Dimensions";
    begin
        ICDim := "Intercompany Dimension";
        ICDim.CreateICPosting(Rec);
    end;
}