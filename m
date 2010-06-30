From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Wed, 30 Jun 2010 15:45:48 +0000 (UTC)
Message-ID: <i0forb$a8e$1@dough.gmane.org>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
	<Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
	<AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:41642 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab0F3Pp5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jun 2010 11:45:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OTzU3-0004xN-UO
	for ceph-devel@vger.kernel.org; Wed, 30 Jun 2010 17:45:55 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 17:45:55 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 17:45:55 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 30 Jun 2010 14:05:34 +0200 schrieb S=C3=A9bastien Paolacci:

> Hello Sage,
>=20
> It actually works better when removing the old deb pacakge;)... thank=
s!
>=20
> The "pg 0.xxxx on [] is laggy" messages have also now disappeared.
>=20
> Here is, just for information, the obtained two processes dbench outp=
ut
> (which is not so bad given the vm the system in running into): Operat=
ion
>      Count    AvgLat    MaxLat
>  ---------------------------------------- NTCreateX       1632     8.=
835
>    213.966 Close           1237     0.377   157.360 Rename           =
 73
>     24.290   195.969 Unlink           291     6.514   244.166 Qpathin=
fo=20
>       1455     4.544   237.949 Qfileinfo        311     0.233     5.7=
23
>  Qfsinfo          270     1.854   110.355 Sfileinfo        168     3.=
090
>     34.291 Find             552    11.182   192.610 WriteX          1=
076
>      4.916   409.798 ReadX           2437     0.408    61.635 LockX  =
  =20
>          4     0.011     0.017 UnlockX            4     0.006     0.0=
09
>  Flush            140     8.630   175.423
>=20
> Throughput 2.88849 MB/sec  2 clients  2 procs  max_latency=3D409.805 =
ms
>=20
> I however get the a bunch of metadata sync warnings on the cfuse side
> "10.06.30_13:16:20.556187 7f2bc5817720 client4100 fsync - not syncing
> metadata yet.. implement me"

give the kclient a try? git://ceph.newdream.net/ceph-client-
standalone.git branch unstable-backport for use with "older" kernels.



> [osd]
>        debug ms =3D 1
>        sudo =3D true
>        osd data =3D /data/osd$id
>        osd journal =3D /ceph-journal/osd$id

why not let ceph manage the whole partition without a fs inbetween ? li=
ke

osd journal =3D /dev/sdX1

(and remove "journal size")

>        filestore journal writeahead =3D true

seems to be true by default (http://ceph.newdream.net/wiki/Ceph.conf ->=
=20
filestore_journal_parallel)

- Thomas

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
