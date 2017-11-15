From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Running a FreeBSD bhyve instance on a Ceph cluster
Date: Wed, 15 Nov 2017 18:17:55 +0100
Message-ID: <ff37f99b-2919-4781-0ec1-63a280ab90f6@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17102 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbdKORR7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Nov 2017 12:17:59 -0500
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, "freebsd-virtualization@freebsd.org" <freebsd-virtualization@freebsd.org>

Hi,

Just an info point.

I'm preparing for a lecture tomorrow, and thought why not do an actual 
demo.... Like to be friends with Murphy :)

So after I started the cluster:
	5 jails with 7 OSDs

This what I manually needed to do to boot a memory stick
================
# Start een Bhyve instance

rbd --dest-pool rbd_data --no-progress import memstick.img memstick
rbd-ggate map rbd_data/memstick
# ggate-devvice is available on /dev/ggate1

kldload vmm
kldload nmdm
kldload if_tap
kldload if_bridge
kldload cpuctl
sysctl net.link.tap.up_on_open=1
ifconfig bridge0 create
ifconfig bridge0 addm em0 up
ifconfig
ifconfig tap11 create
ifconfig bridge0 addm tap11
ifconfig tap11 up

# load the GGate disk in bhyve
bhyveload -c /dev/nmdm11A -m 2G -d /dev/ggate1 FB11

# and boot a single from it.
bhyve -H -P -A -c 1 -m 2G -l com1,/dev/nmdm11A -s 0:0,hostbridge -s 
1:0,lpc -s 2:0,virtio-net,tap11 -s 4,ahci-hd,/dev/ggate1 FB11 &
bhyvectl --vm=FB11 --get-stats

# Connect to the VM
cu -l /dev/nmdm11B
=========

And that'll give you a bhyve VM running on an RBD image over ggate.
In the installer I tested reading from the bootdisk:
====
root@:/ # dd if=/dev/ada0 of=/dev/null bs=32M
21+1 records in
21+1 records out
734077952 bytes transferred in 5.306260 secs (138341865 bytes/sec)
====
which is a nice 138Mb/sec.

Hope the demonstration does work out tomorrow.

--WjW


