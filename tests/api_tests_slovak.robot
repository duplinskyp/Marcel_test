*** Nastavenia ***
Knižnica           RequestsLibrary

*** Premenné ***
${ZAKLADNA_URL}    https://reqres.in/api

*** Testovacie Prípady ***
GET Zoznam Užívateľov
    Vytvoriť Session    reqres    ${ZAKLADNA_URL}
    ${odpoved}=    Get Request    reqres    /users?page=2
    Malo By Byť Rovnaké Ako Čísla    ${odpoved.status_code}    200
    Slovník By Mal Obsahovať Hodnotu    ${odpoved.json()}    total
    Slovník By Mal Obsahovať Hodnotu    ${odpoved.json()["data"][0]}    last_name
    Slovník By Mal Obsahovať Hodnotu    ${odpoved.json()["data"][1]}    last_name
    ${pocet_uzivatelov}=    Získajte Dĺžku    ${odpoved.json()["data"]}
    Malo By Byť Rovnaké Ako Čísla    ${pocet_uzivatelov}    ${odpoved.json()["total"]}

POST Vytvorenie Užívateľa
    Vytvoriť Session    reqres    ${ZAKLADNA_URL}
    ${data}=    Vytvoriť Slovník    name=morpheus    job=leader
    ${odpoved}=    Post Request    reqres    /users    json=${data}
    Malo By Byť Rovnaké Ako Čísla    ${odpoved.status_code}    201
    Slovník By Mal Obsahovať Hodnotu    ${odpoved.json()}    name
    Slovník By Mal Obsahovať Hodnotu    ${odpoved.json()}    job
