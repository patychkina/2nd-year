create PROCEDURE [Proc_NumbersStatistic] (@StartDay date, @EndDay date)
as
select 
		Numbers.IDNumber,
		Count([dbo].[Reservation_Number].IDReserved) as CountNumber,
		Numbers.[Cost] * ISNULL( DATEDIFF(day, @StartDay, @EndDay), 0) as TotalCost,
		DATEDIFF(day, @StartDay, @EndDay) as TotalDays
from [dbo].[Numbers] left join [dbo].[Reservation_Number] on [dbo].[Numbers].IDNumber = [dbo].[Reservation_Number].IDNumber
group by 
Numbers.IDNumber,
Numbers.[Cost]