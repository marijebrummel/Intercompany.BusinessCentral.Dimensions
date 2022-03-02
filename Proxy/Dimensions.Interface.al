interface "PTE Intercompany Dimensions"
{
    procedure GetDimensions(var Proxy: Record "PTE Dimension Value Proxy");
    procedure CreateICPosting(var ICPosting: Record "PTE IC Posting");
}
