From: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>
Subject: Re: Ceph performance improvement / journal on block-dev
Date: Wed, 22 Aug 2012 21:12:34 +0200
Message-ID: <20120822191234.GA21826@oder.kd-bie.de>
References: <50349E62.90405@ledeuns.net>
 <CADvuQRHQmK991u8NO3YH5qifTz-bj87YUfh2xmGRLrMVNZFGQw@mail.gmail.com>
 <5035077D.8090707@ledeuns.net>
 <CADvuQRFk8ARM-ex1tjr-uf1jzrfxOXeTnQrvkVh222NJZ5Zw7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:53332 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627Ab2HVTNh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 15:13:37 -0400
Content-Disposition: inline
In-Reply-To: <CADvuQRFk8ARM-ex1tjr-uf1jzrfxOXeTnQrvkVh222NJZ5Zw7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Denis Fondras <ceph@ledeuns.net>, "Dieter Kasper (KD)" <d.kasper@kabelmail.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 22, 2012 at 06:29:12PM +0200, Tommi Virtanen wrote:
(...)
> 
> Your journal is a file on a btrfs partition. That is probably a bad
> idea for performance. I'd recommend partitioning the drive and using
> partitions as journals directly.

Hi Tommi,

can you please teach me how to use the right parameter(s) to realize 'journal on block-dev' ?

It looks like something is not OK during 'mkcephfs -a -c /etc/ceph/ceph.conf --mkbtrfs'
(see below)

Regards,
-Dieter


e.g.
---snip---
modprobe -v brd rd_nr=6 rd_size=10000000        # 6x 10G RAM DISK

/etc/ceph/ceph.conf
--
[global]
        auth supported = none

        # set log file
        log file = /ceph/log/$name.log
        log_to_syslog = true        # uncomment this line to log to syslog

        # set up pid files
        pid file = /var/run/ceph/$name.pid

[mon]  
        mon data = /ceph/$name
	debug optracker = 0

[mon.alpha]
	host = 127.0.0.1
	mon addr = 127.0.0.1:6789

[mds]
	debug optracker = 0

[mds.0]
        host = 127.0.0.1

[osd]
	osd data = /data/$name

[osd.0]
	host = 127.0.0.1
        btrfs devs  = /dev/ram0
	osd journal = /dev/ram3

[osd.1]
	host = 127.0.0.1
        btrfs devs  = /dev/ram1
	osd journal = /dev/ram4

[osd.2]
	host = 127.0.0.1
        btrfs devs  = /dev/ram2
	osd journal = /dev/ram5
--

root # mkcephfs -a -c /etc/ceph/ceph.conf --mkbtrfs
temp dir is /tmp/mkcephfs.wzARGSpFB6
preparing monmap in /tmp/mkcephfs.wzARGSpFB6/monmap
/usr/bin/monmaptool --create --clobber --add alpha 127.0.0.1:6789 --print /tmp/mkcephfs.wzARGSpFB6/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.wzARGSpFB6/monmap
/usr/bin/monmaptool: generated fsid 40b997ea-387a-4deb-9a30-805cd076a0de
epoch 0
fsid 40b997ea-387a-4deb-9a30-805cd076a0de
last_changed 2012-08-22 21:04:00.553972
created 2012-08-22 21:04:00.553972
0: 127.0.0.1:6789/0 mon.alpha
/usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.wzARGSpFB6/monmap (1 monitors)
=== osd.0 === 
pushing conf and monmap to 127.0.0.1:/tmp/mkfs.ceph.11005
umount: /data/osd.0: not mounted
umount: /dev/ram0: not mounted

Btrfs v0.19.1+

ATTENTION:

mkfs.btrfs is not intended to be used directly. Please use the
YaST partitioner to create and manage btrfs filesystems to be
in a supported state on SUSE Linux Enterprise systems.

fs created label (null) on /dev/ram0
	nodesize 4096 leafsize 4096 sectorsize 4096 size 9.54GiB
Scanning for Btrfs filesystems
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
2012-08-22 21:04:01.519073 7fb475e8b780 -1 journal check: ondisk fsid 8b18c558-8b40-4b07-aa66-61fecb4dd89d doesn't match expected ee0b8bf1-dd4a-459e-a218-3f590f9a8c16, invalid (someone else's?) journal
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
2012-08-22 21:04:01.923505 7fb475e8b780 -1 filestore(/data/osd.0) could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
2012-08-22 21:04:01.937429 7fb475e8b780 -1 created object store /data/osd.0 journal /dev/ram3 for osd.0 fsid 40b997ea-387a-4deb-9a30-805cd076a0de
creating private key for osd.0 keyring /data/osd.0/keyring
creating /data/osd.0/keyring
collecting osd.0 key
=== osd.1 === 
pushing conf and monmap to 127.0.0.1:/tmp/mkfs.ceph.11005
umount: /data/osd.1: not mounted
(...)


