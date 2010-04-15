From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: unstable branch won't come online
Date: Thu, 15 Apr 2010 23:11:07 +0200
Message-ID: <1271365867.3520.7.camel@wido-laptop.pcextreme.nl>
References: <1271354193.3520.6.camel@wido-laptop.pcextreme.nl>
	 <Pine.LNX.4.64.1004151101460.15369@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-QAUsw6m7uNxRibZGTPzz"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:42154 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab0DOVLK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 17:11:10 -0400
In-Reply-To: <Pine.LNX.4.64.1004151101460.15369@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--=-QAUsw6m7uNxRibZGTPzz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Sage,

I tried "debug filestore = 20" but it didn't seem to change much, see
that attached log.

I also attach my ceph.conf, any errors on my side?

-- 
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support België: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
Fax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Thu, 2010-04-15 at 18:02 +0000, Sage Weil wrote:
> debug filestore = 20

--=-QAUsw6m7uNxRibZGTPzz
Content-Type: application/x-extension-conf; name="ceph.conf"
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: 7bit

[global]
       pid file = /var/run/ceph/$name.pid
       debug ms = 1
       debug filestore = 20

[mon]
       mon data = /srv/ceph/mon

[mon0]
       host = ceph01
       mon addr = 192.168.6.209:6789

[mon1]
       host = ceph02
       mon addr = 192.168.6.210:6789

[mds]

[mds0]
       host = ceph01

[mds1]
       host = ceph02

[osd]
       sudo = true
       osd data = /srv/ceph/osd
       debug filestore = 20

[osd1]
       host = osd1
       btrfs devs = /dev/sda6
       debug filestore = 20

[osd2]
       host = osd2
       btrfs devs = /dev/sda6

[osd3]
       host = osd3
       btrfs devs = /dev/sda6

[osd4]
      host = osd4
      btrfs devs = /dev/sda6

[osd5]
     host = osd5
     btrfs devs = /dev/sda6

[group everyone]
       addr = 192.168.6.0/24

[mount /]
       allow = %everyone

[mount /mail]
       allow = %everyone

mount [/vhosting]
       allow = %everyone


--=-QAUsw6m7uNxRibZGTPzz
Content-Disposition: attachment; filename="osd1.log"
Content-Type: text/x-log; name="osd1.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

