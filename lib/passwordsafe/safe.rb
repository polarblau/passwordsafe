

module PasswordSafe
  class Safe
    def initalize filename
    end

    def access_safe filename
      FileUtils.touch filename
    end
  end
end

