
module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  APP_PATH = "app"
  PUBLIC_PATH = "public"

  APP_VIEWS_PATH = "#{APP_PATH}/views"
  COMPILE_PATH = "#{PUBLIC_PATH}/compiled"


  grunt.initConfig
    karma:
      # unit:
      #   configFile: 'config/karma.conf.js'
    mochaTest:
      # server:
      #   options:
      #     reporter: "list"
      #     clearRequireCache: true
      #     require: 'coffee-script/register'
      #   src: [
      #     "test/app/start.coffee"
      #     "test/app/**/*_spec.coffee"
      #     "test/app/finish.coffee"
      #   ]
    clean: [COMPILE_PATH]
    uglify:
      # minjs:
      #   files: [{
      #       expand: true,
      #       cwd: COMPILE_PATH,
      #       src: '**/*.js',
      #       dest: COMPILE_PATH
      #       ext: '.min.js'
      #   }]
      #   options:
      #     beautify: false
      #     mangle: false
    coffee:
      # options:
      #   bare: false
      # theme:
      #   expand: true
      #   cwd: THEME_PATH
      #   src: ['**/*.coffee']
      #   dest: COMPILE_PATH
      #   ext: '.js'
    jade:
      # angular:
      #   options:
      #     pretty: false
      #   expand: true
      #   cwd: ANGULAR_PATH
      #   src: ["**/*.jade"]
      #   dest: ANGULAR_COMPILE_PATH
      #   ext: '.html'
    sass:
      # compress:
      #   files: [{
      #     expand: true,
      #     cwd: COMPILE_PATH,
      #     src: ['**/*.css'],
      #     dest: COMPILE_PATH,
      #     ext: '.min.css'
      #   }]
      #   options:
      #     style: 'compressed'
    express:
      options:
        cmd: 'coffee'
      dev:
        options:
          node_env: 'development'
          debug: false
          script: './app'
      debug:
        options:
          node_env: 'development'
          debug: true
          script: './app'
    watch:
      options:
        livereload: true
      server:
        files: ["#{APP_PATH}/**/*.coffee"]
        tasks: ['express:dev', 'delay']
        options:
          spawn: false
      front:
        files: ["#{APP_VIEWS_PATH}/**/*.*"]
        tasks: ['build']

  grunt.registerTask 'delay', 'delay', ->
    delayPeriod = 1000
    grunt.log.write "delay for #{delayPeriod} ms\n"
    done = @async()
    delay = ->
      console.log 'delay completed\n'
      done()
    setTimeout delay, delayPeriod





  grunt.registerTask('build', ['clean', 'jade', 'sass', 'coffee', 'uglify']);
  # grunt.registerTask('startServer', ['mochaTest', 'express:dev']);
  grunt.registerTask('test', ['karma', 'mochaTest']);
  grunt.registerTask('e2e', ['protractor']);

  grunt.registerTask('default', ['build', 'express:dev', 'watch']);
  grunt.registerTask('debug', ['build', 'express:debug', 'watch']);
