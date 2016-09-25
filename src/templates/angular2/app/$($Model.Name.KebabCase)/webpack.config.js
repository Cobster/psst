var webpack = require('webpack');
var CleanWebpackPlugin = require('clean-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var helpers = require('./webpack.helpers');

module.exports = (function() {
    
    var config = {

        entry: {
            'polyfills': './$($Model.SourceFolder)/polyfills.ts',   
            'vendor': './$($Model.SourceFolder)/vendor.ts',
            'app': './$($Model.SourceFolder)/main.ts'
        },

        output: {
            path: helpers.root('$($Model.ArtifactsFolder)'),
            publicPath: '/dist',
            filename: '[name].js',
            chunkFilename: '[id].chunk.js'
        },

        resolve: {
            cache: true,
            root: helpers.root(),
            extensions: ['','.js','.ts','.css','.scss'],
            alias: {
                'app': 'client/app'
            }
        },

        module: {
            loaders: [
                {
                    test: /\.ts$/,
                    loader: 'ts',
                },
                {
                    test: /\.html$/,
                    loader: 'raw'
                },
                {
                    test: /\.(png|jpe?g|gif|svg|woff|woff2|ttf|eot|ico)$/,
                    loader: 'file?name=assets/[name].[hash].[ext]'
                },
                {
                    test: /\.scss$/,
                    exclude: helpers.root('$($Model.SourceFolder)/app'),
                    loader: ExtractTextPlugin.extract('style', 'css?sourceMap!sass?sourceMap')
                },
                {
                    test: /\.scss$/,
                    include: helpers.root('$($Model.SourceFolder)/app'),
                    loader: 'raw!sass'
                },
                {
                    test: /\.css$/,
                    exclude: helpers.root('$($Model.SourceFolder)/app'),
                    loader: ExtractTextPlugin.extract('style', 'css?sourceMap')
                },
                {
                    test: /\.css$/,
                    include: helpers.root('$($Model.SourceFolder)/app'),
                    loader: 'raw'
                }
            ]
        },

        plugins: [
            new CleanWebpackPlugin([helpers.root('$($Model.ArtifactsFolder)')]),
            new webpack.optimize.CommonsChunkPlugin({
                name: ['app','vendor','polyfills']
            }),
            new HtmlWebpackPlugin({
                template: '$($Model.SourceFolder)/index.html'
            }),
            new ExtractTextPlugin("site.css")
        ]
    };

    if (process.env.NODE_ENV === 'production') {

        config.output.filename = '[name].[hash].js';
        config.output.chunkFilename = '[name].[hash].chunk.js';

        config.plugins.push(new webpack.NoErrorsPlugin());
        config.plugins.push(new webpack.optimize.DedupePlugin());
        config.plugins.push(new webpack.optimize.UglifyJsPlugin());
        config.plugins.push(new webpack.DefinePlugin({
            'process.env': {
                'ENV': JSON.stringify(process.env.NODE_ENV)
            }
        }));
    }

    return config;

})();