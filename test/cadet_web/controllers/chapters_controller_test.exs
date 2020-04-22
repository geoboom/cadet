defmodule CadetWeb.ChaptersControllerTest do
  use CadetWeb.ConnCase

  describe "GET /chapter" do
    @tag authenticate: :staff
    test "successful", %{conn: conn} do
      insert(:chapter)

      resp =
        conn
        |> get(build_url())
        |> json_response(200)

      with %{"chapter" => %{"chapterno" => chapterno}} <- resp do
        assert chapterno == 1
      else
        _ -> assert false
      end
    end
  end

  describe "POST /chapter/update/:id" do
    @tag authenticate: :staff
    test "successful", %{conn: conn} do
      insert(:chapter)

      no = Enum.random(1..4)

      resp =
        conn
        |> post(build_url(1), %{
          "chapterno" => no
        })
        |> json_response(200)

      with %{"chapter" => %{"chapterno" => chapterno}} <- resp do
        assert chapterno == no
      else
        _ -> assert false
      end
    end
  end

  defp build_url, do: "/v1/chapter/"
  defp build_url(chapter_id), do: "#{build_url()}update/#{chapter_id}/"
end
