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

build:
	cd $(ZARF_DIR) && \
	zarf package create --flavor=bigbang -o $(BUILD_DIR) -a $(ARCH) --confirm . \
	--set REGISTRY_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set REGISTRY_IMAGE="ironbank/opensource/docker/registry-v2" \
	--set REGISTRY_IMAGE_TAG=$(REGISTRY_VERSION) \
	--set AGENT_IMAGE_DOMAIN="registry1.dso.mil/" \
	--set AGENT_IMAGE="ironbank/opensource/defenseunicorns/zarf/zarf-agent" \
	--set AGENT_IMAGE_TAG=v$(ZARF_VERSION) \
	--set GITEA_IMAGE=registry1.dso.mil/ironbank/opensource/go-gitea/gitea:v$(GITEA_VERSION)
