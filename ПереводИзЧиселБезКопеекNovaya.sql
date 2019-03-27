--select * from SumStrThree5(1717171.17)
--select dbo.SumStrThree5(0)
Create function SumStrThree5 (@nTempValue1 decimal(19,2))
RETURNS varchar(1024)
as begin
/*
� � ������������ ������ ��� ������������ �����:
� (��������� ���� ������ TempValue
� E��� ����� ����������� � ������� > 2 147 483 647
� �������� � �������� �� TempValue AS DOUBLE
--====================================
*/
declare @cFullString varchar(1024), @nTempValue int, @cSumma varchar(4000), @nRest int, @nRest1 int, @nRestFl int, @cEndWord varchar(100), @cS1 varchar(40), @cS10 varchar(40), 
		@cS100 varchar(40), @cS1k varchar(40), @cThsnd varchar(15), @cS10k varchar(40), @cS100k varchar(40), 
		@cS1mill varchar(40), @cMillion varchar(40), @cCurrency varchar(10), @cCoins varchar(40), 
		@cSizeCoins varchar(40)
if @nTempValue1 = 0
 begin
  set @cFullString = '���� ������� 0 ������'
  
  end
else
 begin
  set @nTempValue = cast(@nTempValue1 as int) 		 
--�������
  set @nRestFL = cast(((@nTempValue1 / 0.01) % 100) as int)

 set @cSizeCoins = CONVERT(varchar(2), @nRestFl)

  select @cCoins =
  case @nRestFL % 10 
   when 1 then 
    case @nRestFL / 10
     when 1 then ' ������'
     else ' ������'
    end
   when 2 then 
    case @nRestFL / 10
      when 1 then ' ������'
      else ' ������' 
    end
   when 3 then 
    case @nRestFL / 10
      when 1 then ' ������'
      else ' ������'
 	 end
   when 4 then 
    case @nRestFL / 10
     when 1 then ' ������'
     else  ' ������'
	 end
   else ' ������'
  end
--��������
 set @nRest =  @nTempValue / 1000000 
   Select @cS1mill =
    Case @nRest   
     when 0 then ''  
     when 1 then '���� '    
     when 2 then '��� '  
     when 3 then '��� '  
     when 4 then '������ '  
     when 5 then '�'+char(39)+'��� '  
     when 6 then '����� '  
     when 7 then '�� '  
     when 8 then '��� '  
     when 9 then '���'+ char(39) + '��� '  
    End;  		
 
 set @cMillion = 
  case @nRest
   when 1 then '������ '
   when 2 then '������� '		
   when 3 then '������� '
   when 4 then '������� '
   else '������� '	
  end	 
 --����� �����
 set @nTempValue = @nTempValue - (@nTempValue / 1000000 * 1000000)
 set @nRest =  @nTempValue / 100000 
 
 Select @cS100k = 
  Case @nRest
   when 0 then ''  
   when 1 then '��� '  
   when 2 then '���� '  
   when 3 then '������ '  
   when 4 then '��������� '  
   when 5 then '�'+Char(39)+'����� '  
   when 6 then '������� '  
   when 7 then '����� '  
   when 8 then '������ '  
   when 9 then '���'+char(39) +'����� '  
  End   

--������� �����
 set @nTempValue = @nTempValue - (@nTempValue / 100000 * 100000)
 set @nRest1 = @nTempValue / 1000
 set @nRest =  @nTempValue / 10000
 
 select @cS10k = 
  case @nRest
   when 0 then ''  
   when 1 then   
    Case @nRest1  
     when 10 then '������ '  
     when 11 then '���������� '  
     when 12 then '���������� '  
     when 13 then '���������� '  
     when 14 then '������������ '  
     when 15 then '�' + char(39) + '��������� '  
     when 16 then '����������� '  
     when 17 then '��������� '  
     when 18 then '���������� '  
     when 19 then '���' + char(39) + '��������� '  
    End   
   when 2 then '�������� '  
   when 3 then '�������� '  
   when 4 then '����� '  
   when 5 then '�' + char(39) + '������� '  
   when 6 then '��������� '  
   when 7 then '������� '  
   when 8 then '�������� '  
   when 9 then '���'+char(39)+'������ ' 
  end

