tableextension 50102 "PTE Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50100; "PTE Receiving Company"; Text[30]) { }
        field(50140; "PTE Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "PTE Dimension Value Proxy".Code WHERE("Global Dimension No." = CONST(1),
                Blocked = CONST(false), Company = field("PTE Receiving Company"));

            trigger OnValidate()
            var
                EmptyDimCode: Code[20];
            begin
                if "PTE Receiving Company" = '' then
                    ValidateShortcutDimCode(1, "PTE Shortcut Dimension 1 Code")
                else
                    ValidateShortcutDimCode(1, EmptyDimCode);
            end;
        }
        field(50141; "PTE Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "PTE Dimension Value Proxy".Code WHERE("Global Dimension No." = CONST(2),
                Blocked = CONST(false), Company = field("PTE Receiving Company"));

            trigger OnValidate()
            var
                EmptyDimCode: Code[20];
            begin
                if "PTE Receiving Company" = '' then
                    ValidateShortcutDimCode(2, "PTE Shortcut Dimension 2 Code")
                else
                    ValidateShortcutDimCode(2, EmptyDimCode);
            end;
        }
    }
}
