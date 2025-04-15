import time
import random
import os

x_max = 0
y_max = 0
ture = 0

class unit:
    def __init__(self,HP,x,y):
        self.HP = HP
        self.x = x
        self.y = y
    def move(self,to_x,to_y):
        global x_max,y_max
        if to_x > self.x:
            self.x += 1
        elif to_x < self.x:
            self.x -= 1
        if to_y > self.y:
            self.y += 1
        elif to_y < self.y:
            self.y -= 1
        if self.x > x_max:
            x_max = self.x
        if self.y > y_max:
            y_max = self.y
    def pic(self):
        global ture
        if self.y == I+1 and self.x == K+1 and ture == 0:
            print("\033[34m"+"ㅇ",end="")
            ture = 1
units = []
units.append(unit(10,1,1))
units.append(unit(10,1,1))
units.append(unit(10,1,1))
for i in range(1000):
    os.system("cls")
    for unit in units:
        A = random.randint(1,20)
        B = random.randint(1,20)
        unit.move(A,B)
    for I in range(y_max):
        for K in range(x_max):
            for unit in units:
                unit.pic()
            if ture != 1:
                print("\033[30m"+"ㅁ",end="")
            else:
                ture = 0
        print()
    time.sleep(0.05)
