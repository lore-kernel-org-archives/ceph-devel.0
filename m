From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: unstable branch won't come online
Date: Thu, 15 Apr 2010 19:56:33 +0200
Message-ID: <1271354193.3520.6.camel@wido-laptop.pcextreme.nl>
References: <1271345141.4713.25.camel@wido-desktop>
	 <Pine.LNX.4.64.1004151018580.15369@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mSylHw5+o7ccVPzI4L2J"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:52021 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0DOR4g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 13:56:36 -0400
In-Reply-To: <Pine.LNX.4.64.1004151018580.15369@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--=-mSylHw5+o7ccVPzI4L2J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Sage,

I've placed "debug osd = 20" in [global], [osd] and [osd1], but it
didn't seem to change much to the log itself.

Attached you'll find the log of "osd1"

After writing "send_pg_stats" in the logfile "cosd" crashes about 3
seconds later.

FYI, on my system libc6 version 2.10.1-0ubuntu16 is installed (don't
know if this is of any use?)

I'm building a new version of my .deb's right now using the latest GIT
checkout, i'll know if the monitors work by tomorrow.

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


On Thu, 2010-04-15 at 17:23 +0000, Sage Weil wrote:
> debug osd

--=-mSylHw5+o7ccVPzI4L2J
Content-Disposition: attachment; filename="osd1.log"
Content-Type: text/x-log; name="osd1.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

10.04.15 19:50:32.092320 --- opened log /var/log/ceph/osd1.1954 ---
ceph version 0.19.1 (198d7106818e91c655740f3a41c2390af36e069e)
10.04.15 19:50:32.092472 7f0ca4873710 ---- renamed symlink /var/log/ceph/osd1 -> /var/log/ceph/osd1.0 ----
10.04.15 19:50:32.092509 7f0ca4873710 ---- created symlink /var/log/ceph/osd1 -> osd1.1954 ----
10.04.15 19:50:32.092822 7f0ca4873710 -- 0.0.0.0:6800/1954 accepter.bind ms_addr is 0.0.0.0:6800/1954 need_addr=1
10.04.15 19:50:32.092874 7f0ca4873710 -- 0.0.0.0:6801/1954 accepter.bind ms_addr is 0.0.0.0:6801/1954 need_addr=1
10.04.15 19:50:32.093044 7f0ca4873710 -- 0.0.0.0:6800/1954 messenger.start
10.04.15 19:50:32.093058 7f0ca4873710 -- 0.0.0.0:6800/1954 messenger.start daemonizing
10.04.15 19:50:32.093523 7f0ca4873710 ---- renamed log /var/log/ceph/osd1.1954 -> /var/log/ceph/osd1.1955 ----
10.04.15 19:50:32.093742 7f0ca4873710 -- 0.0.0.0:6800/1954 accepter.start
10.04.15 19:50:32.093888 7f0ca4873710 -- 0.0.0.0:6801/1954 messenger.start
10.04.15 19:50:32.093927 7f0ca4873710 -- 0.0.0.0:6801/1954 accepter.start
10.04.15 19:50:32.093981 7f0ca4873710 osd1 0 mounting /srv/ceph/osd 
10.04.15 19:50:32.094126 7f0ca4873710 filestore(/srv/ceph/osd) mount detected btrfs
10.04.15 19:50:32.094180 7f0ca4873710 filestore(/srv/ceph/osd) mount btrfs CLONE_RANGE ioctl is supported
10.04.15 19:50:32.138890 7f0ca4873710 filestore(/srv/ceph/osd) mount btrfs SNAP_CREATE is supported
10.04.15 19:50:32.301309 7f0ca4873710 filestore(/srv/ceph/osd) mount btrfs SNAP_DESTROY is supported
10.04.15 19:50:32.301514 7f0ca4873710 filestore(/srv/ceph/osd) mount found snaps <1>
10.04.15 19:50:32.663982 7f0ca4873710 filestore(/srv/ceph/osd) mount WARNING: no journal
10.04.15 19:50:32.664053 7f0ca4873710 osd1 0 boot
10.04.15 19:50:32.664148 7f0ca4873710 osd1 0 read_superblock sb(27aff7af-36da-d776-dc68-9a46644555fd osd1 e0 [0,0] lci=[0,0])
10.04.15 19:50:32.664221 7f0ca4873710 osd1 0 load_pgs
10.04.15 19:50:32.664252 7f0ca4873710 filestore(/srv/ceph/osd) parse . -> 0.0p0_0 = 0
10.04.15 19:50:32.664268 7f0ca4873710 filestore(/srv/ceph/osd) parse .. -> 0.0p0_0 = 0
10.04.15 19:50:32.664278 7f0ca4873710 filestore(/srv/ceph/osd) parse commit_op_seq -> 0.0p0_0 = 0
10.04.15 19:50:32.664288 7f0ca4873710 filestore(/srv/ceph/osd) parse meta -> 0.0p0_0 = 1
10.04.15 19:50:32.664303 7f0ca4873710 osd1 0 superblock: i am osd1
10.04.15 19:50:32.664694 7f0ca4873710 -- 0.0.0.0:6800/1954 --> mon1 192.168.6.210:6789/0 -- auth(proto 0 26 bytes) -- ?+0 0x16134f0
10.04.15 19:50:32.666824 7f0c9c97f910 -- 192.168.6.211:6800/1954 learned my addr 192.168.6.211:6800/1954
10.04.15 19:50:32.666875 7f0c9c97f910 osd1 0 OSD::ms_get_authorizer type=mon
10.04.15 19:50:32.673342 7f0c9e182910 osd1 0 ms_handle_connect on mon
10.04.15 19:50:32.673396 7f0c9e182910 osd1 0 send_boot
10.04.15 19:50:32.673416 7f0c9e182910 osd1 0 send_pg_stats
os/FileStore.cc: In function 'void FileStore::sync_entry()':
os/FileStore.cc:1628: FAILED assert(r == 0)
 1: (FileStore::SyncThread::entry()+0xd) [0x4e8e5d]
 2: (Thread::_entry_func(void*)+0x7) [0x46a057]
 3: /lib/libpthread.so.0 [0x7f0ca424ba04]
 4: (clone()+0x6d) [0x7f0ca348380d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.


--=-mSylHw5+o7ccVPzI4L2J--

