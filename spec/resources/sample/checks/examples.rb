define :simple do
  execute do
    ok "we're good"
  end
end

define :warning do
  execute do
    warn "careful there"
  end
end

define :critical do
  execute do
    critical "uhh ohh"
  end
end

define :error do
  execute do
    raise 'booboo'
  end
end


define :simple_arg do
  attribute :name
  execute do
    params[:name]
  end
end

define :default_arg do
  attribute :name, :default => 'Bill'
  execute do
    params[:name]
  end
end

define :typed_arg do
  attribute :age, :kind_of => Fixnum
  execute do
    params[:age].to_s
  end
end

define :bad_gem do
  require_gem 'uhhohh'
  execute do
    '.'
  end
end

define :just_string do
  execute do
    'hello'
  end
end

define :duplicate do
  attribute :name, :default => 'Joe'
  execute do
    params[:name]
  end
end
