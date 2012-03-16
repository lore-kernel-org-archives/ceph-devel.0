From: Sage Weil <sage@newdream.net>
Subject: Re: Hadoop on ceph
Date: Fri, 16 Mar 2012 08:37:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net>
References: <4F623EB9.1000901@genome.wustl.edu>
 <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1183373253-1331912273=:31380"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48305 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031171Ab2CPPhx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 11:37:53 -0400
In-Reply-To: <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1183373253-1331912273=:31380
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Andrey,

On Fri, 16 Mar 2012, Andrey Stepachev wrote:

> Ceph has a several problems right now:
> a) due of strict posix sematics ceph can't handle high throughput.
> it very eays to hit max iops (even if we on tmpfs with journal)

If I had to guess I wouldn't suspect the POSIX/metadata stuff initially,=20
as that generally doesn't get in the way of data iops (although it's=20
possible).  I take it TestDSFIO is a standard hadoop benchmark?  I=20
continue to be annoyed and frustrated that we don't have a java/hadoop=20
person in-house to work on this stuff (hint hint,=20
http://ceph.newdream.net/jobs).  I hope we can carve some resources out to=
=20
work on this stuff soon.

> b) broken timestamps.  in my case it affected HBase HLog functionality,
> so it is possible to not recover after fail.

I take it this the same problem Noah was seeing? =20
(http://tracker.newdream.net/issues/1666) =20

Thanks!
sage


>=20
> For 6 nodes cluster (I use xfs, because btrfs degrades on high volumes)
>=20
> Ceph 0.43 (from my github)
> ------------------------------------------------------------------
>            Date & time: Thu Mar 01 18:38:16 MSK 2012
>        Number of files: 36
> Total MBytes processed: 360000
>      Throughput mb/sec: 2.8411840839866644
> Average IO rate mb/sec: 2.8668723106384277
>  IO rate std deviation: 0.29681573660544924
>     Test exec time sec: 3991.457
>=20
>=20
> Original hadoop
> ------------------------------------------------------------------
> ----- TestDFSIO ----- : write
>            Date & time: Thu Mar 01 14:08:53 MSK 2012
>        Number of files: 36
> Total MBytes processed: 360000
>      Throughput mb/sec: 4.59152733368745
> Average IO rate mb/sec: 4.596996784210205
>  IO rate std deviation: 0.16118933245583172
>     Test exec time sec: 2313.589
>=20
> 2012/3/15 Matt Weil <mweil@genome.wustl.edu>:
> >> http://ceph.newdream.net/wiki/Using_Hadoop_with_Ceph
> >
> >
> > What are the plans going forward.
> >
> > Are there any benchmarks out there between HDFS and ceph?
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --=20
> Andrey.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1183373253-1331912273=:31380--
