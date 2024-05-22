*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       https://reqres.in/api

*** Test Cases ***
GET List Users
    Create Session    reqres    ${BASE_URL}
    ${response}=    Get Request    reqres    /users?page=2
    Should Be Equal As Numbers    ${response.status_code}    200
    Dictionary Should Contain Value    ${response.json()}    total
    Dictionary Should Contain Value    ${response.json()["data"][0]}    last_name
    Dictionary Should Contain Value    ${response.json()["data"][1]}    last_name
    ${total_users}=    Get Length    ${response.json()["data"]}
    Should Be Equal As Numbers    ${total_users}    ${response.json()["total"]}

POST Create User
    Create Session    reqres    ${BASE_URL}
    ${data}=    Create Dictionary    name=morpheus    job=leader
    ${response}=    Post Request    reqres    /users    json=${data}
    Should Be Equal As Numbers    ${response.status_code}    201
    Dictionary Should Contain Value    ${response.json()}    name
    Dictionary Should Contain Value    ${response.json()}    job
