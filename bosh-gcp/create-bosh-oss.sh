# CREATE BOSS OSS in GCP

pushd ~/vendors

BOSH_LOG_LEVEL=debug bosh create-env bosh-deployment/bosh.yml \
    --state=~/bosh-ctrl-plane/state.json \
    --vars-store=~/bosh-ctrl-plane/creds.yml \
    -o bosh-deployment/gcp/cpi.yml \
    -o bosh-deployment/jumpbox-user.yml \
    -o bosh-deployment/misc/ntp.yml \
    -o bosh-deployment/uaa.yml \
    -o bosh-deployment/credhub.yml \
    -o bosh-deployment/misc/dns.yml \
    -v director_name=bosh-cp \
    -v internal_cidr=10.0.101.0/26 \
    -v internal_gw=10.0.101.1 \
    -v internal_ip=10.0.101.6 \
    --var-file gcp_credentials_json=~/bosh-ctrl-plane/gcp-bosh-serviceaccount.json \
    -v project_id=$GCP_PROJECT_ID \
    -v zone=$GCP_ZONE \
    -v tags=[boss-cp,grape-ops-manager-external,internal,grape-nat-instance] \
    -v network=grape-pcf-virt-net \
    -v subnetwork=grape-pcf-subnet-infrastructure-asia-south1 \
    -v internal_ntp=[metadata.google.internal] \
    -v internal_dns=[8.8.8.8,8.8.4.4]

popd

