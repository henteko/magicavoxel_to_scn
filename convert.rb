require 'erb'
require 'tmpdir'
require 'pathname'

input_file = ARGV[0]
if input_file == nil || !File.exist?(input_file) || File.extname(input_file) != '.ply'
  puts 'Please set ply file path'
  puts 'Ex: ruby convert.rb /path/to/model.ply'
  exit
end

file_name =  File.basename(input_file, '.ply')
parent_dir_path = Pathname.new(input_file).dirname.to_s

Dir.mktmpdir do |dir|
  @scale = ARGV[1] || 0.01
  @tex_file_name = "#{file_name}_tex.png"

  erb = File.open('./magicavoxel_to_dae.mlx.erb').read
  mlx_file_path = "#{dir}/magicavoxel_to_dae.mlx"
  File.open(mlx_file_path, "w") do |file|
    file.puts ERB.new(erb).result(binding)
  end

  dae_file_path = "#{dir}/#{file_name}.dae"
  `/Applications/meshlab.app/Contents/MacOS/meshlabserver -i #{input_file} -o #{dae_file_path} -m wt vc vn -s #{mlx_file_path}`
  if $? != 0
    puts 'ERROR: meshlabserver error'
    exit
  end

  scn_file_path = "#{parent_dir_path}/#{file_name}.scn"
  `xcrun scntool --convert #{dae_file_path} --format scn --output #{scn_file_path}`
  if $? != 0
    puts 'ERROR: xcrun error'
    exit
  end

  puts 'Complete!'
  puts "Created #{scn_file_path} and #{parent_dir_path}/#{@tex_file_name}"
end
