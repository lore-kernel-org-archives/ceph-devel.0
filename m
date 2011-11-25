From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Fri, 25 Nov 2011 17:53:15 +0100
Message-ID: <4366451.BU1d1YAr76@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:35917 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab1KYRA7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Nov 2011 12:00:59 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 8C88D10C866
	for <ceph-devel@vger.kernel.org>; Fri, 25 Nov 2011 17:53:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When trying to mount a Ceph filesystem with "mount.ceph 10.3.1.33:6789:/ /mnt", 
the command hangs for several minutes and then fails with the message 

mount error 5 = Input/output error

Background:

I'm trying to set up a small 3-machine Ceph cluster, to be used for network-
transparent block- and file storage for Qemu server virtualization. This is the 
first time I'm doing anything at all with Ceph, so many of the concepts are 
still new and a bit confusing to me.

My plan was to set up each of the three machines equally with one mon, one osd 
and one mds, and to add more servers, or replace the existing ones with bigger 
machines, as need arises.

So far, I have only started with one of the three servers, to get at least a 
basic configuration working and to get some feel for the system and its 
components, before adding the other two.

The machines are all running a basic installation of CentOS 6. What I did so 
far on the first machine was:

- Build a newer kernel (3.1.1) with built-in support for btrfs and ceph, 
reboot with it
- Prepare two larger empty partitions (sda5 and sdb5) for data storage
- Download and unpack ceph-0.38.tar.gz, cd ceph-0.38
- Run ./configure
- Repeat numerous times while installing one dependency after the other, 
eventually ending up with ./configure --without-fuse --without-tcmalloc
- make && make install
- Copy src/init-ceph to /etc/init.d/
- Create /usr/local/etc/ceph/ceph.conf with this content:

[global]
        max open files = 131072
        log file = /var/log/ceph/$name.log
        log_to_syslog = true
        pid file = /var/run/ceph/$name.pid

[mon]
        mon data = /mondata/$name

[mon.ceph1]
        host = ceph1
        mon addr = 10.3.1.33:6789

[mds]
        keyring = /cephxdata/keyring.$name

[mds.alpha]
        host = ceph1

[osd]
        osd data = /data/$name
        osd journal = /data/$name/journal
        osd journal size = 1000 ; journal size, in megabytes

[osd.0]
        host = ceph1
        btrfs devs = /dev/sda5 /dev/sdb5

(Slightly adjusted from src/sample.ceph.conf, comments removed for brevity)

- Run mkcephfs -c /usr/local/etc/ceph/ceph.conf --mkbtrfs -a -k \
/usr/local/etc/ceph/keyring.bin
- Run /etc/init.d/ceph start

After these steps, I tried to mount the ceph filesystem (on the same machine) 
with "mount.ceph 10.3.1.33:6789:/ /mnt" and got the aforementioned error.

The only thing that happens in the logs when I try to mount is this one line 
in mon log:
2011-11-25 17:26:53.216745 7f0ee75df700 -- 10.3.1.33:6789/0 >> 
10.3.1.33:0/1719960241 pipe(0x7f0ee0001320 sd=12 pgs=0 cs=0 l=0).accept peer 
addr is really 10.3.1.33:0/1719960241 (socket is 10.3.1.33:46908/0)

The osd and mds logs do not show any activity at that point.

Does anybody have any idea what could be going wrong here?

	Guido
