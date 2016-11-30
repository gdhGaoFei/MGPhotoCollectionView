Pod::Spec.new do |s|

s.name = 'MGPhotoCollectionView'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'A MGPhotoCollectionView view on iOS.'
s.homepage = 'https://github.com/gdhGaoFei/MGPhotoCollectionView'
s.authors = { 'GaoFei' => 'gdhgaofei@163.com' }
s.source = { :git => 'https://github.com/gdhGaoFei/MGPhotoCollectionView.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'MGPhotoCollectionView", "*.{h,m}'
s.resources = 'MGPhotoCollectionView/images/*.png'

s.dependency "SDWebImage"

end
