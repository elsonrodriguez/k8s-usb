# Kubernetes USB Installer

## Download required binaries

From any linux system, insert the usb key and run this command

```
/path/to/usbkey/download-binaries.sh
```

## Master Installation

Insert key into master and run this command

```
/path/to/usbkey/install-master.sh
```

## Node Installation

To add a node to your cluster, insert the key and run this command

```
/path/to/usbkey/install-node.sh
```

It will default to hitting `master` by DNS name, if you do not have DNS setup as such:

```
/path/to/usbkey/install-node.sh 10.10.10.10
```

Where `10.10.10.10` is the actual IP of the master.
