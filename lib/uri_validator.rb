class UriValidator < ActiveModel::EachValidator
  IPv4_PART = /\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]/  # 0-255
  REGEXP = %r{
    \A
    https?://                                                    # http:// or https://
    ([^\s:@]+:[^\s:@]*@)?                                        # optional username:pw@
    ( (([^\W_]+\.)*xn--)?[^\W_]+([-.][^\W_]+)*\.[a-z]{2,6}\.? |  # domain (including Punycode/IDN)...
        #{IPv4_PART}(\.#{IPv4_PART}){3} )                        # or IPv4
    (:\d{1,5})?                                                  # optional port
    ([/?]\S*)?                                                   # optional /whatever or ?whatever
    \Z
  }iux
  
  def validate_each(record, attribute, value)
    if value !~ REGEXP
      record.errors[attribute] << (options[:message] || 'is malformed')
    end
  end
end