10.04.15 23:09:11.103346 --- opened log /var/log/ceph/osd1.12962 ---
ceph version 0.19.1 (198d7106818e91c655740f3a41c2390af36e069e)
10.04.15 23:09:11.103496 7fe91e1ce710 ---- renamed symlink /var/log/ceph/osd1 -> /var/log/ceph/osd1.0 ----
10.04.15 23:09:11.103533 7fe91e1ce710 ---- created symlink /var/log/ceph/osd1 -> osd1.12962 ----
10.04.15 23:09:11.103891 7fe91e1ce710 -- 0.0.0.0:6800/12962 accepter.bind ms_addr is 0.0.0.0:6800/12962 need_addr=1
10.04.15 23:09:11.103944 7fe91e1ce710 -- 0.0.0.0:6801/12962 accepter.bind ms_addr is 0.0.0.0:6801/12962 need_addr=1
10.04.15 23:09:11.104084 7fe91e1ce710 filestore(/srv/ceph/osd) test_mount basedir /srv/ceph/osd journal 
10.04.15 23:09:11.104113 7fe91e1ce710 -- 0.0.0.0:6800/12962 messenger.start
10.04.15 23:09:11.104136 7fe91e1ce710 -- 0.0.0.0:6800/12962 messenger.start daemonizing
10.04.15 23:09:11.104598 7fe91e1ce710 ---- renamed log /var/log/ceph/osd1.12962 -> /var/log/ceph/osd1.12963 ----
10.04.15 23:09:11.104818 7fe91e1ce710 -- 0.0.0.0:6800/12962 accepter.start
10.04.15 23:09:11.104965 7fe91e1ce710 -- 0.0.0.0:6801/12962 messenger.start
10.04.15 23:09:11.105004 7fe91e1ce710 -- 0.0.0.0:6801/12962 accepter.start
10.04.15 23:09:11.105176 7fe91e1ce710 filestore(/srv/ceph/osd) basedir /srv/ceph/osd journal 
10.04.15 23:09:11.105346 7fe91e1ce710 filestore(/srv/ceph/osd) mount detected btrfs
10.04.15 23:09:11.105383 7fe91e1ce710 filestore(/srv/ceph/osd) _do_clone_range 0~1
10.04.15 23:09:11.105408 7fe91e1ce710 filestore(/srv/ceph/osd) mount btrfs CLONE_RANGE ioctl is supported
10.04.15 23:09:11.152443 7fe91e1ce710 filestore(/srv/ceph/osd) mount btrfs SNAP_CREATE is supported
10.04.15 23:09:11.332557 7fe91e1ce710 filestore(/srv/ceph/osd) mount btrfs SNAP_DESTROY is supported
10.04.15 23:09:11.332657 7fe91e1ce710 filestore(/srv/ceph/osd) mount fsid is 321622132
10.04.15 23:09:11.332771 7fe91e1ce710 filestore(/srv/ceph/osd) mount found snaps <1>
10.04.15 23:09:11.660421 7fe91e1ce710 filestore(/srv/ceph/osd) mount rolled back to consistent snap 1
10.04.15 23:09:11.660518 7fe91e1ce710 filestore(/srv/ceph/osd) mount op_seq is 1
10.04.15 23:09:11.660676 7fe91b2e3910 filestore(/srv/ceph/osd) sync_entry waiting for max_interval 5.000000
10.04.15 23:09:11.660775 7fe919ae0910 filestore(/srv/ceph/osd) flusher_entry start
10.04.15 23:09:11.660801 7fe919ae0910 filestore(/srv/ceph/osd) flusher_entry sleeping
10.04.15 23:09:11.660824 7fe91e1ce710 filestore(/srv/ceph/osd) mount WARNING: no journal
10.04.15 23:09:11.660901 7fe91e1ce710 filestore(/srv/ceph/osd) read /srv/ceph/osd/current/meta/osd_superblock_0 0~0
10.04.15 23:09:11.660963 7fe91e1ce710 filestore(/srv/ceph/osd) read /srv/ceph/osd/current/meta/osd_superblock_0 0~85 = 85
10.04.15 23:09:11.661040 7fe91e1ce710 filestore(/srv/ceph/osd) list_collections
10.04.15 23:09:11.661075 7fe91e1ce710 filestore(/srv/ceph/osd) parse . -> 0.0p0_0 = 0
10.04.15 23:09:11.661090 7fe91e1ce710 filestore(/srv/ceph/osd) parse .. -> 0.0p0_0 = 0
10.04.15 23:09:11.661101 7fe91e1ce710 filestore(/srv/ceph/osd) parse commit_op_seq -> 0.0p0_0 = 0
10.04.15 23:09:11.661110 7fe91e1ce710 filestore(/srv/ceph/osd) parse meta -> 0.0p0_0 = 1
10.04.15 23:09:11.661533 7fe91e1ce710 -- 0.0.0.0:6800/12962 --> mon0 192.168.6.209:6789/0 -- auth(proto 0 26 bytes) -- ?+0 0x27fd4e0
10.04.15 23:09:11.663643 7fe9162d9910 -- 192.168.6.211:6800/12962 learned my addr 192.168.6.211:6800/12962
10.04.15 23:09:16.660751 7fe91b2e3910 filestore(/srv/ceph/osd) sync_entry woke after 5.000057
10.04.15 23:09:16.660779 7fe91b2e3910 filestore(/srv/ceph/osd) sync_entry committing 1 sync_epoch 1
10.04.15 23:09:16.660854 7fe91b2e3910 filestore(/srv/ceph/osd) taking snap 'snap_1'
10.04.15 23:09:16.660898 7fe91b2e3910 filestore(/srv/ceph/osd) snap create 'snap_1' got -1 File exists
os/FileStore.cc: In function 'void FileStore::sync_entry()':
os/FileStore.cc:1628: FAILED assert(r == 0)
 1: (FileStore::SyncThread::entry()+0xd) [0x4e8e5d]
 2: (Thread::_entry_func(void*)+0x7) [0x46a057]
 3: /lib/libpthread.so.0 [0x7fe91dba5a04]
 4: (clone()+0x6d) [0x7fe91cddd80d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--=-QAUsw6m7uNxRibZGTPzz--

