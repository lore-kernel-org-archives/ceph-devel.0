From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: 4 new compiler warnings (ceph.git/unstable)
Date: Wed, 28 Jul 2010 05:13:31 +0000 (UTC)
Message-ID: <i2oe9r$feu$1@dough.gmane.org>
References: <i2ndfm$ck$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60665 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab0G1FNn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Jul 2010 01:13:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Odyxa-0000Ca-6Z
	for ceph-devel@vger.kernel.org; Wed, 28 Jul 2010 07:13:42 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jul 2010 07:13:42 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jul 2010 07:13:42 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Tue, 27 Jul 2010 19:53:27 +0000 schrieb Thomas Mueller:

> hi
>=20
> there are new compiler warnings:

>  ./include/encoding.h:80: warning: =E2=80=98e.LeaseStat::duration_ms=E2=
=80=99 may be
>  used uninitialized in this function
>=20
> <snip>
>=20
> mds/Locker.cc:2251: note: =E2=80=98e.LeaseStat::duration_ms=E2=80=99 =
was declared here
>=20
> <snip>
>=20
>=20
> ./include/encoding.h:80: warning: =E2=80=98e.LeaseStat::seq=E2=80=99 =
may be used
> uninitialized in this function
>=20
> <snip>
>=20
> mds/Locker.cc:2251: note: =E2=80=98e.LeaseStat::seq=E2=80=99 was decl=
ared here

all gone today - thanks for fixing!

- Thomas

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