-- ������
 set @nRest = @nTempValue - (@nTempValue / 10000 * 10000)
 set @cS1k = ''  
 
 If @nRest1 / 10 <> 1 
  begin
   select @cS1k = 
    case @nRest / 1000
    when 0 then ''
    when 1 then '���� '
    when 2 then '��  '
    when 3 then '��� '
    when 4 then '������ '
    when 5 then '�' + char(39) + '��� '
    when 6 then '����� '
    when 7 then '�� '
    when 8 then '��� '
    when 9 then '���' + char(39) + '��� '
    end
  end

 select @cThsnd =
  case @nRest / 1000  
   when 1 then 
    case @nRest1 / 10
     when 1 then '����� '
     else '������ '
    end
   when 2 then case @nRest1 / 10
     when 1 then '����� '
     else '������ '
    end
   when 3 then case @nRest1 / 10
     when 1 then '����� '
     else '������ '
    end
   when 4  then case @nRest1 / 10
     when 1 then '����� '
     else '������ '
    end
   else '����� '
  end

--�����
 set @nTempValue = @nTempValue - (@nTempValue / 1000 * 1000)
 set @nRest = @nTempValue % 1000  

 Select @cS100 = 
  Case @nRest / 100  
   when 0 then ''  
   when 1 then '��� '  
   when 2 then '���� '  
   when 3 then '������ '  
   when 4 then '��������� '  
   when 5 then '�'+Char(39)+'����� '  
   when 6 then '������� '  
   when 7 then '����� '  
   when 8 then '������ '  
   when 9 then '���'+char(39) +'����� '  
  End   

--�������
 set @nTempValue = @nTempValue - (@nTempValue / 100 * 100)
 set @nRest = @nTempValue  
 set @nRest1 = @nRest / 10  --�������
 set @cS1 = ''  
 Select @cS10 = 
  Case @nRest1  
   when 0 then ''  
   when 1 then   
    Case @nRest  
     when 10 then '������ '  
     when 11 then '���������� '  
     when 12 then '���������� '  
     when 13 then '���������� '  
     when 14 then '������������ '  
     when 15 then '�' + char(39) + '��������� '  
     when 16 then '����������� '  
     when 17 then '��������� '  
     when 18 then '���������� '  
     when 19 then '���' + char(39) + '��������� '  
    End   
   when 2 then '�������� '  
   when 3 then '�������� '  
   when 4 then '����� '  
   when 5 then '�' + char(39) + '������� '  
   when 6 then '��������� '  
   when 7 then '������� '  
   when 8 then '�������� '  
   when 9 then '���'+char(39)+'������ '  
  End

--�������
 If @nRest1 <> 1 
  begin   
   Select @cS1 =
    Case @nRest % 10  
     when 0 then ''  
     when 1 then '���� '    
     when 2 then '�� '  
     when 3 then '��� '  
     when 4 then '������ '  
     when 5 then '�'+char(39)+'��� '  
     when 6 then '����� '  
     when 7 then '�� '  
     when 8 then '��� '  
     when 9 then '���'+ char(39) + '��� '  
   End;  
  END;

 -- ������� ���������

 select @cCurrency =
  case @nTempValue % 10 
   when 1 then 
    case @nTempValue / 10
     when 1 then '������� '
     else '������ '
    end
   when 2 then 
    case @nTempValue / 10
      when 1 then '������� '
      else '����� ' 
	  end
   when 3 then 
    case @nTempValue / 10
      when 1 then '������� '
      else '����� '
 	end
   when 4 then 
    case @nTempValue / 10
     when 1 then '������� '
     else '����� ' 
	 end
   else '������� '
  end


 if @cS100k = '' and @cS10k = '' and @cS1k = ''
  begin
   set @cThsnd = ''
  end
 if @cS1mill = ''
  begin
   set @cMillion = ''
  end
--������ ������
 set @cFullString = RTrim(@cS1mill + @cMillion +@cS100k + @cS10k + @cS1k + @cThsnd + @cS100 + @cS10 + @cS1 + @cCurrency + @cSizeCoins + @cCoins)


End
return @cFullString;
end

