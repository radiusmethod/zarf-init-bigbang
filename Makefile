.PHONY: build

ARCH:=amd64
# renovate: depName=defenseunicorns/zarf
ZARF_VERSION:="0.32.4"
# renovate: depName=go-gitea/gitea
GITEA_VERSION:="1.21.7"
# renovate: depName=distribution/distribution
REGISTRY_VERSION:="2.8.3"

ZARF_DIR:="zarf"
BUILD_DIR:="build"
KMS_ALIAS:="zarf-init-bigbang"

build:
	zarf package create -o $(BUILD_DIR) -a $(ARCH) --confirm . \
	--set REGISTRY_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set REGISTRY_IMAGE="ironbank/opensource/docker/registry-v2" \
	--set REGISTRY_IMAGE_TAG=$(REGISTRY_VERSION) \
	--set AGENT_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set AGENT_IMAGE="ironbank/opensource/defenseunicorns/zarf/zarf-agent" \
	--set AGENT_IMAGE_TAG=v$(ZARF_VERSION) \
	--set INJECTOR_VERSION="2023-08-02" \
	--set INJECTOR_AMD64_SHASUM="91de0768855ee2606a4f85a92bb480ff3a14ca205fd8d05eb397c18e15aa0247" \
	--set GITEA_IMAGE=registry1.dso.mil/ironbank/opensource/go-gitea/gitea:v$(GITEA_VERSION)

generate-key-pair:
	cosign generate-key-pair --kms awskms:///alias/$(KMS_ALIAS)
