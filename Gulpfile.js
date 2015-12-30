var autoprefixer = require('gulp-autoprefixer');
var minifyCss = require('gulp-minify-css');
var ghPages = require('gulp-gh-pages');
var plumber = require('gulp-plumber');
var rename = require("gulp-rename");
var uglify = require('gulp-uglify');
var file = require("gulp-file");
var sass = require('gulp-sass');
var elm  = require('gulp-elm');
var gulp = require('gulp');

gulp.task('deploy', ['build'], function() {
  return gulp.src('./dist/**/*')
    .pipe(ghPages());
});

html =
	`<html>
    <head>
    </head>
    <body style="overflow: hidden;margin:0;">
      <script src='main.js' type='application/javascript'>
      </script>
      <script>Elm.fullscreen(Elm.Main);</script>
    </body>
  </html>`

gulp.task('build-js', function () {
  return gulp
    .src('./source/Main.elm')
    .pipe(plumber())
    .pipe(elm())
    .pipe(rename("main.js"))
    .pipe(uglify)
    .pipe(gulp.dest('./dist/'));
});

gulp.task('build-css', function () {
  return gulp
    .src('./stylesheets/main.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer())
    .pipe(minifyCss())
    .pipe(gulp.dest('./dist/'));
});

gulp.task('build-html', function () {
  return gulp
    .src('*/*.nothing')
    .pipe(file('index.html', html))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('build', ['build-js', 'build-css', 'build-html']);