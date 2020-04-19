# Pokédex

My take on the pokédex from the Pokémon® series written in [Elm](https://elm-lang.org).

## Table of Contents

- [Project Goals](#project-goals)
- [Prerequisites](#prerequisites)
- [Running the Application](#running-the-application)
- [Building the Application](#building-application)
- [Credits](#credits)
- [License](#license)

## Project Goals

1. Learn the basics of the [Elm](https://elm-lang.org) language by creating an app that retrieves and displays data from a [REST API](https://restfulapi.net/).

2. Create an SVG using [Figma](https://figma.com).

## Prerequisities

### Elm Compiler

The Elm compiler is required to build and run this application. It can obtained and installed using the directions from the [Elm website](https://guide.elm-lang.org/install/elm.html).

### Create Elm App

The [create-elm-app](https://github.com/halfzebra/create-elm-app) utility is required to build and run this project. It can be otained and installed using NPM.

```console
npm install create-elm-app -g
```

## Running the Application

1. Install node modules.

   ```console
   npm install
   ```

2. Run watch css to convert .scss files to .css files. This should continue running througout development in order for the CSS to be updated.

   ```console
   npm run watch-css
   ```

3. Start the dev server and open your browser to localhost:3000 (it should open automatically).

   ```console
   npm run start
   ```

## Building the Application

1. Run the NPM build script.

   ```console
   npm run build
   ```

2. The resulting ditributable files in the "build" directory can uploaded to any server.

## Credits

### PokéAPI

The pokemon data is retrieved from [PokéAPI](https://pokeapi.co).

## License

This project is licensed under the MIT License.
