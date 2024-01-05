![Top Language](https://img.shields.io/github/languages/top/virtual-tackle-box/back-end-vtb?color=red)
![PRs Closed](https://img.shields.io/github/issues-pr-closed/virtual-tackle-box/back-end-vtb)
![RSpec Version](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![Simplecov Version](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov)
![All Contributors](https://img.shields.io/badge/contributors-2-orange.svg?style=flat)
![CircleCI Build Status](https://img.shields.io/circleci/build/github/virtual-tackle-box/back-end-vtb)

# <p align="center"> Virtual Tackle Box </p>

Looking to improve your fishing experience? Check out Virtual Tackle Box. Our app is designed with a React-Native front end and a Rails API back end to give you a seamless user experience.

Need to save the locations of your go-to fishing spots? We have a mapping feature for that. Want to document your catches? You can easily upload photos directly in the app. Keep track of your most effective lures with our digital log, so you always know what gear to use. Virtual Tackle Box transforms your fishing activities into a well-documented digital history, giving you valuable insights for future trips. Give it a try and elevate your next fishing outing.

## RESTful Endpoints

<details close>

### Create a User

```http
POST /api/v1/users
```

<details close>
<summary>  Details </summary>
<br>

  Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | Created |

Example Value:

```json
{
  "data": [
    {
      "id": "3",
      "type": "user",
      "attributes": {
        "email": "DG@example.com",
        "catches": [],
        "lures": [],
        "phone_number": "+12725551209"
      },
      "relationships": {}
    }
  ]
}

```

</details>

---

### Get a single User

```http
GET /api/v1/users/:id
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
  "data": {
      "id": "3",
      "type": "user",
      "attributes": {
      "email": "DG@example.com",
      "catches": [
        {
          "id": 82,
          "species": "A",
          "weight": 0,
          "length": 0,
          "user_id": 3,
          "created_at": "2023-10-23T00:34:31.648Z",
          "updated_at": "2023-10-23T00:34:31.648Z",
          "spot_name": "A",
          "latitude": 39.668815822843385,
          "longitude": -104.85452662895823,
          "lure": "",
          "cloudinary_urls": []
          },
          {
          "id": 91,
          "species": "A",
          "weight": 0,
          "length": 0,
          "user_id": 3,
          "created_at": "2023-10-23T01:15:07.958Z",
          "updated_at": "2023-10-23T01:15:07.958Z",
          "spot_name": "A",
          "latitude": 39.66744368599523,
          "longitude": -104.85458946523866,
          "lure": "",
          "cloudinary_urls": []
          }
        ],
        "lures": [
          {
            "id": 13,
            "brand": "Oscar Mayer",
            "variety": "Beef",
            "color": "Red/Brown",
            "weight": 0.125,
            "user_id": 3,
            "created_at": "2023-10-21T20:09:17.230Z",
            "updated_at": "2023-10-21T20:09:17.230Z"
          }
        ],
        "phone_number": "+12725551529"
    },
    "relationships": {
      "lures": {
        "data": [
          {
              "id": "13",
              "type": "lure"
          }
       ]
    },
    "catches": {
       "data": [
          {
            "id": "82",
            "type": "catch"
          },
          {
            "id": "91",
            "type": "catch"
          }
        ]
      }
    }
  }
}

```
    
</details>

---

### Get all Lures for a User

```http
GET /api/v1/users/:id/lures
```
<details close>
<summary>  Details </summary>
<br>
  
Parameters: <br>
```
No Parameters
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
  "data": [
    {
      "id": "1",
      "type": "lure",
      "attributes": {
        "brand": "Oscar Mayer",
        "variety": "Beef",
        "color": "Red/Brown",
        "weight": 0.125
      }
    },
    {
      "id": "2",
      "type": "lure",
      "attributes": {
        "brand": "Nature Made",
        "variety": "Bread",
        "color": "Light Brown",
        "weight": 0.015
      }
    }
  ]
}

```

</details>

---

### Get a Single Lure for a User

```http
GET /api/v1/users/:id/lures/:id
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": {
        "id": "1",
        "type": "lure",
        "attributes": {
           "brand": "Rapala",
          "variety": "Plastic",
          "color": "Red/White",
          "weight": 0.125
        }
    }
}

```
    
</details>

---

### Create a User's Lure

```http
POST /api/v1/users/:id/lures
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | Created |

Example Value:

```json
{
  "data": [
    {
      "id": "13",
      "type": "lure",
      "attributes": {
        "brand": "Rapala",
        "variety": "Plug",
        "color": "Green/Orange",
        "weight": 0.210
      }
    }
  ]
}
```
    
</details>

---

### Update a User's Lure

```http
PATCH /api/v1/users/:id/lures/:id 
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": {
        "id": "1",
        "type": "lure",
        "attributes": {
           "brand": "Rapala",
          "variety": "Plastic",
          "color": "Red/White",
          "weight": 0.125
        }
    }
}

```

</details>

---

### Delete a User's Lure

```http
DELETE /api/v1/users/:id/lures/:id 
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 204 | No Content |

Example Value:

```json
""
```

</details>

---

### Create a Catch

```http
POST /api/v1/users/:id/catches 
```

<details close>
<summary>  Details </summary>
<br>

  Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | Created |

Example Value:
```json
  {
    "data": [
   {
      "id": "1",
      "type": "catch",
      "attributes": {
            "id": 1,
            "species": "Largemouth Bass",
            "weight": 8,
            "length": 13,
            "user_id": 1,
            "created_at": "2023-10-22T03:03:10.425Z",
            "updated_at": "2023-10-22T03:03:10.425Z",
            "spot_name": "Josh’s Spot",
            "latitude": 46.805844423621096,
            "longitude": -95.84727562996598,
            "lure": "Frog",
            "cloudinary_urls": [
            "http://res.cloudinary.com/dw48ifzg4/image/upload/v1697943780/ub8iosvp5tog05zfc0t0.jpg"
            ]
      }
    }
  ]
}
```

</details>

---

### Get a Single Catch for a User

```http
GET /api/v1/users/:id/catches/:id
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": {
        "id": "93",
        "type": "catch",
        "attributes": {
           "species": "Large Mouth Bass",
          "weight": 8.75,
          "length": 16.3,
          "latitude": 40.14204615885409,
          "longitude": -105.81135899995948,
          "lure": "Spinner",
          "cloudinary_urls": [
            "http://res.cloudinary.com/dw48ifzg4/image/upload/v1698038953/dortarhdn6c5l8zjsr4k.jpg"
            ]
        }
    }
}

```
    
</details>

### Get all Catches for a User

```http
GET /api/v1/users/:id/catches
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": [
      {
        "id": "93",
        "type": "catch",
        "attributes": {
           "species": "Large Mouth Bass",
          "weight": 8.75,
          "length": 16.3,
          "spot_name": "Grand Lake",
          "latitude": 40.14204615885409,
          "longitude": -105.81135899995948,
          "lure": "Spinner",
          "cloudinary_urls": [
            "http://res.cloudinary.com/dw48ifzg4/image/upload/v1698038953/dortarhdn6c5l8zjsr4k.jpg"
            ]
        }
    },
    {
      "id": "94",
      "type": "catch",
      "attributes": {
         "species": "Pike",
        "weight": 8.75,
        "length": 16.3,
        "spot_name": "Grand Lake",
        "latitude": 40.13561588705203,
        "longitude": -105.83955335970793,
        "lure": "Plug",
        "cloudinary_urls": [
          "http://res.cloudinary.com/dw48ifzg4/image/upload/v1698039143/soxc2n9bweksefjns6nt.jpg"
          ]
      }
  },
  {
      "id": "96",
      "type": "catch",
      "attributes": {
         "species": "Pike",
        "weight": 9.25,
        "length": 18.5,
        "spot_name": "Grand Lake",
        "latitude": 40.13492267254828,
        "longitude": -105.82657490637892,
        "lure": "Crank Bait",
        "cloudinary_urls": [
          "http://res.cloudinary.com/dw48ifzg4/image/upload/v1698039379/dxzndw9rfkux0ishy8yc.jpg"
          ]
       }
    }  
  ]
}

```
</details>

### Update a User's Catch

```http
PATCH /api/v1/users/:id/catches/:id 
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": {
        "id": "96",
        "type": "catch",
        "attributes": {
           "species": "Pike",
        "weight": 10.25,
        "length": 19.75,
        "spot_name": "Grand Lake",
        "latitude": 40.13492267254828,
        "longitude": -105.82657490637892,
        "lure": "Spinner Bait",
        "cloudinary_urls": [
          "http://res.cloudinary.com/dw48ifzg4/image/upload/v1698039379/dxzndw9rfkux0ishy8yc.jpg"
          ]  
        }
    }
}

```

</details>

---

### Delete a User's Catch

```http
DELETE /api/v1/users/:id/catch/:id 
```
<details close>
<summary>  Details </summary>
<br>

Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 204 | No Content |

Example Value:

```json
""
```

</details>
</details>

## Status Codes

Virtual Tackle Box returns the following status codes in its API:

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 201 | `CREATED` |
| 204 | `NO CONTENT` |
| 400 | `BAD REQUEST` |
| 404 | `NOT FOUND` |
| 422 | `UNPROCESSABLE ENTITY`
| 500 | `INTERNAL SERVER ERROR` |

## Prerequisites
Running this project requires:
- Rails 7.0.8
- ruby 3.2.2

## Installation

1. Fork and clone this repository
2. `cd` into the root directiory
3. `bundle install`
4. `rails db:{drop,create,migrate,seed}`
5. Run the test suite with `bundle exec rspec`
6. Start the local server by running `rails s`
7. Visit the app on `localhost:3000` in your web browser

## Database Schema
<img width="1045" alt="Screenshot 2023-10-22 at 3 10 28 PM" src="https://github.com/virtual-tackle-box/back-end-vtb/assets/64923238/400d2627-ec39-426c-9bb3-2c8893968acc">


## Contributors

<b>Daniel Gallagher</b> <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/Daniel-Gallagher92">Daniel-Gallagher92</a> <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LinkedIn: <a href="https://www.linkedin.com/in/daniel-ryan-gallagher/">Daniel Gallagher</a> <br>
