# magicavoxel_to_scn

MagicaVoxel model convert to SceneKit scene file tool.

## Require tools

* MagicaVoxel(v0.98)
  * https://ephtracy.github.io/
* Meshlab(v2016.12)
  * http://www.meshlab.net/
* Xcode(v9.0)

## Setup

### Setup Meshlab cli tool(meshlabserver)

```
$ cd /Applications/meshlab.app/Contents/MacOS/ # Meshlab install path
$ install_name_tool -add_rpath "@executable_path/../Frameworks" meshlabserver
# reference: https://github.com/cnr-isti-vclab/meshlab/issues/64
```

### Bundle install

```
$ git clone github.com:henteko/magicavoxel_to_scn.git
$ cd magicavoxel_to_scn
$ bundle install
```

### Export ply file

Export your model ply file from MagicaVoxel.

## Convert

```
$ bundle exec ruby convert.rb /path/to/model.ply
# Create model.scn and model_tex.png
```
