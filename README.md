# iOS

## Introduction

DevLibs is an app that allows the user to lets people create and share software themed Mad-Libs.

---

## Instructions

Please fork and clone this repository.

---

## API Documentation

The base URL for this API is https://dev-libs.herokuapp.com/

--- 

### Sign Up

**Endpoint:** `/api/auth/register`

**Method:** `POST`

**Description:**
Creates a user whose credentials can then be used to log in to the API.

JSON should be POSTed in the following format: 

``` JSON
{
    "username": "userOne",
    "password": "password"
}
```

#### Success Response

**Code:** `200 OK` or `201 OK`

--- 

### Log In

**Endpoint:** `/api/auth/login`

**Method:** `POST`

**Description:**
After creating a user, you may log in to the API using the same credentials as you used to sign up.

``` JSON
{
    "username": "userOne",
    "password": "password"
}
```

#### Success Response

**Code:** `200 OK` or `201 OK`

--- 

## Authors
Ciara Beitel
Marc Jacques

---

## Misc.

This project was create by Lambda iOS Students to display knowledge of networking basics and core data. 
Students demonstrated team work and creative skills to colloborate with each other to build a cohesive app. 

