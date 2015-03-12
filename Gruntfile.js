module.exports = function(grunt) {

  var foundationSource = require('shelljs')
    .exec('bundle show foundation-rails', { async: false, silent: true })
    .output
    .replace('\n', '');

  var version = require('./package.json').version;
  grunt.log.writeln('Building version ' + version + '...');

  grunt.initConfig({ 

    clean: {

      // Delete the dist directory when the build starts
      start: ['dist']
    },

    copy: {
      main: {
        files: [

          // Copy in our Sass 
          {
            expand: true, 
            cwd: 'lib/assets/stylesheets',
            src: ['chef.scss', 'chef*/**'], 
            dest: distDir('scss')
          },

          // Copy in our images
          {
            expand: true, 
            cwd: 'lib/assets/images',
            src: ['*.png', '*.svg'], 
            dest: distDir('images')
          },

          // Copy in our fonts
          {
            expand: true, 
            cwd: 'lib/assets/fonts',
            src: ['*'], 
            dest: distDir('fonts')
          },

          // Copy in vendored stylesheets
          {
            expand: true, 
            cwd: 'vendor/assets/stylesheets',
            src: ['csstyle.scss', 'foundation/**'], 
            dest: distDir('scss/vendor')
          },
          {
            expand: true, 
            cwd: foundationSource + '/vendor/assets/stylesheets',
            src: ['foundation.scss', 'normalize.scss', 'foundation/**'], 
            dest: distDir('scss/vendor')
          }
        ],
      },
    }, 

    // Concatenate the JS
    mince: {
      main: {
        options: {
          include: [
            'lib/assets/javascripts',
            foundationSource + '/vendor/assets/javascripts'
          ]
        },
        files: [

          // One big JS with everything
          {
            src: 'lib/assets/javascripts/chef.js',
            dest: distDir('javascripts/chef.js')
          },

          // Individual JS components
          {
            src: 'lib/assets/javascripts/chef/components/top-bar.js',
            dest: distDir('javascripts/chef/components/top-bar.js')
          },
          {
            src: 'lib/assets/javascripts/chef/components/side-nav.js',
            dest: distDir('javascripts/chef/components/side-nav.js')
          },
          {
            src: 'lib/assets/javascripts/chef/components/logo.js',
            dest: distDir('javascripts/chef/components/logo.js')
          }
        ]
      }
    },

    // Compile the CSS
    sass: {         
      dist: {                           
        options: {                      
          style: 'expanded',
          sourcemap: 'none',
          loadPath: [
            './vendor/assets/stylesheets',
            foundationSource + '/vendor/assets/stylesheets'
          ]
        },
        files: sassFiles()
      }
    },

    // Rebuild when assets change
    watch: {
      scripts: {
        files: [
          'lib/assets/**/*'
        ],
        tasks: [
          'build'
        ],
        options: {
          spawn: false
        }
      }
    }
  });

  function distDir(path) {
    return ['dist', path].join('/');
  }

  function sassFiles() {
    var files = {};

    files[distDir('stylesheets/chef.css')] = './lib/assets/stylesheets/chef.scss';

    [
      'accordion',
      'alert',
      'button',
      'code',
      'dropdown',
      'form',
      'icon',
      'label',
      'logo',
      'modal',
      'side-nav',
      'tab',
      'table',
      'top-bar'
    ].forEach(function(o) {
      files[distDir('stylesheets/chef/components/' + o + '.css')] = './lib/assets/stylesheets/chef/components/' + o + '.scss'
    });

    return files;
  }

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-mincer');

  grunt.registerTask('default', ['build']);
  grunt.registerTask('build', ['clean:start', 'copy', 'mince', 'sass']);
};
