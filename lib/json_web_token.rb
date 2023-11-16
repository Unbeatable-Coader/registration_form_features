class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base. to_s


    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp]= exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
      decoded_token = JWT.decode(token, SECRET_KEY).first
      HashWithIndifferentAccess.new(decoded_token)
    rescue JWT::DecodeError => e
      # Handle decoding errors, e.g., return nil or raise an exception
      raise e
    end
end