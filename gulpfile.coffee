'use strict'

gulp    = require 'gulp'
rsync   = require 'gulp-rsync'
plumber = require 'gulp-plumber'

config = require './gulp_config.json'

gulp.task 'deploy', ->
  gulp
  .src 'src/**'
  .pipe plumber()
  .pipe rsync
    root: 'src' # コピー元ディレクトリ
    hostname: config.rsync.dst.host # コピー先ホスト名
    destination: config.rsync.dst.path # コピー先ディレクトリ
    progress: true # 転送情報を表示
    recursive: true # 再帰的にディレクトリを走査
    compress: true # 圧縮する
    clean: true # コピー先に存在しないファイルを削除
    exclude: [ # 除外ファイル
      '.git'
      '.gitignore'
      'node_modules'
    ]
  .on 'error', (message) ->
    console.log 'deploy Error', message

gulp.task 'watch', ->
  gulp.watch 'src/**', ['deploy']

gulp.task 'default', ['deploy']
