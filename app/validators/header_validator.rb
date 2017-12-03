module HeaderValidator

  def self.included(base)
    base.class_eval do
      include InstanceMethods

      before_action :validate_accept_header_structure
      before_action :validate_accept_header_format
      before_action :validate_media_type, unless: -> { request.get? }
    end
  end

  module InstanceMethods

    private

      def validate_accept_header_structure
        begin
          media_types
        rescue HTTP::Accept::ParseError
          msg = 'Accept header malformed'
          respond_with_error msg: msg, status: 400
        end
      end

      def validate_accept_header_format
        if !request.headers['Accept'].include?('application/vnd.api.v1+json')
          msg = "Accept header does not include 'application/vnd.api.v1+json'"
          respond_with_error msg: msg, status: 415
        end
      end

      def validate_media_type
        if request.headers['Content-Type'] != 'application/vnd.api.v1+json'
          msg = "Content-Type header set to 'application/vnd.api.v1+json' required"
          respond_with_error msg: msg, status: 415
        end
      end

      def media_types
        HTTP::Accept::MediaTypes.parse(request.headers.fetch('Accept', ''))
      end
  end
end
