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
            ValidateTableRelation = false;

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
            ValidateTableRelation = false;

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
    local procedure PTESaveDimensionSet(ShortCutCode: Integer; DimValue: Code[20])
    var
        DimensionSet: Record "PTE Dimension Set";
        GLSetup: Record "General Ledger Setup";
        DimCode: Code[20];
    begin
        GLSetup.Get();
        if ShortCutCode = 1 then
            DimCode := GLSetup."Global Dimension 1 Code";
        if ShortCutCode = 2 then
            DimCode := GLSetup."Global Dimension 2 Code"; // TODO Add event so people can add 3,4,5??
        if DimCode = '' then
            exit;
        if not DimensionSet.Get(Rec.RecordId, DimCode, DimValue) then begin
            DimensionSet."Record Id" := Rec.RecordId;
            DimensionSet."Dimension Code" := DimCode;
            DimensionSet."Dimension Value Code" := DimValue;
            DimensionSet.Insert();
        end else begin
            DimensionSet."Dimension Value Code" := DimValue;
            DimensionSet.Modify();
        end;
    end;
}
