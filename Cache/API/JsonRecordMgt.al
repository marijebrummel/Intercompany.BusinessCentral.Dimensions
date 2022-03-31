codeunit 50125 "PTE Json Record Mgt."
{
    Access = Internal;
    procedure GetDataAsJson(var DimensionProxy: Record "PTE Dimension Value Proxy"): JsonObject
    var
        RecRef: RecordRef;
        Fld: Record Field;
        FldRef: FieldRef;
        DataSet: JsonObject;
        Result: JsonObject;
        Value: JsonValue;
        Token: JsonToken;
        StartingDateTime: DateTime;
        i: Integer;
    begin
        RecRef.Open(DimensionProxy.RecordId.TableNo, true);
        RecRef.Copy(DimensionProxy, true);
        StartingDateTime := CurrentDateTime;
        if RecRef.FindSet() then
            repeat
                i += 1;
                Clear(Result);
                Fld.SetRange(TableNo, RecRef.RecordId.TableNo);
                Fld.SetRange(ObsoleteState, Fld.ObsoleteState::No);
                fld.SetRange("No.", 1, 2000000000 - 1);
                fld.SetRange(Class, Fld.Class::Normal);
                Fld.FindSet();
                repeat
                    FldRef := RecRef.Field(Fld."No.");
                    Value := GetFieldValue(FldRef);
                    Token := Value.AsToken();
                    Result.Add(Fld.FieldName, Token);
                until Fld.Next() = 0;
                FldRef := RecRef.Field(1);
                Result.Add('id', format(GetFieldValue(FldRef)));
            until RecRef.Next() = 0;
        exit(Result);
    end;

    local procedure GetFieldValue(var FldRef: FieldRef) Value: JsonValue
    var
        Bool: Boolean;
        BigInt: BigInteger;
        Txt: Text;
        Dte: Date;
        DteTime: DateTime;
        Dec: Decimal;
        Tme: Time;
    begin
        case FldRef.Type of
            FldRef.Type::BigInteger, FldRef.Type::Integer, FldRef.Type::Option:
                begin
                    BigInt := FldRef.Value;
                    Value.SetValue(BigInt);
                end;
            FldRef.Type::Boolean:
                begin
                    Bool := FldRef.Value;
                    Value.SetValue(Bool);
                end;
            FldRef.Type::Code, FldRef.Type::Text:
                begin
                    Txt := FldRef.Value;
                    Value.SetValue(Txt.Replace('\', ' '));
                end;
            FldRef.Type::Date:
                begin
                    Dte := FldRef.Value;
                    Value.SetValue(Dte);
                end;
            FldRef.Type::DateTime:
                begin
                    DteTime := FldRef.Value;
                    Value.SetValue(DteTime);
                end;
            FldRef.Type::Decimal, FldRef.Type::Duration:
                begin
                    Dec := FldRef.Value;
                    Value.SetValue(Dec);
                end;
            FldRef.Type::Time:
                begin
                    Tme := FldRef.Value;
                    Value.SetValue(Tme);
                end;
        end;
    end;

    procedure SaveData(jsonresult: JsonObject) DimensionProxy: Record "PTE Dimension Value Proxy"
    var
        RecRef: RecordRef;
    begin
        RecRef.Open(DimensionProxy.RecordId.TableNo, true);
        SaveRecordRef(RecRef, jsonresult);
        RecRef.SetTable(DimensionProxy);
    end;

    local procedure SaveRecordRef(var RecRef: RecordRef; DataObject: JsonObject)
    var
        Fld: Record Field;
        FldRef: FieldRef;
        DataField: JsonToken;
        MyValue: JsonValue;
        MyKey: Text;
    begin
        RecRef.Init();
        Fld.SetRange(TableNo, RecRef.Number);
        Fld.SetRange(Class, Fld.Class::Normal);
        Fld.SetRange(ObsoleteState, Fld.ObsoleteState::No);

        foreach MyKey in DataObject.Keys do begin
            DataObject.Get(MyKey, DataField);
            MyValue := DataField.AsValue();
            Fld.SetRange(FieldName, MyKey);
            if Fld.FindFirst() then begin
                FldRef := RecRef.Field(Fld."No.");
                case FldRef.Type of
                    FldRef.Type::Boolean:
                        FldRef.Value(MyValue.AsBoolean());
                    FldRef.Type::Option, FldRef.Type::Integer, FldRef.Type::BigInteger:
                        FldRef.Value(MyValue.AsBigInteger());
                    FldRef.Type::Text, FldRef.Type::Code:
                        FldRef.Value(MyValue.AsText());
                    FldRef.Type::Decimal:
                        FldRef.Value(MyValue.AsDecimal());
                    FldRef.Type::Date:
                        FldRef.Value(MyValue.AsDate());
                    FldRef.Type::DateTime:
                        FldRef.Value(MyValue.AsDateTime());
                    FldRef.Type::Time:
                        FldRef.Value(MyValue.AsTime());
                end;
            end;
        end;
        RecRef.Insert();
    end;

}