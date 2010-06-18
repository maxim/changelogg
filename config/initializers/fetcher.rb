if Rails.env.test?
  FETCHER = Fetcher::Fake
else
  FETCHER = Fetcher::Github
end