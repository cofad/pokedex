# Pokédex

My take on the pokédex from the Pokémon® series written in [Elm](https://elm-lang.org). It can be viewed at [https://cofad.github.io/pokedex/](https://cofad.github.io/pokedex/).

## Table of Contents

1. [Project Goals](#project-goals)
1. [Prerequisites](#prerequisites)
1. [Running the Application](#running-the-application)
1. [Building the Application](#building-application)
1. [Contributing](#contributing)
1. [Credits](#credits)
1. [License](#license)

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

2. The resulting ditributable files in the "build" directory can be uploaded to any server.

## Deploying to Github Pages

1. Run the NPM deploy script to build and deploy the application to Github Pages. The site can be viewed at [https://cofad.github.io/pokedex/](https://cofad.github.io/pokedex/)

   ```console
   npm run deploy
   ```

## Contributing

### Commit Message Guidelines

This project utilizes the [conventional commits](https://www.conventionalcommits.org/en/v1.0.0-beta.4/) standard V1.0.0 with inspiration from the [Angular commit guidelines](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#commit).

#### Type

The commit type must be one of the following:

- build: Changes that affect the build system or external dependecies
- docs: Documentation only changes
- feat: New feature
- fix: A bug fix
- perf: A code change that improves performance
- refactor: A code change that neither fixes a bug nor adds a feature
- style: Changes that do not affect the meaning of the code
- revert: For reverting a commit
- test: Adding missing tests or correcting existing tests

#### Revert

If the commit reverts a previous commit, it should begin with "revert:" , followed by a space and the header of the reverted commit. In the body, it should say, "This reverts commit \<hash\>.", where "\<hash\>" is the SHA of the commit being reverted.

#### Subject

The subject contains a succinct description of the change:

- use the imperative, present tense: "change" not "changed" nor "changes"
- don't capitalize the first letter
- include a space between the after the ":"
- no dot (.) at the end

#### Body

Just as in the subject, use the imperative, present tense: "change" not "changed" nor "changes". The body should include the motivation for the change and contrast this with previous behavior.

#### Footer

The footer should contain any information about Breaking Changes and is also the place to reference GitHub issues that this commit closes.

Breaking Changes should start with the word BREAKING CHANGE: with a space or two newlines. The rest of the commit message is then used for this.

## Credits

### PokéAPI

The pokemon data is retrieved from [PokéAPI](https://pokeapi.co).

## License

This project is licensed under the MIT License.
