local options = { window = { documentation = {} } }
local cmp = require("cmp")
local nvconfig = require("nvconfig")

-- change documentation style when transparency is enabled
if nvconfig then
	if nvconfig.base46.transparency then
		options.window.documentation.border = "single"
		options.window.documentation = cmp.config.window.bordered({
			winblend = 20,
			winhighlight = "Normal:CmpDocTransparent,FloatBorder:CmpDocBorder",
		})
		options.window.completion = cmp.config.window.bordered({
			winblend = 20,
			-- winhighlight = "Normal:CmpDocTransparent,FloatBorder:CmpDocBorder",
		})
	end
end

return options
