table 50120 "PTE IC Dimension Setup"
{
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Primary Key"; Code[1]) { DataClassification = SystemMetadata; }
        field(2; "Intercompany Dimension"; Enum "PTE Intercompany Dimension") { }
    }

    keys { key(Key1; "Primary Key") { Clustered = true; } }

}