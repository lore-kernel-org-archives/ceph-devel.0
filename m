From: Gregory Farnum <greg@inktank.com>
Subject: Re: Upgrade from 0.47.2 to 0.48 - osd crashes
Date: Tue, 3 Jul 2012 08:16:19 -0700
Message-ID: <927AD3D0FAF54906BC428A9F1881D1EA@inktank.com>
References: <CAMmJxtKb7zxf_eqyWhYWH7hq+qxnvAX5x7E8i7WeppppuYVTXg@mail.gmail.com>
 <CAMmJxtLR3Ec4htEJnkxx3qewXLO07gG5KzACK3t=q5KgxjQ-9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40764 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab2GCPQX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:16:23 -0400
Received: by pbbrp8 with SMTP id rp8so9377755pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 08:16:23 -0700 (PDT)
In-Reply-To: <CAMmJxtLR3Ec4htEJnkxx3qewXLO07gG5KzACK3t=q5KgxjQ-9Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

That particular assert means "augh it's taking too long for the filesys=
tem to handle my requests!" The disk format upgrade in particular seems=
 to hit it, so you may have some luck just increasing the timeout (incr=
ease filestore_op_thread_suicide_timeout from its default 180 seconds) =
=E2=80=94 but it is indicative of some serious performance problems, pr=
obably caused by btrfs fragmentation. =20
-Greg


On Tuesday, July 3, 2012 at 4:42 AM, John Axel Eriksson wrote:

