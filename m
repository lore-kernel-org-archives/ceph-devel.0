From: Wido den Hollander <wido@pcextreme.nl>
Subject: unstable branch won't come online
Date: Thu, 15 Apr 2010 17:25:41 +0200
Message-ID: <1271345141.4713.25.camel@wido-desktop>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ceXczk+E+p6urK6bLgV8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:42097 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab0DOPZo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 11:25:44 -0400
Received: from zarafa.pcextreme.nl (zarafa.pcextreme.nl [79.99.135.237])
	by support.pcextreme.nl (Postfix) with ESMTP id A6F34841FE
	for <ceph-devel@vger.kernel.org>; Thu, 15 Apr 2010 17:25:40 +0200 (CEST)
Received: from [192.168.6.32] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by zarafa.pcextreme.nl (Postfix) with ESMTPSA id A7140600009F
	for <ceph-devel@vger.kernel.org>; Thu, 15 Apr 2010 17:25:51 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-ceXczk+E+p6urK6bLgV8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Since i had some troubles with the "stable" branch regarding snapshots
en stalling writebacks i'm trying to get the unstable branch to work.

My setup consists of 7 machines in total:

- ceph01 (mon / mds): 192.168.6.209
- ceph02 (mon / mds): 192.168.6.210
- osd1 (osd): 192.168.6.211
- osd2 (osd): 192.168.6.212
- osd3 (osd): 192.168.6.213
- osd4 (osd): 192.168.6.214
- osd5 (osd): 192.168.6.215

All these machines are running Ubuntu 9.10 (AMD64) with kernel version
2.6.34 fetched from:
http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/2010-04-05-karmic/

According to the build log these packages were build with 2.6.34-rc3

The problem right now is, my setup is not working. I did a complete
cleanup of alle 7 machines, gave them a re-install to be sure they were
all clean.

I've attached my ceph.conf for the reference, but imho there seems to be
a problem with the mon's, this is what i see in my logfiles:

cephx keyserverdata: get_caps: name=mon.
cephx keyserverdata: get_secret: num of caps=0
cephx: verify_authorizer_reply exception in decode_decrypt with
LR1SttT3gGUDYMC5Ylp4ww== (10.04.15 16:59:52.104714)
-- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a0d40 sd=7
pgs=0 cs=0 l=0).failed verifying authorize reply
-- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a0d40 sd=-1
pgs=0 cs=0 l=0).fault first fault
cephx keyserverdata: get_caps: name=mon.
cephx keyserverdata: get_secret: num of caps=0
cephx: verify_authorizer_reply exception in decode_decrypt with
2FUG2YqeiNqm0cxFgialag== (10.04.15 16:59:52.107835)
-- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a0d40 sd=7
pgs=0 cs=0 l=0).failed verifying authorize reply
7f0406603910 -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0
pipe(0x25a40a0 sd=7 pgs=0 cs=0 l=0).accept connect_seq 0 vs existing 0
state 1
7f0406603910 -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0
pipe(0x25a40a0 sd=-1 pgs=5 cs=1 l=0).fault initiating reconnect
cephx keyserverdata: get_caps: name=mon.
cephx keyserverdata: get_secret: num of caps=0
cephx: verify_authorizer_reply exception in decode_decrypt with
U9X7DcmEIlSzQ5TIZgUT+g== (10.04.15 16:59:52.235836)
-- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a40a0 sd=7
pgs=5 cs=2 l=0).failed verifying authorize reply
-- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a40a0 sd=-1
pgs=5 cs=2 l=0).fault first fault
cephx keyserverdata: get_caps: name=mon.
cephx keyserverdata: get_secret: num of caps=0
cephx: verify_authorizer_reply exception in decode_decrypt with
PBYNd7534Bft/AoQ0xRObw== (10.04.15 16:59:52.243187)
-- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a40a0 sd=7
pgs=5 cs=2 l=0).failed verifying authorize reply

The messages are the same on mon0 and mon1.

Now, on my osd's i see: 

10.04.15 17:11:26.791702 7ff980706710 -- 0.0.0.0:6800/24247 --> mon1
192.168.6.210:6789/0 -- auth(proto 0 26 bytes) -- ?+0 0xd0f8e0
10.04.15 17:11:26.800456 7ff978811910 -- 192.168.6.211:6800/24247
learned my addr 192.168.6.211:6800/24247
os/FileStore.cc: In function 'void FileStore::sync_entry()':
os/FileStore.cc:1628: FAILED assert(r == 0)
 1: (FileStore::SyncThread::entry()+0xd) [0x4e8e5d]
 2: (Thread::_entry_func(void*)+0x7) [0x46a057]
 3: /lib/libpthread.so.0 [0x7ff9800dda04]
 4: (clone()+0x6d) [0x7ff97f31580d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

To be sure, my git branch is "unstable"

root@osd1:/usr/src/ceph# git status|head -n 2
# On branch unstable
# Changed but not updated:
root@osd1:/usr/src/ceph#

I used "dpkg-buildpackage" on osd1 (fastest CPU) to build .deb's for
unstable, this because i wanted to test the new rbd block driver and for
that i needed rbdtool.

So to me there seem to be two issues:

1. Mon's cant authenticate with eachother
2. OSD's are crashing

Any ideas? If needed, i can arrange access to these machines.

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



--=-ceXczk+E+p6urK6bLgV8
Content-Disposition: attachment; filename="ceph.conf"
Content-Type: text/plain; name="ceph.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[global]
       pid file = /var/run/ceph/$name.pid
       debug ms = 1

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

[osd1]
       host = osd1
       btrfs devs = /dev/sda6

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


--=-ceXczk+E+p6urK6bLgV8--

