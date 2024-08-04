create view [View_TotalDeptors]
as
select
	Clients.IDClient,
	Clients.Surname + ' ' + Clients.Name + ' ' + Clients.Patronymic as '‘»Œ',
	Sum (Numbers.Cost * [dbo].[Reservation_Number].NumberDay) as Cost,
	Sum(PaymentCard.Payment) as Payment
from [dbo].[Clients] left join [dbo].[Reservation_Number] on [dbo].[Clients].IDClient = [dbo].[Reservation_Number].IDClient
left join [dbo].[Reservation] on [dbo].[Clients].IDClient = [dbo].[Reservation].IDClient and [dbo].[Reservation].IDReserved = [dbo].[Reservation_Number].IDReserved
join [dbo].[Accomodation] on [dbo].[Accomodation].IDClient = [dbo].[Reservation].IDClient and [dbo].[Accomodation].IDReserved = [dbo].[Reservation].IDReserved
join [dbo].[PaymentCard] on [dbo].[Accomodation].[IDPaymentCard] = [dbo].[PaymentCard].[IDPaymentCard]
join [dbo].[Numbers] on [dbo].[Reservation_Number].IDNumber = [dbo].[Numbers].IDNumber
where [dbo].[Accomodation].PayDate = NULL
group by
Clients.IDClient,
Clients.Surname + ' ' + Clients.Name + ' ' + Clients.Patronymic