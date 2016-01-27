module Uploader
  class SFTP
    class Host
      attr_accessor :password, :port, :user, :ssh_options
      attr_reader :hostname

      def initialize(params={})
        @hostname = params.fetch(:hostname)
        @port     = params.fetch(:port, 22)
        @user     = params.fetch(:user, nil)
        @password = params.fetch(:password, nil)
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