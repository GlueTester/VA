class Monster:

    #attributes
    health = 90
    energy = 40

    #methods
    def move(monster,distance,speed):
        print ("Monter is moving")
        print (f'Monster moved {distance} miles at {speed}MPH')

    def attack(monster,amount):
        print ("The monster has attacked")
        print (f'{amount} damage was dealt')
        monster.health -= amount
        print (f'New health: {monster.health}')

monster = Monster()
print (monster.health)
monster.attack(15)
monster.move(50,5)
