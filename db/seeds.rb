User.destroy_all
Table.destroy_all
Reservation.destroy_all
Restaurant.destroy_all

cla = User.create(username: 'ClaFiore', email: 'claborghini@gmail.com', first_name: 'Claudia', last_name: 'Borghini', address: '2700 Q Street NW, Washington, DC, 20007')

res = Reservation.create(user_id: cla.id, table_id: 1, timeslot: Date.parse('2020/09/25'), duration: 1, party: 2)
