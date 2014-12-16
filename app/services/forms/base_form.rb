module Forms
 class BaseForm
   def require_params!(params, *keys)
     keys.each {|k| raise ParamMissing.new("Missing param #{k}") unless params[k].present?}
   end

 end
end
