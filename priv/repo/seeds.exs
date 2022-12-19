alias BookSearch.Authors
alias BookSearch.Authors.Author
alias BookSearch.Books
alias BookSearch.Books.Book
alias BookSearch.Repo

# Create an author without any books
case Repo.get_by(Author, name: "Andrew Rowe") do
  %Author{} = author ->
    IO.inspect(author.name, label: "Author Already Created")

  nil ->
    Authors.create_author(%{name: "Andrew Rowe"})
end

# Create a book without an author.
case Repo.get_by(Book, title: "Beowulf") do
  %Book{} = book ->
    IO.inspect(book.title, label: "Book Already Created")

  nil ->
    Books.create_book(%{title: "Beowulf"})
end

# Create an author with a book.
{:ok, author} =
  case Repo.get_by(Author, name: "Patrick Rothfuss") do
    %Author{} = author ->
      IO.inspect(author.name, label: "Author Already Created")
      {:ok, author}

    nil ->
      Authors.create_author(%{name: "Patrick Rothfuss"})
  end

case Repo.get_by(Book, title: "Name of the Wind") do
  %Book{} = book ->
    IO.inspect(book.title, label: "Book Already Created")

  nil ->
    %Book{}
    |> Book.changeset(%{title: "Name of the Wind"})
    |> Ecto.Changeset.put_assoc(:author, author)
    |> Repo.insert!()
end
