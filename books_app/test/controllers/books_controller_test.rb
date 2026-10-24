require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get books_url, headers: admin_headers
    assert_response :success
  end

  test "should get new" do
    get new_book_url, headers: admin_headers
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, headers: admin_headers, params: { book: { author: @book.author, memo: @book.memo, picture: @book.picture, title: @book.title } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book), headers: admin_headers
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book), headers: admin_headers
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), headers: admin_headers, params: { book: { author: @book.author, memo: @book.memo, picture: @book.picture, title: @book.title } }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book), headers: admin_headers
    end

    assert_redirected_to books_url
  end
end
