#!/usr/bin/env sh

mc alias set myminio https://localhost:9000 minioadmin minioadmin --insecure
mc mb --with-lock --with-versioning myminio/vSphereDev --insecure
mc mb --with-lock --with-versioning myminio/vSphereTest --insecure
mc mb --with-lock --with-versioning myminio/vSphereUat --insecure
mc mb --with-lock --with-versioning myminio/vSphereProd --insecure