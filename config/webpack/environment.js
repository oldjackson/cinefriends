// const { environment } = require('@rails/webpacker')
// // const erb =  require('./loaders/erb')
// 
// // Bootstrap 3 has a dependency over jQuery:
// const webpack = require('webpack')
// environment.plugins.prepend('Provide',
//   new webpack.ProvidePlugin({
//     $: 'jquery',
//     jQuery: 'jquery'
//   })
// )
// 
// environment.loaders.append('erb', erb)
// module.exports = environment


const { environment } = require('@rails/webpacker')

// Bootstrap 3 has a dependency over jQuery:
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)

module.exports = environment
