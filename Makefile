.PHONY: build

ARCH:=amd64
# renovate: depName=zarf-dev/zarf
ZARF_VERSION:="0.45.0"
# renovate: depName=go-gitea/gitea
GITEA_VERSION:="1.23.1"
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
	--set INJECTOR_VERSION="2024-07-22" \
	--set INJECTOR_AMD64_SHASUM="8463bfd66930a4b26c665b51f25e8a32ed5948068bae49987013c89173394478" \
	--set GITEA_IMAGE=registry1.dso.mil/ironbank/opensource/go-gitea/gitea:v$(GITEA_VERSION)

generate-key-pair:
	cosign generate-key-pair --kms awskms:///alias/$(KMS_ALIAS)
