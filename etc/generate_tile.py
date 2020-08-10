from PIL import Image, ImageFilter
from os import listdir

from random import choice, randint

import sys


def load_tile(base_img, randrotate=False):

    if randrotate:
        angle = choice([90,180,270,360])
    else:
        angle = 0

    img = Image.open("bases/" + base_img + ".png")
    img = img.convert("RGBA")
    img = img.rotate(angle, expand=True)
    data = img.getdata()

    border_data = []
    border = Image.open("bases/" + base_img + ".png")
    border.convert("RGBA")
    border = border.rotate(angle, expand=True)

    greenscreen_data = []
    greenscreen = Image.open("bases/" + base_img + ".png")
    greenscreen.convert("RGBA")
    greenscreen = greenscreen.rotate(angle, expand=True)

    # picks out only the border #000000
    for item in data:
        if item[0] == 0 and item[1] == 0 and item[2] == 0:
            border_data.append(item)
        else:
            border_data.append((255, 255, 255, 0))

    # picks out only the greenscreen #00ff09
    for item in data:
        if item[0] == 0 and item[1] == 255 and item[2] == 9:
            greenscreen_data.append(item)
        else:
            greenscreen_data.append((255, 255, 255, 0))

    greenscreen.putdata(greenscreen_data)
    border.putdata(border_data)

    return img, border, greenscreen


def load_accents(corner=False):
    files = listdir("accents")
    accents = []
    for f in files:
        img = Image.open("accents/" + f)
        if corner and any(substring in f for substring in ["etc"]):
            img = img.rotate(45, expand=True)
        accents.append(img)

    return accents


def remove_greenscreen(img):

    data = img.getdata()

    newData = []

    for item in data:
        if item[0] == 0 and item[1] == 255 and item[2] == 9:
            newData.append((255, 255, 255, 0))
        else:
            newData.append(item)
            
    img.putdata(newData)

    return img


def add_accents(img, min=6, max=12, corner=False):

    accents = load_accents(corner)

    width, height = img.size

    number_of_accents = randint(min,max)
    for i in range(0, number_of_accents):
        angle = choice([90,180,270])
        accent = choice(accents)
        accent = accent.rotate(angle, expand=True)
        img.paste(accent, (randint(0, width), randint(0, height)), accent)

    return img


def clean_up_borders(tile, border, greenscreen):

    tile.paste(border, (0,0), border)
    tile.paste(greenscreen, (0,0), greenscreen)

    tile = remove_greenscreen(tile)

    return tile



def main():


    tile_name = "center1"
    if len(sys.argv) > 2:
        tile_name = sys.argv[2] 
    
    if sys.argv[1] == "decorate":

        tile, border, greenscreen = load_tile(tile_name)

        tile = add_accents(tile, corner=True)
        tile = clean_up_borders(tile, border, greenscreen)


        a = randint(100,999)
        b = randint(100, 999)
        c = randint(100,999)

        tile.save(str(a)+str(b)+str(c)+".png")

    elif sys.argv[1] == "rotations":

        files = listdir("bases")

        for file in files:

            tile_name = file.replace(".png", "")

            tile, border, greenscreen = load_tile(tile_name)

            tile = clean_up_borders(tile, border, greenscreen)

            if "corner" in tile_name:
                names = ["SE", "NE", "NW", "SW"]
            else:
                names = ["N", "W", "S", "E"]


            for i in range(0,4):
                tile.save(tile_name+"_"+names[i]+".png")
                tile = tile.rotate(90, expand=True)



main()

