#!/usr/bin/env bash
set -euo pipefail

declare -r NAMESPACE_NAME=pulse
declare -r GLOBAL_IP=10.254.254.1
declare -r NAMESPACE_IP=10.254.254.2

main() {
    case "$*" in
        start|stop)
            PS4='> '
            set -x
            "$*"
            ;;
        *)
            exit 1
            ;;
    esac
}

start() {
    ip netns add "$NAMESPACE_NAME"
    ip -n "$NAMESPACE_NAME" link set lo up
    ip link add "veth-$NAMESPACE_NAME" type veth peer name veth-host
    ip link set veth-host netns "$NAMESPACE_NAME"
    ip address add "$GLOBAL_IP/24" dev "veth-$NAMESPACE_NAME"
    ip -n "$NAMESPACE_NAME" address add "$NAMESPACE_IP/24" dev veth-host
    ip link set "veth-$NAMESPACE_NAME" up
    ip -n "$NAMESPACE_NAME" link set veth-host up
    ip -n "$NAMESPACE_NAME" route add default via "$GLOBAL_IP"
    echo 1 > "/proc/sys/net/ipv4/conf/veth-$NAMESPACE_NAME/forwarding"
}

stop() {
    ip netns delete "$NAMESPACE_NAME" || true
    ip link delete "veth-$NAMESPACE_NAME" || true
}

main "$@"
