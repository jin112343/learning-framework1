require 'test_helper'

class SecurityTest < ActionDispatch::IntegrationTest
  test 'anonymous users cannot read or change books or download pictures' do
    book = books(:one)
    get books_url
    assert_response :unauthorized
    assert_no_difference('Book.count') do
      post books_url, params: { book: { title: 'unauthorized' } }
      assert_response :unauthorized
      delete book_url(book)
      assert_response :unauthorized
    end
    get picture_book_url(book)
    assert_response :unauthorized
  end

  test 'missing deployment credentials fail closed' do
    previous = ENV.delete('BOOKS_ADMIN_PASSWORD')
    get books_url, headers: admin_headers
    assert_response :service_unavailable
  ensure
    ENV['BOOKS_ADMIN_PASSWORD'] = previous
  end

  test 'invalid credentials are denied' do
    get books_url, headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('test-owner', 'incorrect') }
    assert_response :unauthorized
  end

  test 'HTML capable upload formats are rejected' do
    assert_no_difference('Book.count') do
      post books_url, headers: admin_headers, params: { book: { title: 'unsafe', picture: fixture_file_upload('unsafe.svg', 'image/svg+xml') } }
    end
  end

  test 'valid pictures are stored outside public and require authentication' do
    post books_url, headers: admin_headers, params: { book: { title: 'private', picture: fixture_file_upload('pixel.png', 'image/png') } }
    book = Book.order(:id).last
    assert book.picture.path.start_with?(Rails.root.join('storage', 'private_uploads').to_s)
    get picture_book_url(book), headers: admin_headers
    assert_response :success
    assert_equal 'private, no-store', response.headers['Cache-Control']
    get picture_book_url(book)
    assert_response :unauthorized
  ensure
    book&.remove_picture!
  end
}
