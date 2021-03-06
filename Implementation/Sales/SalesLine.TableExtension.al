tableextension 50110 "PTE Table Extension" extends "Sales Line"
{

    fields
    {
        field(50140; "PTE Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "PTE Dimension Value Proxy".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "PTE Shortcut Dimension 1 Code");
            end;
        }
        field(50141; "PTE Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "PTE Dimension Value Proxy".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "PTE Shortcut Dimension 2 Code");
            end;
        }
        // Add changes to table fields here
    }

}