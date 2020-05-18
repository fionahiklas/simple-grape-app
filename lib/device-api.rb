require 'grape'
require 'grape-swagger'
require 'rack/cors'

require 'util/lumber'



module ACDeviceSystem

  class DeviceContent < Grape::API
    include Util::Lumber::LumberJack

    @@log = lumber("DeviceContent")

    format :txt
    content_type :txt, 'text/html'

    get :page do
      @@log.debug("/page called")
      @@log.debug("Headers: #{headers}")
      "<html><head><title>Ruby Grape Test App</title></head><body><h1>Test App</h1></body></html>"
    end
  end

  
  class DeviceApi < Grape::API

    include Util::Lumber::LumberJack

    @@log = lumber("DeviceApi")

    format :json

    get :status do
      @@log.debug("/status called")
      @@log.debug("Headers: #{headers}")
      { status: 'OK' }
    end

    get :somestuff do
      @@log.debug("/somestuff called")
      @@log.debug("Headers: #{headers}")
      header 'WWW-Authenticate', 'Negotiate'
      error!('Need to authenticate for somestuff', 401)
    end

  end


  class Root < Grape::API

    # Some of the docs say this is necessary.  Difficult to test locally
    # seems to work without it.
    # use Rack::Cors do
    #   allow do
    #     origins '*'
    #     resource '/swagger_doc', headers: :any, methods: [ :get, :options ]
    #   end
    # end

    mount DeviceApi
    mount DeviceContent
    
    add_swagger_documentation
  end
end

