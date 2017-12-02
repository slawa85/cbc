CountryCodeValidation = Dry::Validation.Schema do
  key(:content).required(format?: /\b[A-Za-z]{2,3}\b/i)
end
