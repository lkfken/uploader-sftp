require 'logger'
require 'net/sftp'

require_relative '../core_ext/hash'

require_relative 'sftp/version'
require_relative 'sftp/host'

module Uploader
  class SFTP
    attr_reader :host, :directory, :logger

    def initialize(params={})
      @logger    = params.fetch(:logger, Logger.new(STDOUT))
      @host      = params.fetch(:host)
      @directory = params.fetch(:directory, '.')
    end

    def hostname
      host.hostname
    end

    def port
      host.port
    end

    def user
      host.user
    end

    def password
      host.password
    end

    def send_files!(entries)
      logger.debug('SFTP session started.')
      Net::SFTP.start(hostname, user, port: port, password: password, auth_methods: %w[password]) do |sftp|
        logger.debug(["connected to host #{host}", "directory: #{directory}"].join(', '))
        entries.each do |entry|
          filename = Pathname(entry).basename
          sftp.upload!(entry, File.join(directory, filename))
          logger.debug "#{entry} sent."
        end
      end
      logger.debug('SFTP session ended successfully.')
    rescue => ex
      logger.fatal ex.class
      logger.fatal ex.message
      logger.fatal 'SFTP session failed!'
      raise ex
    end
  end
end
