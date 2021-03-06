require "test_helper"

class ProfilesHelperTest < ActionView::TestCase
  test "full_name combines first name and last name" do
    assert_equal(full_name(profiles(:sparse)), "Sparse No'Info")
  end

  test "full_name shows nickname and last name and parenthesizes first name" do
    assert_equal(full_name(profiles(:frog)), "Froggy Green (Frog)")
  end

  test "avatar_url gives the cached avatar url if present" do
    assert_equal(avatar_url(profiles(:frog)), "https://images.foo.com/froggo.jpg")
  end

  test "avatar_url gives the default avatar url if the cached isn't there" do
    assert_equal(avatar_url(profiles(:sparse)), image_url("default_avatar.jpg"))
  end

  test "normalize_line_breaks should change all repeated line breaks to 2 breaks" do
    assert_equal(
      normalize_line_breaks("foo\n\n\n\nbar\nbaz\n\nzing"),
      "foo\n\nbar\n\nbaz\n\nzing"
    )
  end

  test "normalize_line_breaks changes CRLF line breaks to LF" do
    assert_equal(
      normalize_line_breaks("foo\r\n\r\n\r\nbar\r\nbaz\r\n\r\nzing"),
      "foo\n\nbar\n\nbaz\n\nzing"
    )
  end

  test "normalize_line_breaks removes whitespace around line breaks" do
    assert_equal(
      normalize_line_breaks("foo  \n   \n\t\nbar\n baz\t\n\t\n\tzing"),
      "foo\n\nbar\n\nbaz\n\nzing"
    )
  end

  test "normalize_line_breaks removes whitespace around the text" do
    assert_equal(
      normalize_line_breaks(" \n  \tfoo \n\n\n"),
      "foo"
    )
  end

  test "normalize_line_breaks should do nothing when there are no line breaks" do
    assert_equal(normalize_line_breaks("foo bar baz zing"), "foo bar baz zing")
    assert_equal(normalize_line_breaks(""), "")
  end
end
