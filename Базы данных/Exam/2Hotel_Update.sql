update [dbo].[Reservation]
set [TypeNumber] = case
			when [Cost] < 2000 then '�����������'
			when [Cost] >= 2000 and [Cost] < 3000 then '����������'
			when [Cost] >= 3000 and [Cost] < 4000 then '����'
			else '����� ����'
			end
from [dbo].[Reservation] 