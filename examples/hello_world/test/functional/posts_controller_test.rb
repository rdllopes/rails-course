require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = FactoryGirl.create(:post)
  end

  test "should get index" do
    get :index
    assert_response 200
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { name: @post.name, text: @post.text }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    result = assigns(:post)
    assert !result.comments.nil?
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    put :update, id: @post, post: { name: @post.name, text: @post.text }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
