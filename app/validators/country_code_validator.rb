CountryCodeValidator = Dry::Validation.Schema do
  key(:content).required(format?: /\b[A-Za-z]{2}\b/i)
end
