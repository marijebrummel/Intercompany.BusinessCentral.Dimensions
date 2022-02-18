enum 50110 "PTE Intercompany Dimension" implements "PTE Intercompany Dimensions"
{
    Extensible = true;
    value(0; "Change Company")
    {
        Implementation = "PTE Intercompany Dimensions" = "PTE Dimensions Change Company";
    }
    value(1; "Business Central API")
    {
        Implementation = "PTE Intercompany Dimensions" = "PTE Dimensions Change Company";
    }
    value(2; Dataverse)
    {
        Implementation = "PTE Intercompany Dimensions" = "PTE Dimensions Change Company";
    }
}