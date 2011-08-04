From: Sage Weil <sage@newdream.net>
Subject: Re: read performance not perfect
Date: Thu, 4 Aug 2011 08:51:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
 <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
 <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1013078633-1312473116=:17151"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44287 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1HDPrq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2011 11:47:46 -0400
In-Reply-To: <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1013078633-1312473116=:17151
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

I've just pushed a wip-readahead branch to ceph-client.git that rewrites=20
ceph_readpages (used for readahead) to be fully asynchronous.  This should=
=20
let us take full advantage of whatever the readahead window is.  I'm still=
=20
doing some testing on this end, but things look good so far.

There are two relevant mount options:

 rasize=3DNN    - max readahead window size (bytes)
 rsize=3DMM     - max read size

rsize defaults to 0 (no limit), which means it effectively maxes out at=20
the stripe size (one object, 4MB by default).

rasize now defaults to 8 MB.  This is probably what you'll want to=20
experiment with.  In practice I think something on the order of 8-12 MB=20
will be best, as it will start loading things of disk ~2 objects ahead of=
=20
the current position.

Can you give it a go and see if this helps in your environment?

Thanks!
sage


On Tue, 19 Jul 2011, huang jun wrote:
> thanks for you reply
> now we find two points confused us:
> 1) the kernel client execute sequence read though aio_read function,
> but from OSD log,
>    the dispatch_queue length in OSD is always 0, it means OSD can't
> got next READ message until client send to it. It seems that
> async_read changes to sync_read, OSD can't parallely read data, so can
> not make the most of  resources.What are the original purposes when
> you design this part? perfect realiablity?

Right.  The old ceph_readpages was synhronous, which slowed things down in=
=20
a couple of different ways.

> 2) In singleness read circumstance,during OSD read data from it disk,
> the OSD doesn't do anything but to wait it finish.We think it was the
> result of 1), OSD have nothing to do,so just to wait.
>=20
>=20
> 2011/7/19 Sage Weil <sage@newdream.net>:
> > On Mon, 18 Jul 2011, huang jun wrote:
> >> hi,all
> >> We test ceph's read performance last week, and find something weird
> >> we use ceph v0.30 on linux 2.6.37
> >> mount ceph on back-platform consist of 2 osds \1 mon \1 mds
> >> $mount -t ceph 192.168.1.103:/ /mnt -vv
> >> $ dd if=3D/dev/zero of=3D/mnt/test bs=3D4M count=3D200
> >> $ cd .. && umount /mnt
> >> $mount -t ceph 192.168.1.103:/ /mnt -vv
> >> $dd if=3Dtest of=3D/dev/zero bs=3D4M
> >> =A0 200+0 records in
> >> =A0 200+0 records out
> >> =A0 838860800 bytes (839 MB) copied, 16.2327 s, 51.7 MB/s
> >> but if we use rados to test it
> >> $ rados -m 192.168.1.103:6789 -p data bench 60 write
> >> $ rados -m 192.168.1.103:6789 -p data bench 60 seq
> >> =A0 the result is:
> >> =A0 Total time run: =A0 =A0 =A0 =A024.733935
> >> =A0 Total reads made: =A0 =A0 438
> >> =A0 Read size: =A0 =A0 =A0 =A0 =A0 =A04194304
> >> =A0 Bandwidth (MB/sec): =A0 =A070.834
> >>
> >> =A0 Average Latency: =A0 =A0 =A0 0.899429
> >> =A0 Max latency: =A0 =A0 =A0 =A0 =A0 1.85106
> >> =A0 Min latency: =A0 =A0 =A0 =A0 =A0 0.128017
> >> this phenomenon attracts our attention, then we begin to analysis the
> >> osd debug log.
> >> we find that :
> >> 1) the kernel client send READ request, at first it requests 1MB, and
> >> after that it is 512KB
> >> 2) from rados test cmd log, OSD recept the READ op with 4MB data to ha=
ndle
> >> we know the ceph developers pay their attention to read and write
> >> performance, so i just want to confrim that
> >> if the communication between the client and OSD spend =A0more time tha=
n
> >> it should be? can we request =A0bigger size, just like default object
> >> size 4MB, when it occurs to READ operation? or this is related to OS
> >> management, if so, what can we do to promote the performance?
> >
> > I think it's related to the way the Linux VFS is doing readahead, and h=
ow
> > the ceph fs code is handling it. =A0It's issue #1122 in the tracker and=
 I
> > plan to look at it today or tomorrow!
> >
> > Thanks-
> > sage
> >
>=20
>=20
--557981400-1013078633-1312473116=:17151--
