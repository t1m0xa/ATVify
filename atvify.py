from prompt_toolkit.shortcuts import radiolist_dialog
from prompt_toolkit.shortcuts import input_dialog
from prompt_toolkit.shortcuts import yes_no_dialog
from prompt_toolkit.shortcuts import message_dialog
from prompt_toolkit import print_formatted_text, HTML
from prompt_toolkit.styles import Style
import py7zr, os, shutil, time

width = shutil.get_terminal_size().columns
height = shutil.get_terminal_size().lines

lines = []

def center(text):
   os.system('cls')
   
   lines.append(text)
   
   x = (width - max(map(len, lines))) // 2
   y = (height - len(lines)) // 2
   print('\n'*y)
   
   for i, line in enumerate(lines):
      print_formatted_text(HTML(' '*x+'<p color="white">'+line+'</p>'))

example_style = Style.from_dict({
    'dialog':             'bg:#000000',
    'dialog frame.label': 'bg:#000000',
    'dialog.body':        'bg:#000000 #fff',
    'dialog shadow':      'bg:#000000',
})

if os.listdir(os.getcwd()+'\\in'):
   pass
else:
   android = message_dialog(
    title=HTML('<style fg="green">ATV</style><style fg="white">ify</style>'),
    text="Для продолжения закиньте Вашу прошивку в папку in и перезапустите скрипт",
    style=example_style
   ).run()
   exit()

android = radiolist_dialog(
    title=HTML('<style fg="green">ATV</style><style fg="white">ify</style>'),
    text="Какую версию Android использует Ваша прошивка?",
    values=[
        ("android_11", "Android 11"),
        ("android_9", "Android 9")
    ],
    style=example_style
).run()

if android:
   center('Распаковка файлов для замены...')
   archive = py7zr.SevenZipFile(os.getcwd()+'\\bin\\'+android+'.7z', mode='r')
   archive.extractall(path=os.getcwd()+'\\tmp\\')
   archive.close()
   pass
else:
   exit()

bootanimation = radiolist_dialog(
    title=HTML('<style fg="green">ATV</style><style fg="white">ify</style>'),
    text="Какую анимацию загрузки использовать?",
    values=[
        ("bootanimation_atv", "Из Android TV"),
        ("bootanimation_2021", "Из Android TV 2021"),
        ("bootanimation_m", "Из Android 6.0 (Marshmallow)"),
        ("bootanimation_l", "Из Android 5.1 (Lollipop)"),
        ("stock", "Оставить стоковую")
    ],
    style=example_style
).run()

if bootanimation:
   center('Заменяю BootAnimation...')
   dst = os.getcwd()+'\\tmp\\level2\\system\\system\\media'
   
   os.remove(dst+'\\bootanimation.zip')
   shutil.copy(os.getcwd()+'\\_bootanimations\\'+bootanimation+'.zip', dst+'\\bootanimation.zip')
   time.sleep(5)
elif 'stock' == bootanimation:
   pass
else:
   exit()
   
screensaver = radiolist_dialog(
    title=HTML('<style fg="green">ATV</style><style fg="white">ify</style>'),
    text="Какой ScreenSaver использовать?",
    values=[
        ("aerial", "Aerial Dream (как из Apple TV)"),
        ("stock", "Оставить стандартный (Backdrop от Google)")
    ],
    style=example_style
).run()

if screensaver:
   if android == 'android_11':
      dst = os.getcwd()+'\\tmp\\level2\\product\\app\\Backdrop'
   else:
      dst = os.getcwd()+'\\tmp\\level2\\system\\system\\app\\Backdrop'
   center('Заменяю ScreenSaver...')
   
   os.remove(dst+'\\Backdrop.apk')
   shutil.copy(os.getcwd()+'\\_screensavers\\'+screensaver+'.apk', dst+'\\Backdrop.apk')
   time.sleep(5)
elif 'stock' == screensaver:
   pass
else:
   exit()   
   
start = yes_no_dialog(
    title=HTML('<style fg="green">ATV</style><style fg="white">ify</style>'),
    text="Начать сборку прошивки?",
    style=example_style
).run()

if start:
   os.system('_aosp2atv-'+android+'.bat')
   bye = message_dialog(
    title=HTML('<style fg="green">ATV</style><style fg="white">ify</style>'),
    text="Прошивка успешно собрана!",
    style=example_style
   ).run()
   exit()
else:
   exit()      