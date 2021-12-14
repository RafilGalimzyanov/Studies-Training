'''
Необходимо создать функцию, которая получает на вход год и выдает словарь где ключами является имя
команды а значениями является список, у которого первая позиция имя игрока набравшего больше всего
очков в сезоне за эту команду, а вторая позиция кол-во очков.
'''

import csv
from pprint import pprint

'''
Функция get_year_data принимает в качестве аргумента наш список данных (результат возвращаемый функией 
load_data), запрашивает у пользователя искомый год, если данный год имеется в столбце 'SeasonStart', то функция
вернет эти эти строки (с нужными годами) в качестве итерируемых объектов
'''

def get_year_data(nba_data):
    year = input("Enter year : ")
    found_result = False
    for row in nba_data:
        if row['SeasonStart'] == year:
            found_result = True
            yield row

    if not found_result:
        print("No data was found")


'''
Функция load_data считывает данные с файла nbaNew.csv, формирует словарь nba_data, ключами которого 
является имя команды, а значение список 
'''

def load_data():
    nba_data = []
    with open('nbaNew.csv', 'r') as file:
        reader = csv.reader(file) #Чтение файла (итерируемый объект)
        field_names = next(reader) #Сохранили первую строку - Заголовки
        for row in reader: #Проходимся по строкам данных (без заголовка)
            row_data = {}
            for key, value in zip(field_names, row): # В zip словаре ставим наши данные в соответствие с заголовками
                row_data[key] = value
            nba_data.append(row_data) # Записали в nba_data
    return nba_data


_team = {"dal": [{"name": "MoDi", "score": 1000}, {"name": "M0X", "score": 888}]}

'''
Функция format_data принимает в качестве аргумента словарь data, запишет данные в формате 'team_name', 
[name, score], отсортирует данные внутри команды по количеству очков. Вернет подходящий ТЗ формат result
'''
def format_data(data):
    result = {}

    for row in data:
        team_name = row["Tm"]
        result[team_name] = team = result.get(team_name, [])
        team.append({"name": row["PlayerName"], "score": int(row["PTS"])})

    for team in result.values():
        team.sort(key=lambda p: p["score"], reverse=True)

    return result

'''
main - основная функция, запускающий все функции. 
'''

def main():
    nba_data = load_data()
    result = None
    while not result:
        result = get_year_data(nba_data)

    pprint(format_data(result))

'''
Конструкция, которая выполняет запуск main() только при непосредственном запуске файла, содержащего эту функция
'''

if __name__ == "__main__":
    main()
