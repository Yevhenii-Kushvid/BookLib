json.array!(@books) do |book|
  json.extract! book, :id, :name, :author, :picture, :context, :is_draft
  json.url book_url(book, format: :json)
end
