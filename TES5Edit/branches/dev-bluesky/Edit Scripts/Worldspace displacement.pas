{
  ͨ�� ShiftX, ShiftY���ڳ����м��㣩�滻����ռ䳡����������
  Ӧ�ý���������Ҫ�������������ռ䡣
  ���ϵĴ��������ݲ����¡�
}
unit userscript;

const
  ShiftX = 2;
  ShiftY = -3;
  CellSize = 4096;
 
function Process(e: IInterface): integer;
var
  Sig: string;
  ent, ents, point: IInterface;
  i, j: integer;
begin
  Sig := Signature(e);

  // update regions
  if Sig = 'REGN' then begin
    ents := ElementByName(e, '����Χ');
    for i := 0 to ElementCount(ents) - 1 do begin
      ent := ElementByIndex(ents, i); // get Region Area
      ent := ElementBySignature(ent, 'RPLD'); // points list
      for j := 0 to ElementCount(ent) - 1 do begin
        point := ElementByIndex(ent, j);
        SetElementNativeValues(point, 'X', GetElementNativeValues(point, 'X') + ShiftX*CellSize);
        SetElementNativeValues(point, 'Y', GetElementNativeValues(point, 'Y') + ShiftY*CellSize);
      end;
    end;
  end else

  // update worldspace bounds
  if Sig = 'WRLD' then begin
    SetElementNativeValues(e, '����Χ (δʹ��?)\NAM0\X', GetElementNativeValues(e, '����Χ (δʹ��?)\NAM0\X') + ShiftX);
    SetElementNativeValues(e, '����Χ (δʹ��?)\NAM0\Y', GetElementNativeValues(e, '����Χ (δʹ��?)\NAM0\Y') + ShiftY);
    SetElementNativeValues(e, '����Χ (δʹ��?)\NAM9\X', GetElementNativeValues(e, '����Χ (δʹ��?)\NAM9\X') + ShiftX);
    SetElementNativeValues(e, '����Χ (δʹ��?)\NAM9\Y', GetElementNativeValues(e, '����Χ (δʹ��?)\NAM9\Y') + ShiftY);
  end else

  // update CELL grid coords except persistent cell
  if (Sig = 'CELL') and not GetIsPersistent(e) then begin
    SetElementNativeValues(e, 'XCLC\X', GetElementNativeValues(e, 'XCLC\X') + ShiftX);
    SetElementNativeValues(e, 'XCLC\Y', GetElementNativeValues(e, 'XCLC\Y') + ShiftY);
  end else

  // delete pathgrids and navmeshes, must be recreated
  if (Sig = 'NAVM') or (Sig = 'PGRD') then begin
    RemoveNode(e);
  end else

  // skip other records (should LAND only for worldspace group)
  if (Sig <> 'REFR') and (Sig <> 'PGRE') and (Sig <> 'PMIS') and (Sig <> 'ACHR') and (Sig <> 'ACRE') and
     (Sig <> 'PARW') and (Sig <> 'PBAR') and (Sig <> 'PBEA') and (Sig <> 'PCON') and (Sig <> 'PFLA') and
     (Sig <> 'PHZD')
  then
    Exit;

  // update position of references
  SetElementNativeValues(e, 'DATA\��λ\X', GetElementNativeValues(e, 'DATA\��λ\X') + ShiftX*CellSize);
  SetElementNativeValues(e, 'DATA\��λ\Y', GetElementNativeValues(e, 'DATA\��λ\Y') + ShiftY*CellSize);
end;

end.