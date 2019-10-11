# BTS Admin Back-end
This document specifies the process to set up the necessary environment to work with the back-end portion of the **BTS Admin** project. Through the endpoints you can retrieve information from the different tables. Also, you can use the HTTP methods like ``GET``, ``POST``, ``PUT`` and ``DELETE`` to execute the actions desired.

## Installation
To prepare the project we need to do a few things; first, define the project settings and set the DB in your local.

#### Requirements
This API is built on **Node.js** as the main technology used, version ``10.16.3``, and npm version ``6.9.0``  
If  you don't have it, here is the link to download [Node.js](https://nodejs.org/es/).  
Before setting up the project you need to have ready your **postgres server** to create the database.

The details on how to set up your own local PostgreSQL server are specified on the Database documentation in the ``README`` file.

### Steps
1. Download the repository. You need to clone the repo in your local, so paste this command in your CommandLine  
    ````
    git clone git@gitlab.bluetrail.software:bts-platform/bts_internship_2019_be_app.git
    ````
1. Go to the project folder.
1. Open the file ``package.json``, in the property ``config`` set your ``password`` for your local
1. Run the command ``npm run db`` to create the database  
1. Run the  command ``npm install`` in your command line to install all dependencies
1. Create the ``.env.default`` file to set your environment variables, use the ``.env.default.example`` file to know about what you need.  
The project now is ready to be executed
 

Now, you have the API ready to use.

## First use
1. Open your console inside the project folder.
2. Start the application using this command: ```node index.js```.
3. Make a request. Paste the next endpoint in your browser. (By default, the port to be used will be the 3000).
    ````
    http://localhost:3000/api/hello/
    ````
   You have to receive a JSON with the information of all employees in database

## Endpoints
The different endpoints that you can interact with are build in the next form:  
````
http://localhost/api/<endpoint>
````
## Testing 
To run the tests for the API, open a new terminal and type the next code, ``npm run test``.  
This will run the test for the index.js, that means for all the endpoints of API.


