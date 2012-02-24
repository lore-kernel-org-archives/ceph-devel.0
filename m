From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Stale NFS file handle
Date: Fri, 24 Feb 2012 13:25:19 +0100
Message-ID: <2429388.3pIa2XVQLM@mranderson>
References: <7386587.xNpCPNsyj0@mranderson> <2047170.AK8tFQQFuI@mranderson> <CAORUGqBO2Y7XMLbHb1z0s3b-H0H_Tpb1gwQwf2mpi+mgQ5EObA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:58574 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227Ab2BXMZa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 07:25:30 -0500
In-Reply-To: <CAORUGqBO2Y7XMLbHb1z0s3b-H0H_Tpb1gwQwf2mpi+mgQ5EObA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 2012. February 23. 10:43:02 Tommi Virtanen wrote:
> 2012/2/13 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> >> Okay, that sounds like a bug then.  The two interesting things wou=
ld
> >> be a ceph-fuse log (--debug-client 10 --debug-ms 1 --log-file
> >> /path/to/log) and an mds log (debug mds =3D 20, debug ms =3D 1 in =
[mds]
> >> section of ceph.conf).>=20
> > Thanks, I've set it up, now waiting for it to break. ;)
>=20
> Anything new here? Did you manage to capture logs of the problem?

No, not yet. I suspect that it was not a result of static operation, bu=
t was=20
related to some cluster change (nodes going up & down), what hasn't hap=
pened=20
since then. I'm still keeping an eye on it.

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
