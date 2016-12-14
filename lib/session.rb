require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    rl_cookie = req.cookies['_rails_lite_app']
    if rl_cookie
      @cookie = JSON.parse(rl_cookie)
    else
      @cookie = {}
    end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    json_cookie = JSON.generate(@cookie)
    res.set_cookie('_rails_lite_app', json_cookie)
  end
end
