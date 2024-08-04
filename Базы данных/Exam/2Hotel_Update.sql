update [dbo].[Reservation]
set [TypeNumber] = case
			when [Cost] < 2000 then 'Стандартный'
			when [Cost] >= 2000 and [Cost] < 3000 then 'Улучшенный'
			when [Cost] >= 3000 and [Cost] < 4000 then 'Люкс'
			else 'Супер люкс'
			end
from [dbo].[Reservation] 