import sys
try:
    import pygame
except ImportError:
    import os
    os.system("pip install pygame")
    import pygame
import random


# 화면 설정
WIDTH, HEIGHT = 700, 700
CELL_SIZE = 2
GRID_WIDTH = WIDTH // CELL_SIZE
GRID_HEIGHT = HEIGHT // CELL_SIZE

# 색상
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
BLUE = (0, 100, 255)
RED = (255, 50, 50)
GREY = (220, 220, 220)

# 초기화
pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
clock = pygame.time.Clock()

# 유닛 클래스
class Soldier:
    def __init__(self,HP,x,y,team,attack):
        self.HP = HP
        self.x = x
        self.y = y
        self.team = team
        self.attack = attack
        self.A = 0
        self.B = 0
        self.C = 0
        self.range = 1
    def work(self):
        self.C = 0
        self.A = 1000
        self.B = 1000
        for in_unit in units:
            if abs(in_unit.x - self.x) <= self.range and abs(in_unit.y - self.y) <= self.range and in_unit.team != self.team:
                if min(abs(in_unit.x - self.x),abs(in_unit.y - self.y))+abs(abs(in_unit.x - self.x)-abs(in_unit.y - self.y)) < min(abs(self.A - self.x),abs(self.B - self.y))+abs(abs(self.A - self.x)-abs(self.B - self.y)):
                    self.A = in_unit.x+random.randint(-1,1)
                    self.B = in_unit.y+random.randint(-1,1)
                    self.C = 1
        if self.C == 0:
            D = random.randint(1,GRID_WIDTH)
            E = random.randint(1,GRID_HEIGHT)
            self.move(D,E)
        else:
            self.move(self.A,self.B)
    def move(self, tx, ty):
        if tx > self.x:
            self.x += 1
        elif tx < self.x:
            self.x -= 1
        if ty > self.y:
            self.y += 1
        elif ty < self.y:
            self.y -= 1
        self.range += 0.1
        self.HP += random.randint(1,3)/100

        for in_unit in units:
            if abs(in_unit.x - self.x) <= 1 and abs(in_unit.y - self.y) <= 1 and in_unit.team != self.team:
                in_unit.HP -= self.attack
                break

    def draw(self):
        color = BLUE if self.team == 1 else RED
        pygame.draw.circle(screen, color, (self.x * CELL_SIZE + CELL_SIZE // 2, self.y * CELL_SIZE + CELL_SIZE // 2), CELL_SIZE // 2)

class Barracks:
    def __init__(self, HP, x, y, team, resources):
        self.HP = HP
        self.x = x
        self.y = y
        self.team = team
        self.resources = resources

    def work(self):
        self.summon()

    def summon(self):
        if self.resources >= 20:
            units.append(Soldier(5, self.x, self.y, self.team, 1))
            self.resources -= 20
        else:
            self.resources += random.randint(1, 50-int(self.HP/20))

    def draw(self):
        color = BLUE if self.team == 1 else RED
        pygame.draw.rect(screen, color, (self.x * CELL_SIZE, self.y * CELL_SIZE, CELL_SIZE, CELL_SIZE))

# 유닛 초기화
units = []
units.append(Barracks(500, 2, 2, 1, 0))
units.append(Barracks(500, GRID_WIDTH - 3, GRID_HEIGHT - 3, 2, 0))

# 메인 루프
while True:
    screen.fill(WHITE)

    # 이벤트 처리
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    # 유닛 동작
    for unit in units:
        unit.work()

    # 유닛 그리기
    for unit in units:
        unit.draw()

    # 사망 유닛 제거
    units = [u for u in units if u.HP > 0]

    # 격자 표시 (선택사항)
    for x in range(0, WIDTH, CELL_SIZE):
        pygame.draw.line(screen, GREY, (x, 0), (x, HEIGHT))
    for y in range(0, HEIGHT, CELL_SIZE):
        pygame.draw.line(screen, GREY, (0, y), (WIDTH, y))

    pygame.display.flip()
    clock.tick(30)
