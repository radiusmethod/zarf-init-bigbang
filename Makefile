.PHONY: build

ARCH:=amd64
# renovate: depName=zarf-dev/zarf
ZARF_VERSION:="0.60.0"
# renovate: depName=go-gitea/gitea
GITEA_VERSION:="1.26.2"
# renovate: depName=distribution/distribution
REGISTRY_VERSION:="3.1.1"
# renovate: depName=alpine/socat
PROXY_VERSION:="1.8.0.3"

ZARF_DIR:="zarf"
BUILD_DIR:="build"
KMS_ALIAS:="zarf-init-bigbang"

lint:
	zarf dev lint -a $(ARCH) . \
	--set REGISTRY_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set REGISTRY_IMAGE="ironbank/opensource/docker/registry-v2" \
	--set REGISTRY_IMAGE_TAG=$(REGISTRY_VERSION) \
	--set AGENT_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set AGENT_IMAGE="ironbank/opensource/defenseunicorns/zarf/zarf-agent" \
	--set AGENT_IMAGE_TAG=v$(ZARF_VERSION) \
	--set PROXY_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set PROXY_IMAGE="ironbank/opensource/alpine/socat/socat" \
	--set PROXY_IMAGE_TAG=$(PROXY_VERSION) \
	--set GITEA_IMAGE=registry1.dso.mil/ironbank/opensource/go-gitea/gitea:v$(GITEA_VERSION)

build:
	zarf package create -o $(BUILD_DIR) -a $(ARCH) --confirm . \
	--set REGISTRY_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set REGISTRY_IMAGE="ironbank/opensource/docker/registry-v2" \
	--set REGISTRY_IMAGE_TAG=$(REGISTRY_VERSION) \
	--set AGENT_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set AGENT_IMAGE="ironbank/opensource/defenseunicorns/zarf/zarf-agent" \
	--set AGENT_IMAGE_TAG=v$(ZARF_VERSION) \
	--set PROXY_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set PROXY_IMAGE="ironbank/opensource/alpine/socat/socat" \
	--set PROXY_IMAGE_TAG=$(PROXY_VERSION) \
	--set GITEA_IMAGE=registry1.dso.mil/ironbank/opensource/go-gitea/gitea:v$(GITEA_VERSION)

generate-key-pair:
	cosign generate-key-pair --kms awskms:///alias/$(KMS_ALIAS)
