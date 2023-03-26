import base64

img_path = '/home/vcm/project/be_the_dectective/back_end/mysite/game/resource/scenes.jpg'

with open(img_path, 'rb') as f:
    image_data = f.read()
    base64_data = base64.b64encode(image_data)
