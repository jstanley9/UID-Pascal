unit UIDInterface;
{ Copyright 2024 - J Stanley }
interface

type
  IUID = interface(IInterface)
    ['{ED59AFC5-FACC-4663-A498-A8E886075875}']

    function IsExpectedUID(const ReturnValue: string): Boolean;
    function GetID: string;
    function GetIDLength: Integer;

    property IDLength: Integer read GetIDLength;
  end;

implementation

end.
