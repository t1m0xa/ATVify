# О проекте:
**ВСЕ ДЕЛАЕМ НА СВОЙ СТРАХ И РИСК / РАБОТОСПОСОБНОСТЬ ПРОШИВОК НА ANDROID 9 НЕ ПРОВЕРЕНА**

Конвертер AOSP в Android TV, с возможностью смены скринсейвера, BootAnimation и добавления своих программ. Получившуюся прошивку можно будет прошить через USB Burning Tool поверх стоковой (или другой которую вы положили в папку ```in```).

## Прошивки проверены на следующих устройствах:
- Ugoos X4 Pro (проверил @TimiCH@ aka t1m0xa)

## Инструкция по использованию:
1. Установите Python 3 (желательно Python 3.10.7)
2. Установите модули py7zr и prompt_toolkit (```pip install py7zr prompt_toolkit```)
3. Скопируйте Вашу прошивку в папку ```in```
4. Откройте файл ```atvify.py``` через Консоль или двумя кликами
5. Начните сборку прошивки выбирая нужные опции и нажимая кнопку ```Ok``` (переключение при помощи клавиши ```Tab```)
6. Получите модифицированную прошивку в папке ```out```

## Благодарности:
- CryptoNick (за .bat конвертер для Android 11)
- XVortex (за .bat конвертер для Android 11)
