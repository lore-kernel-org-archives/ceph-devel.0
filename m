From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Replacing a failed disk/OSD: unfound object
Date: Wed, 13 Jul 2011 09:19:40 -0700
Message-ID: <CAORUGqAoJyip9gKhhaN4J5uHMe8vhnzjkOPKGPa7nXE62xwx=A@mail.gmail.com>
References: <739109542484ec419c72b1a0f941a54d@carbonite.cn>
 <CAORUGqDHG9k-o_VwWTGo3UtimfyYnrisKnEAt7nf6+B1Q5q1uw@mail.gmail.com>
 <CAORUGqD=XxjRLL6j75yg8gQkKOuuNE=ybt2wVP37cKBZcX1y8Q@mail.gmail.com>
 <620ab7bc3254ca105a1b91930afce314@carbonite.cn> <Pine.LNX.4.64.1107120904210.30805@cobra.newdream.net>
 <4b7beb00f8799e7ddd8bdd7e9f94fa84@carbonite.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64734 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab1GMQUB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 12:20:01 -0400
Received: by iyb12 with SMTP id 12so5673205iyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 09:20:00 -0700 (PDT)
In-Reply-To: <4b7beb00f8799e7ddd8bdd7e9f94fa84@carbonite.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Meng Zhao <mzhao@carbonite.cn>
Cc: Sage Weil <sage@newdream.net>, Ceph devel <ceph-devel@vger.kernel.org>

On Wed, Jul 13, 2011 at 03:15, Meng Zhao <mzhao@carbonite.cn> wrote:
> active+clean; 349 MB data, 1394 MB used, 408 MB / 2046 MB avail; 49/2=
24
> degraded (21.875%)
> =3D>for some reason osd2 failed during object replication

If you lose osds while in degraded mode, you very much can lose
objects permanently. Degraded means the replication has not completed.
It's like losing a second disk in a RAID5 before it has healed, though
the scope of the loss is individual objects not the whole filesystem.

> 2011-07-13 16:17:51.638261 7f3b76f26700 osd2 179 heartbeat_check: no
> heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-=
13
> 16:17:31.638165)
> 2011-07-13 16:17:51.926444 7f3b6c610700 osd2 179 heartbeat_check: no
> heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-=
13
> 16:17:31.926413)
> 2011-07-13 16:17:52.526995 7f3b6c610700 osd2 179 heartbeat_check: no
> heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-=
13
> 16:17:32.526963)
> 2011-07-13 16:17:52.638956 7f3b76f26700 osd2 179 heartbeat_check: no
> heartbeat from osd0 since 2011-07-13 16:17:24.048586 (cutoff 2011-07-=
13
> 16:17:32.638936)
> 2011-07-13 16:17:52.763523 7f3b6b607700 -- 192.168.0.137:6802/9292 >>
> 192.168.0.136:6802/2984 pipe(0x2ce1a20 sd=3D13 pgs=3D2 cs=3D2 l=3D0).=
connect claims
> to be 0.0.0.0:6802/2984 not 192.168.0.136:6802/2984 - presumably this=
 is the
> same node!
> 2011-07-13 16:17:59.235254 7f3b75723700 osd2 182 pg[1.94( v 182'23
> (178'20,182'23] n=3D1 ec=3D2 les/c 181/182 180/180/155) [2] r=3D0 mlc=
od 0'0 !hml
> active+clean+degraded] =C2=A0sending commit on repgather(0x7f3b602cfb=
a0 applied
> 182'23 rep_tid=3D274 wfack=3D wfdisk=3D op=3Dosd_op(mds0.11:21 200.00=
000000
> [writefull 0~84] 1.3494) v2) 0x7f3b601ebb90
> *** Caught signal (Aborted) **
> =C2=A0in thread 0x7f3b74721700
> =3D>restart osd2
> 2011-07-13 17:06:00.120011 7fe0f5c57720 ceph version 0.30.commit:
> 64b1b2c70f0cde39c72d5d724c65ea8afaaa00b9. process: cosd. pid: 10241
> 2011-07-13 17:06:00.132026 7fe0f5c57720 filestore(/data/osd.2) mount =
=46IEMAP
> ioctl is NOT supported
> 2011-07-13 17:06:00.132100 7fe0f5c57720 filestore(/data/osd.2) mount
> detected btrfs
> 2011-07-13 17:06:00.132120 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> CLONE_RANGE ioctl is supported
> 2011-07-13 17:06:00.149449 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> SNAP_CREATE is supported
> 2011-07-13 17:06:00.297455 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> SNAP_DESTROY is supported
> 2011-07-13 17:06:00.297786 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> START_SYNC got 0 Success
> 2011-07-13 17:06:00.297847 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> START_SYNC is supported (transid 363)
> 2011-07-13 17:06:00.300147 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> WAIT_SYNC is supported
> 2011-07-13 17:06:00.301704 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> SNAP_CREATE_V2 got 0 Success
> 2011-07-13 17:06:00.301727 7fe0f5c57720 filestore(/data/osd.2) mount =
btrfs
> SNAP_CREATE_V2 is supported
> 2011-07-13 17:06:00.325592 7fe0f5c57720 filestore(/data/osd.2) mount =
found
> snaps <24050,24085>
> 2011-07-13 17:06:00.376720 7fe0f5c57720 filestore(/data/osd.2) mount:
> enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and
> 'filestore btrfs snap' mode is enabled
> 2011-07-13 17:06:00.376809 7fe0f5c57720 journal _open /data/osd.2/jou=
rnal fd
> 11: 1048576000 bytes, block size 4096 bytes, directio =3D 1
> 2011-07-13 17:06:00.470792 7fe0f5c57720 journal read_entry 593817600 =
: seq
> 24086 1049540 bytes
> 2011-07-13 17:06:00.472089 7fe0f5c57720 journal read_entry 593817600 =
: seq
> 24086 1049540 bytes
> *** Caught signal (Aborted) **
> =C2=A0in thread 0x7fe0f5c57720
> =C2=A0ceph version 0.30 (commit:64b1b2c70f0cde39c72d5d724c65ea8afaaa0=
0b9)
> =C2=A01: /usr/bin/cosd() [0x637e6e]
> =C2=A02: (()+0xf430) [0x7fe0f563a430]
> =C2=A03: (gsignal()+0x35) [0x7fe0f442c355]
> =C2=A04: (abort()+0x17f) [0x7fe0f442d5ef]
> =C2=A05: (__assert_fail()+0xf1) [0x7fe0f44254c1]
> =C2=A06: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x3d4=
2)
> [0x5c4b62]
> =C2=A07: (FileStore::do_transactions(std::list<ObjectStore::Transacti=
on*,
> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x75)
> [0x5c5135]
> =C2=A08: (JournalingObjectStore::journal_replay(unsigned long)+0xf60)=
 [0x5d54c0]
> =C2=A09: (FileStore::mount()+0x17e9) [0x5ae489]
> =C2=A010: (OSD::init()+0x165) [0x50cfd5]
> =C2=A011: (main()+0x2424) [0x48ba64]
> =C2=A012: (__libc_start_main()+0xfd) [0x7fe0f4418d2d]
> =C2=A013: /usr/bin/cosd() [0x4881e9]

That sounds like an (unrelated) bug in journal replay. If nobody else
pipes up and identifies it as something already fixed, please file a
ticket.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
