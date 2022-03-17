codeunit 50111 "PTE Dimension Proxy Cache"
{
    SingleInstance = true;

    trigger OnRun()
    begin

    end;

    var
        DimensionCache: Dictionary of [Code[20], Code[20]];
}