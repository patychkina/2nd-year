alter table [dbo].[Reservation]
add [TypeNumber] nvarchar(11) constraint DF_Reservation_TypeNumber default ('�����������')

alter table [dbo].[Reservation]
add constraint [CK_Reservation_TypeNumber] check ([TypeNumber] in ('����','����� ����','����������','�����������'))