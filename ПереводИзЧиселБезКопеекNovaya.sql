--select * from SumStrThree5(1717171.17)
--select dbo.SumStrThree5(0)
Create function SumStrThree5 (@nTempValue1 decimal(19,2))
RETURNS varchar(1024)
as begin
/*
Ч Ч ‘ормировани€ строки дл€ трехзначного числа:
Ч (последний трех знаков TempValue
Ч Eсли нужно оперировать с числами > 2 147 483 647
Ч замените в описании на TempValue AS DOUBLE
--====================================
*/
declare @cFullString varchar(1024), @nTempValue int, @cSumma varchar(4000), @nRest int, @nRest1 int, @nRestFl int, @cEndWord varchar(100), @cS1 varchar(40), @cS10 varchar(40), 
		@cS100 varchar(40), @cS1k varchar(40), @cThsnd varchar(15), @cS10k varchar(40), @cS100k varchar(40), 
		@cS1mill varchar(40), @cMillion varchar(40), @cCurrency varchar(10), @cCoins varchar(40), 
		@cSizeCoins varchar(40)
if @nTempValue1 = 0
 begin
  set @cFullString = 'Ќуль гривень 0 коп≥йок'
  
  end
else
 begin
  set @nTempValue = cast(@nTempValue1 as int) 		 
--копейки
  set @nRestFL = cast(((@nTempValue1 / 0.01) % 100) as int)

 set @cSizeCoins = CONVERT(varchar(2), @nRestFl)

  select @cCoins =
  case @nRestFL % 10 
   when 1 then 
    case @nRestFL / 10
     when 1 then ' коп≥йок'
     else ' коп≥йка'
    end
   when 2 then 
    case @nRestFL / 10
      when 1 then ' коп≥йок'
      else ' коп≥йки' 
    end
   when 3 then 
    case @nRestFL / 10
      when 1 then ' коп≥йок'
      else ' коп≥йки'
 	 end
   when 4 then 
    case @nRestFL / 10
     when 1 then ' коп≥йок'
     else  ' коп≥йки'
	 end
   else ' коп≥йок'
  end
--миллионы
 set @nRest =  @nTempValue / 1000000 
   Select @cS1mill =
    Case @nRest   
     when 0 then ''  
     when 1 then 'один '    
     when 2 then 'два '  
     when 3 then 'три '  
     when 4 then 'чотири '  
     when 5 then 'п'+char(39)+'€ть '  
     when 6 then 'ш≥сть '  
     when 7 then 'с≥м '  
     when 8 then 'в≥с≥м '  
     when 9 then 'дев'+ char(39) + '€ть '  
    End;  		
 
 set @cMillion = 
  case @nRest
   when 1 then 'м≥льйон '
   when 2 then 'м≥льйони '		
   when 3 then 'м≥льйони '
   when 4 then 'м≥льйони '
   else 'м≥льйон≥в '	
  end	 
 --сотни тыс€ч
 set @nTempValue = @nTempValue - (@nTempValue / 1000000 * 1000000)
 set @nRest =  @nTempValue / 100000 
 
 Select @cS100k = 
  Case @nRest
   when 0 then ''  
   when 1 then 'сто '  
   when 2 then 'дв≥ст≥ '  
   when 3 then 'триста '  
   when 4 then 'чотириста '  
   when 5 then 'п'+Char(39)+'€тсот '  
   when 6 then 'ш≥стсот '  
   when 7 then 'с≥мсот '  
   when 8 then 'в≥с≥мсот '  
   when 9 then 'дев'+char(39) +'€тсот '  
  End   

--дес€тки тыс€ч
 set @nTempValue = @nTempValue - (@nTempValue / 100000 * 100000)
 set @nRest1 = @nTempValue / 1000
 set @nRest =  @nTempValue / 10000
 
 select @cS10k = 
  case @nRest
   when 0 then ''  
   when 1 then   
    Case @nRest1  
     when 10 then 'дес€ть '  
     when 11 then 'одинадц€ть '  
     when 12 then 'дванадц€ть '  
     when 13 then 'тринадц€ть '  
     when 14 then 'чотирнадц€ть '  
     when 15 then 'п' + char(39) + '€тнадц€ть '  
     when 16 then 'ш≥стнадц€ть '  
     when 17 then 'с≥мнадц€ть '  
     when 18 then 'в≥с≥мнадц€ть '  
     when 19 then 'дев' + char(39) + '€тнадц€ть '  
    End   
   when 2 then 'двадц€ть '  
   when 3 then 'тридц€ть '  
   when 4 then 'сорок '  
   when 5 then 'п' + char(39) + '€тдес€т '  
   when 6 then 'ш≥стдес€т '  
   when 7 then 'с≥мдес€т '  
   when 8 then 'в≥с≥мдес€т '  
   when 9 then 'дев'+char(39)+'€носто ' 
  end

