Pod::Spec.new do |s|
    s.name             = 'LYComponents'
    s.version          = '0.1.0'
    s.summary          = 'UI组件集合'

    s.description      = <<-DESC
        基础UI组件总结
    DESC

    s.homepage         = 'https://github.com/lvyang/LYComponents'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lvyang' => 'lvyang7989@126.com' }
    s.source           = { :git => 'https://github.com/lvyang/LYComponents.git', :tag => s.version.to_s }

    s.ios.deployment_target = '8.0'

    # 基础UI组件模块
    s.subspec 'LYBaseComponents' do |baseComponents|
        baseComponents.source_files = 'LYComponents/Classes/LYBaseComponents/**/*'
        baseComponents.public_header_files = 'LYComponents/Classes/LYBaseComponents/**/*.h'

        baseComponents.dependency 'MBProgressHUD', '~> 0.9.1'
        baseComponents.dependency 'SDWebImage', '~>3.8'
    end

end

