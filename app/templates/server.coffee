

express = require 'express'
http = require 'http'
path = require 'path'


exports.start = (callback)->
  app = express()

  app.set 'port', process.env.PORT || 3000
  app.set 'views', path.join(__dirname, 'views')
  app.set 'view engine', 'jade'
  app.use express.compress()
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use express.logger('dev') if 'development' is app.get('env')
  app.use app.router
  app.use express.static(path.join(__dirname, '../public'))
  app.use express.errorHandler() if 'development' is app.get('env')


  app.get '/', (req, res) -> res.send(200)





  http.createServer(app).listen app.get('port'), ->
    console.log "Express server listening on port #{app.get('port')} at #{new Date()}"
    callback app