-- тыс€чи
 set @nRest = @nTempValue - (@nTempValue / 10000 * 10000)
 set @cS1k = ''  
 
 If @nRest1 / 10 <> 1 
  begin
   select @cS1k = 
    case @nRest / 1000
    when 0 then ''
    when 1 then 'одна '
    when 2 then 'дв≥  '
    when 3 then 'три '
    when 4 then 'чотири '
    when 5 then 'п' + char(39) + '€ть '
    when 6 then 'ш≥сть '
    when 7 then 'с≥м '
    when 8 then 'в≥с≥м '
    when 9 then 'дев' + char(39) + '€ть '
    end
  end

 select @cThsnd =
  case @nRest / 1000  
   when 1 then 
    case @nRest1 / 10
     when 1 then 'тис€ч '
     else 'тис€ча '
    end
   when 2 then case @nRest1 / 10
     when 1 then 'тис€ч '
     else 'тис€ч≥ '
    end
   when 3 then case @nRest1 / 10
     when 1 then 'тис€ч '
     else 'тис€ч≥ '
    end
   when 4  then case @nRest1 / 10
     when 1 then 'тис€ч '
     else 'тис€ч≥ '
    end
   else 'тис€ч '
  end

--сотни
 set @nTempValue = @nTempValue - (@nTempValue / 1000 * 1000)
 set @nRest = @nTempValue % 1000  

 Select @cS100 = 
  Case @nRest / 100  
   when 0 then ''  
   when 1 then 'сто '  
   when 2 then 'дв≥ст≥ '  
   when 3 then 'триста '  
   when 4 then 'чотириста '  
   when 5 then 'п'+Char(39)+'€тсот '  
   when 6 then 'ш≥стсот '  
   when 7 then 'с≥мсот '  
   when 8 then 'в≥с≥мсот '  
   when 9 then 'дев'+char(39) +'€тсот '  
  End   

--дес€тки
 set @nTempValue = @nTempValue - (@nTempValue / 100 * 100)
 set @nRest = @nTempValue  
 set @nRest1 = @nRest / 10  --дес€тки
 set @cS1 = ''  
 Select @cS10 = 
  Case @nRest1  
   when 0 then ''  
   when 1 then   
    Case @nRest  
     when 10 then 'дес€ть '  
     when 11 then 'одинадц€ть '  
     when 12 then 'дванадц€ть '  
     when 13 then 'тринадц€ть '  
     when 14 then 'чотирнадц€ть '  
     when 15 then 'п' + char(39) + '€тнадц€ть '  
     when 16 then 'ш≥стнадц€ть '  
     when 17 then 'с≥мнадц€ть '  
     when 18 then 'в≥с≥мнадц€ть '  
     when 19 then 'дев' + char(39) + '€тнадц€ть '  
    End   
   when 2 then 'двадц€ть '  
   when 3 then 'тридц€ть '  
   when 4 then 'сорок '  
   when 5 then 'п' + char(39) + '€тдес€т '  
   when 6 then 'ш≥стдес€т '  
   when 7 then 'с≥мдес€т '  
   when 8 then 'в≥с≥мдес€т '  
   when 9 then 'дев'+char(39)+'€носто '  
  End

--единицы
 If @nRest1 <> 1 
  begin   
   Select @cS1 =
    Case @nRest % 10  
     when 0 then ''  
     when 1 then 'одна '    
     when 2 then 'дв≥ '  
     when 3 then 'три '  
     when 4 then 'чотири '  
     when 5 then 'п'+char(39)+'€ть '  
     when 6 then 'ш≥сть '  
     when 7 then 'с≥м '  
     when 8 then 'в≥с≥м '  
     when 9 then 'дев'+ char(39) + '€ть '  
   End;  
  END;

 -- единицы измерени€

 select @cCurrency =
  case @nTempValue % 10 
   when 1 then 
    case @nTempValue / 10
     when 1 then 'гривень '
     else 'гривн€ '
    end
   when 2 then 
    case @nTempValue / 10
      when 1 then 'гривень '
      else 'гривн≥ ' 
	  end
   when 3 then 
    case @nTempValue / 10
      when 1 then 'гривень '
      else 'гривн≥ '
 	end
   when 4 then 
    case @nTempValue / 10
     when 1 then 'гривень '
     else 'гривн≥ ' 
	 end
   else 'гривень '
  end


 if @cS100k = '' and @cS10k = '' and @cS1k = ''
  begin
   set @cThsnd = ''
  end
 if @cS1mill = ''
  begin
   set @cMillion = ''
  end
--сборка строки
 set @cFullString = RTrim(@cS1mill + @cMillion +@cS100k + @cS10k + @cS1k + @cThsnd + @cS100 + @cS10 + @cS1 + @cCurrency + @cSizeCoins + @cCoins)


End
return @cFullString;
end

