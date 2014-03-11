defmodule EmanatioTest do
  use ExUnit.Case

  alias Emanatio.Stream, as: S

  test "simple stream" do
    s = S.new
    S.push(s, 10)
    assert {10, s} == S.get s
    s |> S.push(11) |> S.push(12)
    assert {12, s} == S.get s
  end

  test "stream foreach" do
    s = S.new
    me = self

    s |> S.foreach(fn x -> send(me, x) end)
    s |> S.push(1) |> S.push(2) |> S.push(3)

    assert_receive 1
    assert_receive 2
    assert_receive 3

  end

end
