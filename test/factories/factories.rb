FactoryBot.define do
  factory :customer, class: Customer do
    first_name { "John" }
    last_name  { "Doe" }
  end

  factory :customer_book  do 
    status { "checked out" }
  end

  factory :book do 
    title { "A Fancy Title" }
    isbn { "ABC1112233" }
    author { "Jane Smith" }
    category { "Fiction" }
  end
  
  factory :audio_book, class: AudioBook do 
    title { "A Fancy Audio Book" }
    isbn { "XXXX144444" }
    author { "Jane Smith" }
    category { "Non Fiction" }
  end

  factory :physical_book, class: PhysicalBook do 
    title { "A Physical Books" }
    isbn { "ZZZZ9999" }
    author { "Jane Hero" }
    category { "Non Fiction" }
  end
end
