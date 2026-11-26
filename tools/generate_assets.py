#!/usr/bin/env python3
"""Generate simple kid-friendly PNG sprites for Kids Adventure Game.

Original programmatic art only (no copyrighted assets).
Output: assets/sprites/*.png and assets/backgrounds/bg_forest.png, assets/icon.png
"""
import math
import os

from PIL import Image, ImageDraw

BASE = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "assets")
SPRITES = os.path.join(BASE, "sprites")
BG = os.path.join(BASE, "backgrounds")
os.makedirs(SPRITES, exist_ok=True)
os.makedirs(BG, exist_ok=True)


def save(img, path):
    img.save(path)
    print(f"{path} {img.size[0]}x{img.size[1]}")


def star_points(cx, cy, r_out, r_in, n=5):
    pts = []
    for i in range(n * 2):
        r = r_out if i % 2 == 0 else r_in
        a = -math.pi / 2 + i * math.pi / n
        pts.append((cx + r * math.cos(a), cy + r * math.sin(a)))
    return pts


def hero_rabbit():
    img = Image.new("RGBA", (96, 120), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # ears
    d.ellipse([28, 2, 44, 42], fill=(255, 255, 255, 255), outline=(180, 180, 180, 255), width=3)
    d.ellipse([52, 2, 68, 42], fill=(255, 255, 255, 255), outline=(180, 180, 180, 255), width=3)
    d.ellipse([33, 10, 39, 34], fill=(255, 170, 200, 255))
    d.ellipse([57, 10, 63, 34], fill=(255, 170, 200, 255))
    # body / shirt
    d.rounded_rectangle([26, 72, 70, 112], radius=12, fill=(50, 150, 255, 255))
    # head
    d.ellipse([22, 30, 74, 82], fill=(255, 255, 255, 255), outline=(180, 180, 180, 255), width=3)
    d.ellipse([36, 52, 44, 62], fill=(30, 30, 30, 255))
    d.ellipse([54, 52, 62, 62], fill=(30, 30, 30, 255))
    d.ellipse([45, 63, 53, 70], fill=(255, 120, 160, 255))
    d.arc([40, 64, 58, 78], start=15, end=165, fill=(30, 30, 30, 255), width=3)
    # feet
    d.ellipse([24, 108, 46, 118], fill=(255, 200, 80, 255))
    d.ellipse([52, 108, 74, 118], fill=(255, 200, 80, 255))
    save(img, os.path.join(SPRITES, "hero_rabbit.png"))


def hero_robot():
    img = Image.new("RGBA", (96, 120), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.line([(48, 18), (48, 32)], fill=(120, 120, 140, 255), width=5)
    d.ellipse([40, 4, 56, 20], fill=(255, 80, 80, 255))
    d.rounded_rectangle([20, 30, 76, 78], radius=14, fill=(190, 200, 215, 255), outline=(110, 120, 140, 255), width=3)
    d.rounded_rectangle([28, 44, 68, 64], radius=8, fill=(30, 40, 70, 255))
    d.ellipse([36, 50, 44, 58], fill=(80, 230, 255, 255))
    d.ellipse([54, 50, 62, 58], fill=(80, 230, 255, 255))
    d.arc([40, 60, 58, 74], start=15, end=165, fill=(80, 230, 255, 255), width=3)
    d.rounded_rectangle([30, 80, 66, 108], radius=10, fill=(255, 170, 40, 255))
    d.ellipse([43, 88, 53, 98], fill=(255, 80, 80, 255))
    d.rectangle([12, 84, 24, 104], fill=(140, 150, 170, 255))
    d.rectangle([72, 84, 84, 104], fill=(140, 150, 170, 255))
    d.ellipse([28, 106, 46, 116], fill=(90, 90, 110, 255))
    d.ellipse([52, 106, 70, 116], fill=(90, 90, 110, 255))
    save(img, os.path.join(SPRITES, "hero_robot.png"))


def hero_stickman():
    img = Image.new("RGBA", (96, 120), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # cap
    d.pieslice([28, 6, 68, 36], start=180, end=360, fill=(255, 60, 60, 255))
    d.rectangle([24, 20, 74, 28], fill=(255, 60, 60, 255))
    # head
    d.ellipse([30, 14, 66, 52], outline=(30, 30, 30, 255), width=5)
    d.ellipse([40, 30, 46, 37], fill=(30, 30, 30, 255))
    d.ellipse([52, 30, 58, 37], fill=(30, 30, 30, 255))
    d.arc([40, 34, 58, 50], start=15, end=165, fill=(30, 30, 30, 255), width=3)
    # body + limbs
    d.line([(48, 52), (48, 84)], fill=(30, 30, 30, 255), width=6)
    d.line([(48, 62), (28, 76)], fill=(30, 30, 30, 255), width=6)
    d.line([(48, 62), (70, 52)], fill=(30, 30, 30, 255), width=6)
    d.line([(48, 84), (32, 110)], fill=(30, 30, 30, 255), width=6)
    d.line([(48, 84), (66, 110)], fill=(30, 30, 30, 255), width=6)
    # shirt dot
    d.ellipse([42, 62, 54, 74], fill=(50, 180, 90, 255))
    save(img, os.path.join(SPRITES, "hero_stickman.png"))


def star():
    img = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.polygon(star_points(32, 32, 28, 13), fill=(255, 205, 40, 255), outline=(220, 150, 0, 255), width=3)
    save(img, os.path.join(SPRITES, "star.png"))


def treasure():
    img = Image.new("RGBA", (110, 90), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([10, 38, 100, 82], radius=8, fill=(150, 95, 45, 255), outline=(100, 60, 25, 255), width=4)
    d.pieslice([10, 8, 100, 58], start=180, end=360, fill=(175, 115, 55, 255), outline=(100, 60, 25, 255), width=4)
    d.rectangle([48, 14, 62, 82], fill=(255, 200, 60, 255))
    d.rounded_rectangle([44, 40, 66, 62], radius=6, fill=(255, 215, 80, 255), outline=(180, 130, 0, 255), width=3)
    d.ellipse([51, 47, 59, 55], fill=(120, 80, 0, 255))
    save(img, os.path.join(SPRITES, "treasure.png"))


def heart():
    img = Image.new("RGBA", (48, 48), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.ellipse([6, 8, 24, 26], fill=(255, 70, 90, 255))
    d.ellipse([24, 8, 42, 26], fill=(255, 70, 90, 255))
    d.polygon([(8, 20), (40, 20), (24, 44)], fill=(255, 70, 90, 255))
    save(img, os.path.join(SPRITES, "heart.png"))


def tree():
    img = Image.new("RGBA", (160, 220), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rectangle([70, 130, 90, 215], fill=(130, 85, 45, 255))
    for (x0, y0, x1, y1) in [(25, 30, 135, 140), (45, 5, 125, 90), (10, 70, 90, 150), (75, 65, 150, 150)]:
        d.ellipse([x0, y0, x1, y1], fill=(55, 175, 75, 255))
    for (x, y) in [(55, 70), (95, 55), (80, 105), (45, 110)]:
        d.ellipse([x, y, x + 14, y + 14], fill=(255, 90, 90, 255))
    save(img, os.path.join(SPRITES, "tree.png"))


def cloud():
    img = Image.new("RGBA", (200, 100), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    for (x0, y0, x1, y1) in [(20, 35, 180, 85), (45, 15, 120, 70), (95, 22, 165, 75)]:
        d.ellipse([x0, y0, x1, y1], fill=(255, 255, 255, 235))
    save(img, os.path.join(SPRITES, "cloud.png"))


def ground_tile():
    img = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rectangle([0, 0, 128, 34], fill=(70, 190, 85, 255))
    d.rectangle([0, 34, 128, 128], fill=(155, 105, 60, 255))
    for x in range(8, 128, 24):
        d.line([(x, 4), (x - 4, 22)], fill=(45, 150, 60, 255), width=4)
    for (x, y) in [(25, 60), (70, 85), (100, 55), (45, 105)]:
        d.ellipse([x, y, x + 12, y + 8], fill=(125, 80, 45, 255))
    save(img, os.path.join(SPRITES, "ground_tile.png"))


def bg_forest():
    w, h = 1280, 720
    img = Image.new("RGB", (w, h))
    d = ImageDraw.Draw(img)
    for y in range(h):
        t = y / h
        r = int(120 + (200 - 120) * t)
        g = int(200 + (240 - 200) * t)
        b = int(255 + (200 - 255) * t)
        d.line([(0, y), (w, y)], fill=(r, g, b))
    # sun
    d.ellipse([1080, 50, 1180, 150], fill=(255, 220, 80))
    # far hills
    d.ellipse([-200, 380, 500, 720], fill=(150, 220, 150))
    d.ellipse([350, 420, 950, 760], fill=(130, 210, 140))
    d.ellipse([800, 380, 1450, 730], fill=(150, 220, 150))
    save(img, os.path.join(BG, "bg_forest.png"))


def icon():
    img = Image.new("RGBA", (512, 512), (70, 190, 85, 255))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([16, 16, 496, 496], radius=90, outline=(255, 255, 255, 255), width=16)
    d.polygon(star_points(256, 240, 150, 68), fill=(255, 205, 40, 255), outline=(220, 150, 0, 255), width=10)
    d.ellipse([176, 360, 336, 430], fill=(150, 95, 45, 255))
    save(img, os.path.join(BASE, "icon.png"))


if __name__ == "__main__":
    hero_rabbit()
    hero_robot()
    hero_stickman()
    star()
    treasure()
    heart()
    tree()
    cloud()
    ground_tile()
    bg_forest()
    icon()
    print("DONE")
