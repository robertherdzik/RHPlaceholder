Pod::Spec.new do |s|
  s.name         = "RHPlaceholder"
  s.version      = "0.0.5"
  s.summary      = "Because tradicional loading view like UIActivityIndicatorView or similar one are noo longer so trendy (Facebook or Instagram apps are moving away from these approaches), I decided to create very simple library which will give you oportunity to have Facebook or Instagram 'view loading state' in your great project without big effort ❗️🍕"
  s.description  = "Because tradicional loading view like UIActivityIndicatorView or similar one are noo longer so trendy (Facebook or Instagram apps are moving away from these approaches), I decided to create very simple library which will give you oportunity to have Facebook or Instagram 'view loading state' in your great project without big effort ❗️🍕Because tradicional loading view like UIActivityIndicatorView or similar one are noo longer so trendy (Facebook or Instagram apps are moving away from these approaches), I decided to create very simple library which will give you oportunity to have Facebook or Instagram 'view loading state' in your great project without big effort ❗️🍕"
  s.homepage     = "https://github.com/robertherdzik/RHPlaceholder"
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
   s.license      = { :type => "MIT", :file => "LICENCE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Robert Herdzik" => "robert.herdzik@yahoo.com" }
  s.social_media_url   = "https://twitter.com/Roherdzik"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source = {
  :git => "https://github.com/robertherdzik/RHPlaceholder.git",
  :tag => s.version.to_s
  }

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "Classes", "RHPlaceholder/**/*.{swift}"

end
