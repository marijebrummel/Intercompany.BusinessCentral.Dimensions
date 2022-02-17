table 50110 "PTE Dimension Value Proxy"
{
    TableType = Temporary;
    LookupPageId = "PTE Dimension Value List";
    //    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            //            TableRelation = Dimension;

        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Dimension Value Type"; Option)
        {
            Caption = 'Dimension Value Type';
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";

        }
        field(5; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = IF ("Dimension Value Type" = CONST(Total)) "Dimension Value"."Dimension Code" WHERE("Dimension Code" = FIELD("Dimension Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if not ("Dimension Value Type" in
                        ["Dimension Value Type"::Total, "Dimension Value Type"::"End-Total"]) and (Totaling <> '')
                then
                    FieldError("Dimension Value Type");
            end;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(7; "Consolidation Code"; Code[20])
        {
            AccessByPermission = TableData "Business Unit" = R;
            Caption = 'Consolidation Code';
        }
        field(8; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(9; "Global Dimension No."; Integer)
        {
            Caption = 'Global Dimension No.';
        }
        field(10; "Map-to IC Dimension Code"; Code[20])
        {
            Caption = 'Map-to IC Dimension Code';

            trigger OnValidate()
            begin
                if "Map-to IC Dimension Code" <> xRec."Map-to IC Dimension Code" then
                    Validate("Map-to IC Dimension Value Code", '');
            end;
        }
        field(11; "Map-to IC Dimension Value Code"; Code[20])
        {
            Caption = 'Map-to IC Dimension Value Code';
            TableRelation = "IC Dimension Value".Code WHERE("Dimension Code" = FIELD("Map-to IC Dimension Code"));
        }
        field(15; "Company"; Text[30])
        {

        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
            ObsoleteState = Pending;
            ObsoleteReason = 'This functionality will be replaced by the systemID field';
            ObsoleteTag = '15.0';
        }
        field(8001; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
        }
        field(8002; "Dimension Id"; Guid)
        {
            Caption = 'Dimension Id';
            TableRelation = Dimension.SystemId;

            trigger OnValidate()
            var
                Dimension: Record Dimension;
            begin
                if Dimension.GetBySystemId("Dimension Id") then
                    Validate("Dimension Code", Dimension.Code);
            end;
        }
    }

    keys
    {
        key(Key1; "Dimension Code", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code", "Global Dimension No.")
        {
        }
        key(Key3; Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

}