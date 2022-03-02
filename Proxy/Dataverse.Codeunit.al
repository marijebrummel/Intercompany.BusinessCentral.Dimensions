codeunit 50122 "PTE Dimensions Dataverse" implements "PTE Intercompany Dimensions"
{
    procedure GetDimensions(var Proxy: Record "PTE Dimension Value Proxy")
    begin
        Message('Dataverse');
    end;

    procedure CreateICPosting(var ICPosting: Record "PTE IC Posting");
    begin

    end;
}