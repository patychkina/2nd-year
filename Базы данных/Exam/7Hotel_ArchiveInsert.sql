insert into [dbo].[Reservation_Archive]
select [dbo].[Reservation].*
from [dbo].[Reservation] join [dbo].[Accomodation] on [dbo].[Reservation].IDReserved =  [dbo].[Accomodation].IDReserved
join [dbo].[PaymentCard] on [dbo].[PaymentCard].IDPaymentCard = [dbo].[Accomodation].IDPaymentCard
where (Reservation.Cost * Reservation.NumberDays) <= [dbo].[PaymentCard].Payment and Reservation.IsPaid = 'True'