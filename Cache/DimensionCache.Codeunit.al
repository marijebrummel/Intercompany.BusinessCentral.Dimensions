codeunit 50111 "PTE Dimension Proxy Cache"
{
    SingleInstance = true;

    procedure SetCache(var DimensionProxy: Record "PTE Dimension Value Proxy")
    var
        JsonRecMgt: Codeunit "PTE Json Record Mgt.";
        RecRef: RecordRef;
    begin
        RecRef.Open(DimensionProxy.RecordId.TableNo, true);
        RecRef.Copy(DimensionProxy, true);
        ClearCache();
        if DimensionProxy.FindSet() then
            repeat
                DimensionCache.Add(0, JsonRecMgt.GetDataAsJson(RecRef))


until DimensionProxy.Next() = 0;
    end;

    procedure ClearCache()
    begin
        Clear(DimensionCache);
    end;

    var
        DimensionCache: Dictionary of [Integer, JsonObject];
}