> It seems this was caused by problems with the underlying filesystem. =
I
> was able to solve it by rebooting, not sure what the
> problem was but there were errors i dmesg about it (using btrfs here)=
=2E
> =20
> On Tue, Jul 3, 2012 at 10:00 AM, John Axel Eriksson <john@insane.se (=
mailto:john@insane.se)> wrote:
> > So I first upgraded the mon, then went ahead and upgraded one of th=
e
> > osds which crashed and keeps crashing - probably when trying to
> > upgrade the filestore.
> > How should I proceed? FS is btrfs, one mon two osds. This is the co=
nf
> > for the osds:
> > =20
> > [osd]
> > osd data =3D /srv/osd.$id
> > osd journal =3D /srv/osd.$id.journal
> > osd journal size =3D 1000
> > =20
> > Here's the log output:
> > =20
> > root@ceph-osd-0:~# tail -F /var/log/ceph/ceph-osd.0.log
> > =20
> > --- end dump of recent events ---
> > 2012-07-03 07:46:49.543030 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > FIEMAP ioctl is supported and appears to work
> > 2012-07-03 07:46:49.543095 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > FIEMAP ioctl is disabled via 'filestore fiemap' config option
> > 2012-07-03 07:46:50.049179 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > detected btrfs
> > 2012-07-03 07:46:50.049435 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > btrfs CLONE_RANGE ioctl is supported
> > 2012-07-03 07:46:50.898083 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > btrfs SNAP_CREATE is supported
> > 2012-07-03 07:46:50.937621 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > btrfs SNAP_DESTROY is supported
> > 2012-07-03 07:46:51.164967 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > btrfs START_SYNC is supported (transid 44619)
> > 2012-07-03 07:46:51.426019 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > btrfs WAIT_SYNC is supported
> > 2012-07-03 07:46:51.664258 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > btrfs SNAP_CREATE_V2 is supported
> > 2012-07-03 07:46:52.535058 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > syncfs(2) syscall fully supported (by glibc and kernel)
> > 2012-07-03 07:46:52.535529 7f2d0f332780 -1 filestore(/srv/osd.0)
> > FileStore::mount : stale version stamp detected: 2. Proceeding,
> > do_update is set, performing disk format upgrade.
> > 2012-07-03 07:46:52.535683 7f2d0f332780 0 filestore(/srv/osd.0) mou=
nt
> > found snaps <650707,650708>
> > 2012-07-03 07:47:04.317867 7f2d0f332780 0 filestore(/srv/osd.0)
> > mount: enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detect=
ed
> > and 'filestore btrfs snap' mode is enabled
> > 2012-07-03 07:47:04.354557 7f2d0f332780 1 journal _open
> > /srv/osd.0.journal fd 23: 1048576000 bytes, block size 4096 bytes,
> > directio =3D 1, aio =3D 0
> > 2012-07-03 07:48:47.415664 7f2d0f332780 1 journal _open
> > /srv/osd.0.journal fd 23: 1048576000 bytes, block size 4096 bytes,
> > directio =3D 1, aio =3D 0
> > 2012-07-03 07:48:47.416522 7f2d0f332780 -1 FileStore is old at vers=
ion
> > 2. Updating...
> > 2012-07-03 07:48:47.416535 7f2d0f332780 -1 Removing tmp pgs
> > 2012-07-03 07:49:51.029035 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:49:56.029265 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:50:01.029413 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:50:06.029531 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:50:11.029651 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:50:16.029764 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:50:18.959270 7f2d08be4700 1 heartbeat_map reset_timeo=
ut
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:50:19.273378 7f2d0f332780 -1 Getting collections
> > 2012-07-03 07:50:19.273399 7f2d0f332780 -1 834 to process.
> > 2012-07-03 07:50:19.274588 7f2d0f332780 -1 0/833 processed
> > 2012-07-03 07:50:19.274651 7f2d0f332780 -1 Updating collection meta
> > current version is 2
> > 2012-07-03 07:51:21.031150 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:26.031309 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:31.031430 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:36.031592 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:41.031732 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:46.031878 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:51.032004 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:51:56.032134 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:52:01.032255 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:52:06.032381 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:52:09.361844 7f2d08be4700 1 heartbeat_map reset_timeo=
ut
> > 'FileStore::op_tp thread 0x7f2d08be4700' had timed out after 60
> > 2012-07-03 07:53:11.033743 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:16.033859 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:21.034007 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:26.034140 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:31.034267 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:36.034398 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:41.034593 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:46.034735 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:51.034870 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:53:56.035015 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:01.035153 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:06.035289 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:11.035440 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:16.035581 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:21.035700 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:26.035839 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:31.035992 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:36.036139 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:41.036258 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:46.036394 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:51.036530 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:54:56.036651 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:55:01.036767 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:55:06.036911 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:55:11.037032 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had timed out after 60
> > 2012-07-03 07:55:11.037077 7f2d0bbea700 1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f2d083e3700' had suicide timed out afte=
r
> > 180
> > 2012-07-03 07:55:11.038755 7f2d0bbea700 -1 common/HeartbeatMap.cc (=
http://HeartbeatMap.cc): In
> > function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*=
,
> > const char*, time_t)' thread 7f2d0bbea700 time 2012-07-03
> > 07:55:11.037140
> > common/HeartbeatMap.cc (http://HeartbeatMap.cc): 78: FAILED assert(=
0 =3D=3D "hit suicide timeout")
> > =20
> > ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a=
2bf2030)
> > 1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > const*, long)+0x26a) [0x8285aa]
> > 2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x828d87]
> > 3: (ceph::HeartbeatMap::check_touch_file()+0x23) [0x828fc3]
> > 4: (CephContextServiceThread::entry()+0x54) [0x7aa734]
> > 5: (()+0x7e9a) [0x7f2d0e7c4e9a]
> > 6: (clone()+0x6d) [0x7f2d0d4644bd]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > =20
> > --- begin dump of recent events ---
> > -66> 2012-07-03 07:46:41.019588 7f2d0f332780 0 ceph version
> > 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030),
> > process ceph-osd, pid 3070
> > -65> 2012-07-03 07:46:49.543030 7f2d0f332780 0
> > filestore(/srv/osd.0) mount FIEMAP ioctl is supported and appears t=
o
> > work
> > -64> 2012-07-03 07:46:49.543095 7f2d0f332780 0
> > filestore(/srv/osd.0) mount FIEMAP ioctl is disabled via 'filestore
> > fiemap' config option
> > -63> 2012-07-03 07:46:50.049179 7f2d0f332780 0
> > filestore(/srv/osd.0) mount detected btrfs
> > -62> 2012-07-03 07:46:50.049435 7f2d0f332780 0
> > filestore(/srv/osd.0) mount btrfs CLONE_RANGE ioctl is supported
> > -61> 2012-07-03 07:46:50.898083 7f2d0f332780 0
> > filestore(/srv/osd.0) mount btrfs SNAP_CREATE is supported
> > -60> 2012-07-03 07:46:50.937621 7f2d0f332780 0
> > filestore(/srv/osd.0) mount btrfs SNAP_DESTROY is supported
> > -59> 2012-07-03 07:46:51.164967 7f2d0f332780 0
> > filestore(/srv/osd.0) mount btrfs START_SYNC is supported (transid
> > 44619)
> > -58> 2012-07-03 07:46:51.426019 7f2d0f332780 0
> > filestore(/srv/osd.0) mount btrfs WAIT_SYNC is supported
> > -57> 2012-07-03 07:46:51.664258 7f2d0f332780 0
> > filestore(/srv/osd.0) mount btrfs SNAP_CREATE_V2 is supported
> > -56> 2012-07-03 07:46:52.535058 7f2d0f332780 0
> > filestore(/srv/osd.0) mount syncfs(2) syscall fully supported (by
> > glibc and kernel)
> > -55> 2012-07-03 07:46:52.535529 7f2d0f332780 -1
> > filestore(/srv/osd.0) FileStore::mount : stale version stamp detect=
ed:
> > 2. Proceeding, do_update is set, performing disk format upgrade.
> > -54> 2012-07-03 07:46:52.535683 7f2d0f332780 0
> > filestore(/srv/osd.0) mount found snaps <650707,650708>
> > -53> 2012-07-03 07:47:04.317867 7f2d0f332780 0
> > filestore(/srv/osd.0) mount: enabling PARALLEL journal mode: btrfs,
> > SNAP_CREATE_V2 detected and 'filestore btrfs snap' mode is enabled
> > -52> 2012-07-03 07:47:04.354557 7f2d0f332780 1 journal _open
> > /srv/osd.0.journal fd 23: 1048576000 bytes, block size 4096 bytes,
> > directio =3D 1, aio =3D 0
> > -51> 2012-07-03 07:48:47.415664 7f2d0f332780 1 journal _open
> > /srv/osd.0.journal fd 23: 1048576000 bytes, block size 4096 bytes,
> > directio =3D 1, aio =3D 0
> > -50> 2012-07-03 07:48:47.416522 7f2d0f332780 -1 FileStore is old at
> > version 2. Updating...
> > -49> 2012-07-03 07:48:47.416535 7f2d0f332780 -1 Removing tmp pgs
> > -48> 2012-07-03 07:49:51.029035 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -47> 2012-07-03 07:49:56.029265 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -46> 2012-07-03 07:50:01.029413 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -45> 2012-07-03 07:50:06.029531 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -44> 2012-07-03 07:50:11.029651 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -43> 2012-07-03 07:50:16.029764 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -42> 2012-07-03 07:50:18.959270 7f2d08be4700 1 heartbeat_map
> > reset_timeout 'FileStore::op_tp thread 0x7f2d08be4700' had timed ou=
t
> > after 60
> > -41> 2012-07-03 07:50:19.273378 7f2d0f332780 -1 Getting collections
> > -40> 2012-07-03 07:50:19.273399 7f2d0f332780 -1 834 to process.
> > -39> 2012-07-03 07:50:19.274588 7f2d0f332780 -1 0/833 processed
> > -38> 2012-07-03 07:50:19.274651 7f2d0f332780 -1 Updating collection
> > meta current version is 2
> > -37> 2012-07-03 07:51:21.031150 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -36> 2012-07-03 07:51:26.031309 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -35> 2012-07-03 07:51:31.031430 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -34> 2012-07-03 07:51:36.031592 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -33> 2012-07-03 07:51:41.031732 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -32> 2012-07-03 07:51:46.031878 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -31> 2012-07-03 07:51:51.032004 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -30> 2012-07-03 07:51:56.032134 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -29> 2012-07-03 07:52:01.032255 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -28> 2012-07-03 07:52:06.032381 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d08be4700' had timed out
> > after 60
> > -27> 2012-07-03 07:52:09.361844 7f2d08be4700 1 heartbeat_map
> > reset_timeout 'FileStore::op_tp thread 0x7f2d08be4700' had timed ou=
t
> > after 60
> > -26> 2012-07-03 07:53:11.033743 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -25> 2012-07-03 07:53:16.033859 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -24> 2012-07-03 07:53:21.034007 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -23> 2012-07-03 07:53:26.034140 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -22> 2012-07-03 07:53:31.034267 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -21> 2012-07-03 07:53:36.034398 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -20> 2012-07-03 07:53:41.034593 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -19> 2012-07-03 07:53:46.034735 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -18> 2012-07-03 07:53:51.034870 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -17> 2012-07-03 07:53:56.035015 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -16> 2012-07-03 07:54:01.035153 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -15> 2012-07-03 07:54:06.035289 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -14> 2012-07-03 07:54:11.035440 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -13> 2012-07-03 07:54:16.035581 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -12> 2012-07-03 07:54:21.035700 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -11> 2012-07-03 07:54:26.035839 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -10> 2012-07-03 07:54:31.035992 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -9> 2012-07-03 07:54:36.036139 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -8> 2012-07-03 07:54:41.036258 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -7> 2012-07-03 07:54:46.036394 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -6> 2012-07-03 07:54:51.036530 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -5> 2012-07-03 07:54:56.036651 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -4> 2012-07-03 07:55:01.036767 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -3> 2012-07-03 07:55:06.036911 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -2> 2012-07-03 07:55:11.037032 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had timed out
> > after 60
> > -1> 2012-07-03 07:55:11.037077 7f2d0bbea700 1 heartbeat_map
> > is_healthy 'FileStore::op_tp thread 0x7f2d083e3700' had suicide tim=
ed
> > out after 180
> > 0> 2012-07-03 07:55:11.038755 7f2d0bbea700 -1
> > common/HeartbeatMap.cc (http://HeartbeatMap.cc): In function 'bool
> > ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
> > time_t)' thread 7f2d0bbea700 time 2012-07-03 07:55:11.037140
> > common/HeartbeatMap.cc (http://HeartbeatMap.cc): 78: FAILED assert(=
0 =3D=3D "hit suicide timeout")
> > =20
> > ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a=
2bf2030)
> > 1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > const*, long)+0x26a) [0x8285aa]
> > 2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x828d87]
> > 3: (ceph::HeartbeatMap::check_touch_file()+0x23) [0x828fc3]
> > 4: (CephContextServiceThread::entry()+0x54) [0x7aa734]
> > 5: (()+0x7e9a) [0x7f2d0e7c4e9a]
> > 6: (clone()+0x6d) [0x7f2d0d4644bd]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > =20
> > --- end dump of recent events ---
> > 2012-07-03 07:55:11.043564 7f2d0bbea700 -1 *** Caught signal (Abort=
ed) **
> > in thread 7f2d0bbea700
> > =20
> > ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a=
2bf2030)
> > 1: /usr/bin/ceph-osd() [0x6e900a]
> > 2: (()+0xfcb0) [0x7f2d0e7cccb0]
> > 3: (gsignal()+0x35) [0x7f2d0d3a8445]
> > 4: (abort()+0x17b) [0x7f2d0d3abbab]
> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f2d0dcf669d=
]
> > 6: (()+0xb5846) [0x7f2d0dcf4846]
> > 7: (()+0xb5873) [0x7f2d0dcf4873]
> > 8: (()+0xb596e) [0x7f2d0dcf496e]
> > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x282) [0x79f662]
> > 10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > const*, long)+0x26a) [0x8285aa]
> > 11: (ceph::HeartbeatMap::is_healthy()+0x87) [0x828d87]
> > 12: (ceph::HeartbeatMap::check_touch_file()+0x23) [0x828fc3]
> > 13: (CephContextServiceThread::entry()+0x54) [0x7aa734]
> > 14: (()+0x7e9a) [0x7f2d0e7c4e9a]
> > 15: (clone()+0x6d) [0x7f2d0d4644bd]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > =20
> > --- begin dump of recent events ---
> > 0> 2012-07-03 07:55:11.043564 7f2d0bbea700 -1 *** Caught signal
> > (Aborted) **
> > in thread 7f2d0bbea700
> > =20
> > ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a=
2bf2030)
> > 1: /usr/bin/ceph-osd() [0x6e900a]
> > 2: (()+0xfcb0) [0x7f2d0e7cccb0]
> > 3: (gsignal()+0x35) [0x7f2d0d3a8445]
> > 4: (abort()+0x17b) [0x7f2d0d3abbab]
> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f2d0dcf669d=
]
> > 6: (()+0xb5846) [0x7f2d0dcf4846]
> > 7: (()+0xb5873) [0x7f2d0dcf4873]
> > 8: (()+0xb596e) [0x7f2d0dcf496e]
> > 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x282) [0x79f662]
> > 10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > const*, long)+0x26a) [0x8285aa]
> > 11: (ceph::HeartbeatMap::is_healthy()+0x87) [0x828d87]
> > 12: (ceph::HeartbeatMap::check_touch_file()+0x23) [0x828fc3]
> > 13: (CephContextServiceThread::entry()+0x54) [0x7aa734]
> > 14: (()+0x7e9a) [0x7f2d0e7c4e9a]
> > 15: (clone()+0x6d) [0x7f2d0d4644bd]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > =20
> > --- end dump of recent events ---
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
