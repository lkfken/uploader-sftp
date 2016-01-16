module Uploader
  class SFTP
    class Host
      attr_accessor :password, :hostname, :port, :user, :ssh_options

      def initialize(params={})
        @hostname = params.fetch(:hostname)
        @port     = params.fetch(:port, 22)
        @user     = params.fetch(:user)
        @password = params.fetch(:password)
      end

      def to_s
        hostname
      end

      def netssh_options
        {}.tap do |sho|
          sho[:port]     = port if port
          sho[:user]     = user if user
          sho[:password] = password if password
        end.merge(ssh_options || {})
      end
    end

  end
end