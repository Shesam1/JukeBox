User.create([
	{id: 1, name: 'Jon', last: 'Snow', username: 'ghost', password: 'northking', photo: open('http://static.independent.co.uk/s3fs-public/thumbnails/image/2015/06/15/09/jon-snow.jpg'), occupancy: 'King in the North', relationship: 'Its Complicated' },
	{id: 2, name: 'Arya', last: 'Stark', username: 'no1', password: 'iamno1', photo: open('http://images4.fanpop.com/image/photos/24400000/Arya-Stark-arya-stark-24485961-979-809.png'), occupancy: 'No one', relationship: 'single'},
	{id: 3, name: 'Sansa', last: 'Stark', username: 'lady', password: 'joffrey', photo: open('http://images6.fanpop.com/image/photos/37400000/Sansa-Stark-sansa-stark-37474878-4912-7360.jpg'), occupancy: 'Lady of Winterfell', relationship: 'Widowed and Divorced'}
])
Post.create([
	{id: 1, message: "I am King in the North", photo: open('http://awoiaf.westeros.org/images/f/ff/Lino_Drieghe_Winterfell.JPG'), user_id: 1} 
])