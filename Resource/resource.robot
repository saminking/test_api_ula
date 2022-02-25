*** Settings ***
Library        RequestsLibrary


*** Variables ***
${base_url}            https://fakestoreapi.com
${title}               test products
${price}               12
${description}         for testing  
${image}               https://i.pravatar.cc
${category}            electronic
${productsId}          1
${endPoint}            /products/


*** Keywords ***
GET Single products
    ${getById}=            Catenate                SEPARATOR=            ${endPoint}            ${productsId}
    create session         mysession                ${base_url}
    ${response}=           get on session           mysession            ${getById}
    Set Global Variable    ${response}

Validate Get single products Response Data type
    Status should be        200        ${response}
    ${validateId}=                 Evaluate            isinstance(${response.json()['id']}, int)
    ${validateTitle}=              Evaluate            isinstance($response.json()['title'], str)
    ${validatePrice}=              Evaluate            isinstance(${response.json()['price']}, int)
    ${validateCategory}=           Evaluate            isinstance($response.json()['category'], str)
    ${validateDescription}=        Evaluate            isinstance($response.json()['description'], str)
    ${validateImage}=              Evaluate            isinstance($response.json()['image'], str)

POST products
    ${integerPrice}=        Convert To integer        ${price}
    ${body}=               create dictionary           title=${title}        price=${integerPrice}       description=${description}         image=${image}          category=${category} 
    Set Global Variable      ${body}  
    
    create session         mysession                ${base_url}        
    ${response}=           post on session           mysession            ${endPoint}            ${body}
    Set Global Variable    ${response}

Validate Post product Response
    ${bodyTitle}=        Evaluate        $body.get("title")
    ${respTilte}=        Evaluate        $response.json()["title"]
    Should be equal        ${bodyTitle}            ${respTilte}

    ${bodyPrice}=        Evaluate        $body.get("price")
    ${respPrice}=        Evaluate        ${response.json()["price"]}
    Should be equal        ${bodyPrice}            ${respPrice}

    ${bodyDescription}=        Evaluate        $body.get("description")
    ${respDescription}=        Evaluate        $response.json()["description"]
    Should be equal        ${bodyDescription}            ${respDescription}

    ${bodyImage}=        Evaluate        $body.get("image")
    ${respImage}=        Evaluate        $response.json()["image"]
    Should be equal        ${bodyImage}            ${respImage}

    ${bodyCategory}=        Evaluate        $body.get("category")
    ${respCategory}=        Evaluate        $response.json()["category"]
    Should be equal        ${bodyCategory}            ${respCategory}

    
