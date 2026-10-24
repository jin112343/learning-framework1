# learning-framework1: Webアプリケーションフレームワークの練習（サーバサイド編）

## 参考資料

- [Railsの教科書 - 達人出版会](https://tatsu-zine.com/books/rails-textbook)

※ 『Railsの教科書』以外のチュートリアルをやる場合は、そのリンクを書くこと


## Security update (2026-10-25)

All three Rails applications now use Ruby 3.4.12 and Rails 8.1.4, with committed
Bundler lockfiles. The retired Webpacker/Turbolinks/Sass toolchains have been
replaced by Rails UJS and Sprockets serving the existing styles as modern CSS.
Use `bundle install`, `bin/rails db:prepare`, and `bin/rails assets:precompile`
within the selected application directory. CI runs migration, request, autoload,
asset, and dependency security checks; the book UI has a headless browser suite.

The book applications are private, single-owner applications. Configure
`BOOKS_ADMIN_USER` and a strong `BOOKS_ADMIN_PASSWORD` outside source control and
serve only over HTTPS. Missing credentials return 503; unauthenticated requests
return 401. The static helloworld example remains public and contains no book data.

Book pictures are limited to JPEG/PNG/GIF/WebP up to 5 MiB and stored under
`storage/private_uploads`, outside the public document root. Pictures are served
only through the authenticated book controller, with private/no-store headers.

Before deploying to an existing installation, make and verify a backup of the
SQLite database and uploaded files. Move the existing `public/uploads` directory
to `storage/private_uploads/uploads` without changing identifiers or filenames,
then remove the old public copy only after verifying the protected image route.
Do not expose the old public uploads directory through a web-server alias.
No existing production database or upload directory was changed by this source
upgrade. An active production destination has not been identified.

The checked-in development SQLite file was removed from the current source tree
and preserved outside Git for the account owner. Previous Git history still
contains it; this change does not constitute history sanitization.
