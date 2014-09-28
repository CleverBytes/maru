defmodule Lazymaru.ValidationsTest do
  use ExUnit.Case , async: true
  alias Lazymaru.Validations

  test "regexp" do
    assert Validations.Regexp.validate_param!(:param, "1", ~r"1")
    assert_raise Lazymaru.Exceptions.Validation, fn ->
      Validations.Regexp.validate_param!(:param, "1", ~r"2")
    end
  end

  test "values" do
    assert Validations.Values.validate_param!(:param, 1, [1])
    assert Validations.Values.validate_param!(:param, 1, 1..10)
    assert_raise Lazymaru.Exceptions.Validation, fn ->
      Validations.Values.validate_param!(:param, 1, [])
    end
  end

  test "allow_blank" do
    assert Validations.AllowBlank.validate_param!(:param, nil, true)
    assert Validations.AllowBlank.validate_param!(:param, '',  true)
    assert Validations.AllowBlank.validate_param!(:param, "",  true)
    assert_raise Lazymaru.Exceptions.Validation, fn ->
      Validations.AllowBlank.validate_param!(:param, nil, false)
    end
  end
end
