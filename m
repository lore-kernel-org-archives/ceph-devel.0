From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.48.1 argonaut stable update released
Date: Tue, 14 Aug 2012 21:09:03 +0200
Message-ID: <440738CF-7DDB-44D2-A35B-782D289D5B28@filoo.de>
References: <alpine.DEB.2.00.1208141116420.18862@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:40388 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab2HNTPn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 15:15:43 -0400
In-Reply-To: <alpine.DEB.2.00.1208141116420.18862@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

I just updated to debian-testing/0.50 this afternoon, after some hint:

* osd: better tracking of recent slow operations

and it is hereby confirmed to be better in my testing environment. Befo=
re I had requests, which could be there for >480 seconds=85 not any mor=
e.

How's about this fix in 0.48.X?

Thnx in @vance,

Oliver - Thus being too lazy to read all change logs - Francke.

Am 14.08.2012 um 20:18 schrieb Sage Weil <sage@inktank.com>:

> We've built and pushed the first update to the argonaut stable releas=
e. =20
> This branch has a range of small fixes for stability, compatibility, =
and=20
> performance, but no major changes in functionality.  The stability fi=
xes=20
> are particularly important for large clusters with many OSDs, and for=
=20
> network environments where intermittent network failures are more com=
mon.
>=20
> The highlights include:
>=20
> * mkcephfs: use default `keyring', `osd data', `osd journal' paths wh=
en=20
>   not specified in conf
> * msgr: various fixes to socket error handling
> * osd: reduce scrub overhead
> * osd: misc peering fixes (past_interval sharing, pgs stuck in `peeri=
ng'=20
>   states)
> * osd: fail on EIO in read path (do not silently ignore read errors f=
rom=20
>   failing disks)
> * osd: avoid internal heartbeat errors by breaking some large=20
>   transactions into pieces
> * osd: fix osdmap catch-up during startup (catch up and then add daem=
on=20
>   to osdmap)
> * osd: fix spurious `misdirected op' messages
> * osd: report scrub status via `pg # query'
> * rbd: fix race when watch registrations are resent
> * rbd: fix rbd image id assignment scheme (new image data objects hav=
e=20
>   slightly different names)
> * rbd: fix perf stats for cache hit rate
> * rbd tool: fix off-by-one in key name (crash when empty key specifie=
d)
> * rbd: more robust udev rules
> * rados tool: copy object, pool commands
> * radosgw: fix in usage stats trimming
> * radosgw: misc compatibility fixes (date strings, ETag quoting, swif=
t=20
>   headers, etc.)
> * ceph-fuse: fix locking in read/write paths
> * mon: fix rare race corrupting on-disk data
> * config: fix admin socket `config set' command
> * log: fix in-memory log event gathering
> * debian: remove crush headers, include librados-config
> * rpm: add ceph-disk-{activate, prepare}
>=20
> The fix for the radosgw usage trimming is incompatible with v0.48 (wh=
ich=20
> was effectively broken).  You now need to use the v0.48.1 version of=20
> radosgw-admin to initiate usage stats trimming.
>=20
> There are a range of smaller bug fixes as well.  For a complete list =
of=20
> what went into this release, please see the release notes and changel=
og.
>=20
> You can get this stable update from the usual locations:
>=20
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.newdream.net/download/ceph-0.48.1.tar.gz
> * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/maste=
r/install/debian
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
