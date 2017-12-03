TargetGroupEvaluationValidator = Dry::Validation.Schema do
  key(:params).schema do
    key(:country_code).required(format?: /\b[A-Za-z]{2}\b/i)
    key(:target_group_id).required(format?: /^\d+$/i)

    key(:locations).each do
      key(:id).required(format?: /^\d+$/i)
      key(:panel_size).required(format?: /^\d+$/i)
    end
  end
end
