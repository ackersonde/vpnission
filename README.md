![Deploy Transmission under IPSec](https://github.com/ackersonde/vpnission/workflows/Deploy%20Transmission%20under%20IPSec/badge.svg)

# vpnission
Wireguard + Transmission <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Transmission_Icon.svg/64px-Transmission_Icon.svg.png" width="16"> running in one, easy to customize and redeploy docker container.

# Build + Deploy
It's turtles all the way down: as this runs on one of my home raspberry PIs, the Github Action needs to prepare the deployment and execute it on my DigitalOcean droplet. This droplet, in turn, has access to my (IPv6) home network where it ultimately redeploys the correctly configured docker container.

Because of the additional "hops", the [environment variables](https://github.com/ackersonde/vpnission/blob/main/.github/workflows/build.yml#L47) also need to be carefully pushed around for correct operation.

Rebuilding the docker image is necessary if/when my VPN service changes requirements or you need to rework some of the internal bells & whistles (media server requirements, etc.) or it's time to use latest version of OS + software.

Used everyday by my [bender slackbot](https://github.com/ackersonde/bender-slackbot/) after he determines which is the [most performant VPN server](https://github.com/ackersonde/bender-slackbot/blob/master/commands/vpntunnel.go#L159).
