#!/bin/bash

args=$#

if [ "$args" -ne "0" ]
then
  echo "Script need no parameters"
  exit 1
fi

codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
methods=("GET" "POST" "PUT" "PATCH" "DELETE")
dates=("2023-07-23" "2023-07-24" "2023-07-25" "2023-07-26" "2023-07-27")
urls=("https://www.google.com/" "https://dzen.ru/?yredirect=true" "https://edu.21-school.ru/" 
"https://kazan.hh.ru" "https://edu.tinkoff.ru/" "https://music.yandex.ru/" "https://translate.google.com/")
agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
exts=("git" "png" "pdf" "html" "jpg")

for ((j = 0; j < 5; j++))
do
  dateS=$(date +%Y-%m-%d -d "now + $j days")
  echo "" > "access_$dateS.log"
  records=$(($RANDOM % 1000 + 100))
  for ((i = 0; i < $records; i++))
  do 
    ip="$(($RANDOM % 256)).$(($RANDOM % 256)).$(($RANDOM % 256)).$(($RANDOM % 256))"
    date=$(date "+%d/%b/%Y:" -d "now + $j days")
    utc=$(date "+%z")
    n="$i"
    time=$(date +%H:%M:%S -d "now + $n minutes")
    dateStr="$date$time $utc"
    
    rand=$(($RANDOM % 4))

    method="${methods[$(($RANDOM % 4))]}"
    url="${urls[$(($RANDOM % 6))]}"
    code="${codes[$(($RANDOM % 9))]}"
    bytes=$RANDOM
    agent="${agents[$(($RANDOM % 7))]}"
    request="/artifact_id_$(($RANDOM % 20))"
    ext="${exts[$(($RANDOM % 4))]}"

    res="$ip -- [$dateStr] \"$method $request.$ext HTTP/1.1\" $code $bytes \"$url\" \"$agent\""
    echo "$res" >> "access_$dateS.log"

  done
done

# "200" - "Успешно". Запрос успешно обработан.
# "201" - "Создано". Запрос успешно выполнен и в результате был создан ресурс.
# "400" - "Плохой запрос". Этот ответ означает, что сервер не понимает запрос из-за неверного синтаксиса.
# "401" - "Неавторизованно". Для получения запрашиваемого ответа нужна аутентификация. 
# "403" - "Запрещено". У клиента нет прав доступа к содержимому, поэтому сервер отказывается дать надлежащий ответ.
# "404" - "Не найден". Сервер не может найти запрашиваемый ресурс. 
# "500" - "Внутренняя ошибка сервера". Сервер столкнулся с ситуацией, которую он не знает как обработать.
# "501" - Не реализовано". Метод запроса не поддерживается сервером и не может быть обработан. 
# "502" - "Плохой шлюз". Эта ошибка означает что сервер, во время работы в качестве шлюза для получения ответа,
#          нужного для обработки запроса, получил недействительный (недопустимый) ответ.
# "503" - "Сервис недоступен". Сервер не готов обрабатывать запрос.
