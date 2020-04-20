/*
More config information here:
https://github.com/halfzebra/create-elm-app/blob/master/template/README.md#overriding-webpack-config
*/

// stackoverflow.com/questions/53542504/why-is-elm-build-not-working-gives-wrong-path

https: module.exports = {
  homepage: "./", //required to normalise path
};
