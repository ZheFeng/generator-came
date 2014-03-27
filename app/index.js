'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var chalk = require('chalk');


var CameGenerator = yeoman.generators.Base.extend({
  init: function () {
    this.pkg = require('../package.json');

    this.on('end', function () {
      if (!this.options['skip-install']) {
        this.installDependencies();
      }
    });
  },

  askFor: function () {
    var done = this.async();

    // have Yeoman greet the user
    this.log(this.yeoman);

    // replace it with a short and sweet description of your generator
    this.log(chalk.magenta('You\'re using the fantastic Came generator.'));

    // var prompts = [{
    //   type: 'confirm',
    //   name: 'someOption',
    //   message: 'Would you like to enable this option?',
    //   default: true
    // }];

    var prompts = []

    this.prompt(prompts, function (props) {
      // this.someOption = props.someOption;

      done();
    }.bind(this));
  },

  app: function () {
    this.mkdir('app');
    this.mkdir('app/views');
    this.mkdir('app/controllers');
    this.mkdir('app/models');
    this.mkdir('lib');
    this.mkdir('config');
    this.mkdir('log');
    this.mkdir('test');
    this.mkdir('public');


    this.copy('index.coffee', 'app/index.coffee');
    this.copy('server.coffee', 'app/server.coffee');

    this.copy('keep', 'app/.keep');
    this.copy('keep', 'app/views/.keep');
    this.copy('keep', 'app/controllers/.keep');
    this.copy('keep', 'app/models/.keep');
    this.copy('keep', 'lib/.keep');
    this.copy('keep', 'config/.keep');
    this.copy('keep', 'log/.keep');
    this.copy('keep', 'test/.keep');
    this.copy('keep', 'public/.keep');

    this.copy('favicon.ico', 'public/favicon.ico');

    this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
    this.copy('bowerrc', '.bowerrc');
    this.copy('_package.json', 'package.json');
    this.copy('_bower.json', 'bower.json');
  },

  projectfiles: function () {
    this.copy('editorconfig', '.editorconfig');
    this.copy('jshintrc', '.jshintrc');
  }
});

module.exports = CameGenerator;
