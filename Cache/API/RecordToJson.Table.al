table 50113 "PTE Record to Json"
{
    Caption = 'API';
    DataClassification = ToBeClassified;
    TableType = Temporary;
    Extensible = false;
    Access = Internal;
    fields
    {
        field(1; TableID; Integer) { DataClassification = SystemMetadata; }
        Field(2; SourceTableView; Text[2048]) { DataClassification = SystemMetadata; }
        field(3; "Version"; Text[10]) { DataClassification = SystemMetadata; }
        field(4; Description; Text[50]) { DataClassification = SystemMetadata; }
        field(5; ContainerName; Text[50]) { DataClassification = SystemMetadata; }
        field(6; "Max. Dataset Size"; Integer) { DataClassification = SystemMetadata; }
    }

    keys { key(PK; TableID) { Clustered = true; } }

    procedure GetDataAsJson(var Data: JsonArray): Text
    var
        APIMgt: Codeunit "PTE Json Record Mgt.";
    begin
        exit(APIMgt.GetDataAsJson(Rec, Data));
    end;

}