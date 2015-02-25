module.exports = function(grunt) {

  // Find out where Foundation 5 is installed
  var foundationSource = require('shelljs')
    .exec('bundle show foundation-rails', { async: false, silent: true })
    .output
    .replace('\n', '');

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
            dest: 'dist/scss'
          },

          // Copy in our images
          {
            expand: true, 
            cwd: 'lib/assets/images',
            src: ['*.png', '*.svg'], 
            dest: 'dist/images'
          },

          // Copy in our fonts
          {
            expand: true, 
            cwd: 'lib/assets/fonts',
            src: ['*'], 
            dest: 'dist/fonts'
          },

          // Copy in vendored stylesheets
          {
            expand: true, 
            cwd: 'vendor/assets/stylesheets',
            src: ['csstyle.scss', 'foundation/**'], 
            dest: 'dist/scss/vendor'
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
            dest: 'dist/javascripts/chef.js'
          },

          // Individual JS components
          {
            src: 'lib/assets/javascripts/chef/components/top-bar.js',
            dest: 'dist/javascripts/chef/components/top-bar.js'
          },
          {
            src: 'lib/assets/javascripts/chef/components/side-nav.js',
            dest: 'dist/javascripts/chef/components/side-nav.js'
          },
          {
            src: 'lib/assets/javascripts/chef/components/logo.js',
            dest: 'dist/javascripts/chef/components/logo.js'
          }
        ]
      }
    },

    // Compile the CSS
    sass: {         
      dist: {                           
        options: {                      
          style: 'expanded',
          loadPath: [
            './vendor/assets/stylesheets',
            foundationSource + '/vendor/assets/stylesheets'
          ]
        },
        files: {

          // One big CSS file with everything
          'dist/stylesheets/chef.css': './lib/assets/stylesheets/chef.scss',

          // Individual CSS components
          'dist/stylesheets/chef/components/accordion.css': './lib/assets/stylesheets/chef/components/accordion.scss',
          'dist/stylesheets/chef/components/alert.css': './lib/assets/stylesheets/chef/components/alert.scss',
          'dist/stylesheets/chef/components/button.css': './lib/assets/stylesheets/chef/components/button.scss',
          'dist/stylesheets/chef/components/code.css': './lib/assets/stylesheets/chef/components/code.scss',
          'dist/stylesheets/chef/components/dropdown.css': './lib/assets/stylesheets/chef/components/dropdown.scss',
          'dist/stylesheets/chef/components/form.css': './lib/assets/stylesheets/chef/components/form.scss',
          'dist/stylesheets/chef/components/icon.css': './lib/assets/stylesheets/chef/components/icon.scss',
          'dist/stylesheets/chef/components/label.css': './lib/assets/stylesheets/chef/components/label.scss',
          'dist/stylesheets/chef/components/logo.css': './lib/assets/stylesheets/chef/components/logo.scss',
          'dist/stylesheets/chef/components/modal.css': './lib/assets/stylesheets/chef/components/modal.scss',
          'dist/stylesheets/chef/components/side-nav.css': './lib/assets/stylesheets/chef/components/side-nav.scss',
          'dist/stylesheets/chef/components/tab.css': './lib/assets/stylesheets/chef/components/tab.scss',
          'dist/stylesheets/chef/components/table.css': './lib/assets/stylesheets/chef/components/table.scss',
          'dist/stylesheets/chef/components/top-bar.css': './lib/assets/stylesheets/chef/components/top-bar.scss'
        }
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

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-mincer');

  grunt.registerTask('default', ['build']);
  grunt.registerTask('build', ['clean:start', 'copy', 'mince', 'sass']);
};
