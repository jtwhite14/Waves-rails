# Modifed from original found here: http://stackoverflow.com/a/19364561/1084109
  
# in lib/retryable.rb
module Retryable
 
  # Options:
  # * :tries - Number of tries to perform. Defaults to 1. If you want to retry once you must set tries to 2.
  # * :on - The Exception on which a retry will be performed. Defaults to Exception, which retries on any Exception.
  # * :log - The log level to log the exception. Defaults to nil.
  #
  # If you work with something like ActiveRecord#find_or_create_by_foo, remember to put that call in a uncached { } block. That
  # forces subsequent finds to hit the database again.
  #
  # Example
  # =======
  #   retryable(:tries => 2, :on => OpenURI::HTTPError) do
  #     # your code here
  #   end
  #
  def retryable(options = {}, &block)
    opts = { :tries => 1, :on => StandardError }.merge(options)
 
    retry_exception, retries = opts[:on], opts[:tries]
 
    begin
      yield
    rescue retry_exception => e
      logger.send(opts[:log], e.message) if opts[:log]
      if (retries -= 1) > 0
        retry
      else
        raise e
      end
    end
  end
end