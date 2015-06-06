## Hangman

Implementation of [Hangman](http://en.wikipedia.org/wiki/Hangman_%28game%29) for fun.

## API Endpoints

#### `GET /games.json` => Get all games

###### Request

```bash
curl -H 'Content-Type: application/json' \
     -w '\nResponse Code: %{http_code}\n' \
     -X GET http://yd9.net/games.json
```

###### Response

```javascript
  [
    {
      "id":1,
      "tries_left":0,
      "guessed_chars":"jldgnykihf",
      "status":"fail",
      "word":"diyarbakir",
      "url":"http://yd9.net/games/1.json"
    },
    {
      "id":2,
      "tries_left":5,
      "guessed_chars":"eurnlkiab",
      "status":"success",
      "word":"unlikable",
      "url":"http://yd9.net/games/2.json"
    },
    {
      "id":6,
      "tries_left":4,
      "guessed_chars":"jpei",
      "status":"busy",
      "word":"...i.e..",
      "url":"http://yd9.net/games/6.json"
    },
    ...
  ]
  Response Code: 200
```

#### `POST /games.json` => Creates a new game with random word

###### Request

```bash
curl -H 'Content-Type: application/json' \
     -d '' \
     -w '\nResponse Code: %{http_code}\n' \
     -X POST http://yd9.net/games.json
```

###### Response

```javascript
  {
    "id":12,
    "tries_left":6,
    "guessed_chars":"",
    "status":"busy",
    "word":".........",
    "url":"http://yd9.net/games/12.json"
  }
  Response Code: 201
```

#### `GET /games/:id.json` => Get game details

###### Request

```bash
curl -H 'Content-Type: application/json' \
     -w '\nResponse Code: %{http_code}\n' \
     -X GET http://yd9.net/games/2.json
```

###### Response

```javascript
  {
    "id":2,
    "tries_left":5,
    "guessed_chars":"eurnlkiab",
    "status":"success",
    "word":"unlikable",
    "url":"http://yd9.net/games/2.json"
  }
  Response Code: 200
```

#### `POST /games/:id.json` => Make a guess

###### Request

```bash
curl -H 'Content-Type: application/json' \
     -d '{"game": { "char": "a" } }' \
     -w '\nResponse Code: %{http_code}\n' \
     -X POST http://yd9.net/games/10.json
```

###### Response

```javascript
  {
    "id":10,
    "tries_left":5,
    "guessed_chars":"he",
    "status":"busy",
    "word":"...e...ee.",
    "guess_status":"correct",
    "url":"http://yd9.net/games/10.json"
  }
  Response Code: 200
```
