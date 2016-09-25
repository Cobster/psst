var path = require('path');
var webpack = require('webpack');

module.exports = (function() {

    var config = {};

    config.resolve = {
        extensions: ['','.ts','.js'],
        modulesDirectories: ['node_modules']
    };

    config.module = {
        loaders: [
            {
                test: /\.html$/,
                loader: 'raw'
            },
            {
                test: /\.ts$/,
                loader: 'ts',
                exclude: /node_modules/
            }
        ],
        noParse: [ path.join('node_modules','@angular','bundles')]
    }

    config.ts = {
        silent: true // Azure Kudu deployment with PowerShell treats an INFO message as an error.
    };

    config.devtool = 'inline-source-map'


    return config;


})();