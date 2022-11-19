PROJECTNAME=$(shell basename "$(PWD)")
# MAKEFLAGS += --silent
INSTALL_PATH="./build/bin"
GO_EXEC_PATH="/usr/local/go/bin/go"
NFPM_EXEC_PATH="/usr/local/go/bin/nfpm"
PROGRAM_FILE=""
BUILD_NAME="godeploy-demo"
INSTALL_USERNAME=`whoami`
GOOS=linux
GOARCH=amd64
PACKAGE_VERSION="1.0.0"
# GO111MODULE=on
COMPILEDAEMON_PATH="CompileDaemon"

## build-install: build the go binary and install it $(INSTALL_PATH) 
build-install:
	${shell mkdir -p $(INSTALL_PATH)}
	${shell  chown -R $(INSTALL_USERNAME):$(INSTALL_USERNAME) $(INSTALL_PATH)}
	@echo "Creating $(INSTALL_PATH) with user:group $(INSTALL_USERNAME) using gopath $(GO_EXEC_PATH)"
	GOOS=$(GOOS) GOARCH=$(GOARCH)  GO111MODULE=$(GO111MODULE)  $(GO_EXEC_PATH) build -o "$(INSTALL_PATH)/$(BUILD_NAME)"
	@echo "Created build on $(INSTALL_PATH)/$(BUILD_NAME)"

## clean: clean the build
clean:
	rm -rf "$(INSTALL_PATH)/$(BUILD_NAME)"

## dev-run: Runs the application in development mode using compile daemon and live reload binary
dev-run:
	@echo "Running code in development mode"
	@echo "Creating $(INSTALL_PATH) with user:group $(INSTALL_USERNAME)  using gopath $(GO_EXEC_PATH)"
	$(COMPILEDAEMON_PATH) -color=true -build="make build-install" -include=Makefile -directory=./ --command "$(INSTALL_PATH)/$(BUILD_NAME) -d -e test"

## stag-run: Runs the application in staging mode using compile daemon and live reload binary
stag-run:
	@echo "Running binary in staging mode"
	@echo "Creating $(INSTALL_PATH) with user:group $(INSTALL_USERNAME)  using gopath $(GO_EXEC_PATH)"
	$(COMPILEDAEMON_PATH) -color=true -build="make build-install" -include=Makefile -directory=./ --command "$(INSTALL_PATH)/$(BUILD_NAME) -d -e stag"

## create-rpm: Creates rpm of this application
create-rpm:
	@echo "Will create an RPM"
	make build-install
	mkdir -p build/rpms
	cd build/ && PACKAGE_VERSION=$(PACKAGE_VERSION) $(NFPM_EXEC_PATH) pkg --packager rpm --target rpms 
	

## create-deb: Creates rpm of this application
create-deb:
	@echo "Will create Deb"
	make build-install
	mkdir -p build/debs
	cd build/ && PACKAGE_VERSION=$(PACKAGE_VERSION) $(NFPM_EXEC_PATH) pkg --packager deb --target debs

help: Makefile
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
