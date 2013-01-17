From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Thu, 17 Jan 2013 09:37:04 +0100
Message-ID: <50F7B830.8080301@univ-nantes.fr>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com> <CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com> <CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com> <CAPYLRzje19sAjtyRq8PX2zV0=GHpnzWdqOMk04UVUaRn2T7TOg@mail.gmail.com> <CA+-7kDCODuG-mWXEHv_QFdo1Guow55dd55+yPz85hKN+5rU1Gw@mail.gmail.com> <CAPYLRzhu1Tdj_MQnVJOQj6rFpVGDyiokx9k-ysb+jpbh_3F9wA@mail.gmail.com> <CA+-7kDBDWCv=dZN1Avc+BqLfxz5KKGNMHOjZvq5D7SnM6RSjvA@mail.gmail.com> <CA+-7kDCLhNx3QQ3OUGxrKT6VJszyPuPdgceA8C-pqYZRBqKkZQ@mail.gmail.com> <50F686A2.2060901@widodh.nl> <50F6B48E.6000003@univ-nantes.fr> <CA+-7kDBMmK_SxOob1p0oibufPsCjDT1h42hyOhe=amyw8+O0tg@mail.gmail.com> <CAOx6V3YCcGX1ivkK87Lz97unyMozBGQEr8qA1dtBSHkwd=6w1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:36031 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759231Ab3AQIhG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 03:37:06 -0500
In-Reply-To: <CAOx6V3YCcGX1ivkK87Lz97unyMozBGQEr8qA1dtBSHkwd=6w1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Cc: Marcin Szukala <szukala.marcin@gmail.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Le 16/01/2013 17:56, Jeff Mitchell a =C3=A9crit :
> FWIW, my ceph data dirs (for e.g. mons) are all on XFS. I've
> experienced a lot of corruption on these on power loss to the node --
> and in some cases even when power wasn't lost, and the box was simply
> rebooted. This is on Ubuntu 12.04 with the ceph-provied 3.6.3 kernel
> (as I'm using RBD on these).
>
> It's pretty much to the point where I'm thinking of changing them all
> over to ext4 for these data dirs, as the hassle of rebuilding mons
> constantly is just not worth the trouble.
In october, I've lost a complete ceph cluster, because of a combination=
 of
a memory management bug in kernel 3.6 + a bug in XFS (another BUG) (I=20
Had 12 Nodes, replication was at 2, 5/6 machines were crashed in a row,=
=20
because of mm bug, and 2 ended with unrecoverable corruption)

so, 150 TB of data on the cluster were unrecoverable. Hopefully it was=20
only test data.

if you want the gory details see here :

http://oss.sgi.com/archives/xfs/2012-10/msg00420.html

This XFS bug was corrected in 3.0.52, 3.2.34,3.4.19,3.6.7. Dave chinner=
=20
was very quick to fix the problem.

Add the last bug, (journal not flushed properly), not yet fixed on=20
latest kernels.... I can understand your reaction...

But, believe it or not, I'm still confident with XFS. I've been using i=
t=20
for more than 10 years on TB and TB of data, and apart those recents=20
problems , XFS have been extremely good (stability, performance, crash=20
tolerance) all this time.

Not saying ext4 isn't good, but if you follow kernel developpement,=20
you'll see that it's not bug-free either...

And not speaking of btrfs which was totally unstable with ceph on my=20
last tries (6 month ago)

In fact, ceph is hammering hardware strongly, so it's very good to find=
=20
bugs in linux kernel :)


So, for the moment, i'm sticking with 3.4.25 kernel. Longterm kernel,=20
proven, stable : no mm problems, no xfs problems.


Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
