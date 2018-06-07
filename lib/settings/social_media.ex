defmodule Settings.SocialMedia do
  @moduledoc """
  A settings module for social media
  """

  @behaviour Settings.Behaviour

  @type social_networks :: :facebook | :twitter | :pinterest
  @type t :: list(social_networks)

  @social_networks [:facebook, :twitter, :pinterest]
  @media_list Enum.map(@social_networks, &Atom.to_string/1)

  @impl true
  def key() do
    Atom.to_string(__MODULE__)
  end

  @impl true
  def init() do
    []
  end

  @impl true
  def decoder(model) do
  end

  # def put_social_media(%__MODULE__{} = model, media) when media == [] do
  #   {:ok, media}
  #   |> update_social_media(model)
  # end

  # def put_social_media(%__MODULE__{} = model, media) do
  #   media
  #   |> is_in_social_media?()
  #   |> media_to_atom()
  #   |> update_social_media(model)
  # end

  # defp is_in_social_media?(media) do
  #   Enum.reduce_while(
  #     media,
  #     nil,
  #     fn
  #       (x, _acc) when x in @media_list ->
  #         {:cont, {:ok, media}}
  #       (x, _acc) ->
  #         {:halt, {:error, "'#{x}' - invalid social network name."}}
  #     end
  #   )
  # end

  # def media_to_atom({:ok, media}) do
  #   {:ok, Enum.map(media, &media/1)}
  # end

  # def media_to_atom(err) do
  #   err
  # end

  # defp update_social_media({:ok, media}, %__MODULE__{} = model) do
  #   %{model | social_media: media}
  # end

  # defp update_social_media({:error, msg}, %__MODULE__{} = model) do
  #   Logger.error(fn -> msg end)
  #   model
  # end

  # defp media("facebook"), do: :facebook
  # defp media("twitter"), do: :twitter
  # defp media("pinterest"), do: :pinterest
end
