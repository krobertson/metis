define :duplicate do
  attribute :name, :default => 'Jane'
  execute do
    params[:name]
  end
end
