set -x

if [ -z "$1" ] || [ -z "$2" ]; then
    echo $0: usage: SELinuxGame/create_box_and_new_version.sh scenario_name version
    exit 1
fi

scenario_name=$1
version=$2

# create a box
curl https://atlas.hashicorp.com/api/v1/boxes \
    -X POST \
    -H "X-Atlas-Token: $ATLAS_TOKEN" \
    -d box[name]="$scenario_name" \
    -d box[is_private]=false

# create a version of the box
curl https://atlas.hashicorp.com/api/v1/box/selinuxgame/$scenario_name/versions \
    -X POST \
    -H "X-Atlas-Token: $ATLAS_TOKEN" \
    -d version[version]="$version"


# create libvirt provider for version
curl https://atlas.hashicorp.com/api/v1/box/selinuxgame/$scenario_name/version/$version/providers \
    -X POST \
    -H "X-Atlas-Token: $ATLAS_TOKEN" \
    -d provider[name]="libvirt"

# create upload request
upload_path=$(curl https://atlas.hashicorp.com/api/v1/box/selinuxgame/$scenario_name/version/$version/provider/libvirt/upload \
	-H "X-Atlas-Token: $ATLAS_TOKEN" | python3 -c "import sys, json; print(json.load(sys.stdin)['upload_path'])")

# upload box to atlas
curl -X PUT --upload-file $scenario_name.box $upload_path

# release the version
curl https://atlas.hashicorp.com/api/v1/box/selinuxgame/$scenario_name/version/$version/release \
    -X PUT \
    -H "X-Atlas-Token: $ATLAS_TOKEN"
