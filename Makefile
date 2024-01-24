.PHONY: build

ARCH:=amd64
# renovate: depName=go-gitea/gitea
GITEA_VERSION:="1.21.3"
# renovate: depNameTemplate=registry datasourceTemplate=docker
REGISTRY_VERSION:="2.8.3"
# renovate: depName=defenseunicorns/zarf
ZARF_VERSION:="0.32.1"

ZARF_DIR:="zarf"
BUILD_DIR:="build"
KMS_ALIAS:="zarf-init-bigbang"

build:
	zarf package create -o $(BUILD_DIR) -a $(ARCH) --confirm .

generate-key-pair:
	cosign generate-key-pair --kms awskms:///alias/$(KMS_ALIAS)
