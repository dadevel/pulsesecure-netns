# pulsesecure-netns

Pulse Secure VPN in a Linux network namespace.

# Setup

1. Install the Pulse Secure client from [AUR](https://aur.archlinux.org/packages/pulse-secure).
2. Install the Systemd services and accompanying files.

    ~~~ bash
    sudo ./setup.sh
    ~~~

3. Configure NAT for `veth-pulse` in your firewall. For example see [nftables.conf](./nftables.conf).
4. Establish your VPN connection.

    ~~~ bash
    ./connect.sh
    ~~~

# Usage

Open a shell in the netns.

~~~ bash
sudo ip netns exec pulse sudo -u "$USER" "$SHELL" -i
~~~

Launch a browser in the netns (you can't open the same profile in and outside a namespace).

~~~ bash
sudo ip netns exec pulse sudo -u "$USER" firefox -P
~~~

Attach a container to the netns.

~~~ bash
sudo podman run -it --rm --network ns:/run/netns/pulse docker.io/library/alpine
~~~
