unit Base36;
{ Copyright (c) 2024 Jim Stanley }
interface

function IntTo36(const Value: NativeInt): string; inline;
function Int64To36(const Value: Int64): string;

function GetARandomLetter: Char;

function Base36ToInt64(const Value36: string): Int64;

implementation

uses
  System.SysUtils;

const
  Alphabet = '0123456789abcdefghijklmnopqrstuvwxyz';
//                      11111111112222222222333333
//            012345678901234567890123456789012345
  Modulus: Integer = Length(Alphabet);//36;
  Ord0: Integer = Ord('0');
  Ord9: Integer = Ord('9');
  Orda: Integer = Ord('a');
  Ordz: Integer = Ord('z');

function IntTo36(const Value: NativeInt): string; inline;
begin
  Result := Int64To36(Int64(Value));
end;

function Int64To36(const Value: Int64): string;
var
  PositiveValue: Int64;
  Remainder: Integer;
begin
  Result := '';
  PositiveValue := Abs(Value);

  repeat
    Remainder := PositiveValue mod Modulus;
    PositiveValue := PositiveValue div Modulus;
    Result := Alphabet[Remainder + 1] + Result;
  until PositiveValue <= 0;
end;

function Base36ToInt64(const Value36: string): Int64;
var
  CharacterValue: Integer;
begin
  Result := 0;
  for var Index: Integer := 1 to Length(Value36) do
  begin
    CharacterValue := Ord(Value36[Index]);
    if (Ord0 <= CharacterValue) and (CharacterValue <= Ord9) then
    begin
      CharacterValue := CharacterValue - Ord0;
    end
    else if (Orda <= CharacterValue) and (CharacterValue <= Ordz) then
    begin
      CharacterValue := CharacterValue - Orda +  (Ord9 - Ord0 + 1);
    end
    else
    begin
      raise EConvertError.Create('Invalid character ' + Value36[Index] + ' in Base36 number');
    end;

    Result := Result * Modulus + CharacterValue;
  end;
end;

function GetARandomLetter(): Char;
var
  Range: Integer;
begin
  Range := Ordz - Orda + 1;
  Result := Char(System.Random(Range) + Orda);        //ToDo Add test to ensure that all letters will be chosen
end;

initialization
  System.Randomize;
end.
