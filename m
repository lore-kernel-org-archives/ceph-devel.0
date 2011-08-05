From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Re: Monitors fallen apart
Date: Fri, 5 Aug 2011 15:34:58 +0200
Message-ID: <201108051534.58799.szekelyi@niif.hu>
References: <201108031116.37824.szekelyi@niif.hu> <CAC-hyiG0zsd1LZGnWhqAfbwgotz7p3SuU+j=doLyC035rq-V3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:53471 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216Ab1HENfF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2011 09:35:05 -0400
In-Reply-To: <CAC-hyiG0zsd1LZGnWhqAfbwgotz7p3SuU+j=doLyC035rq-V3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 2011. August 4. 20:14:54 Yehuda Sadeh Weinraub wrote:
> 2011/8/3 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> > I'm running ceph 0.32, and since a while it looks like if a monitor
> > fails, then the cluster doesn't find a new one.
> >=20
> > I have three nodes, two with cmds+cosd+cmon, and one with cmds+cmon=
,
> > which is also running the client. If I stop one of the cmds+cosd+cm=
on
> > nodes, ceph -w run on the cmds+cmon node tells nothing but
> >=20
> > 2011-08-03 11:10:47.291875 7f4f043d5700 -- <client_ip>:0/14633 >>
> > <killed_node_ip>:6789/0 pipe(0x1a7f9c0 sd=3D4 pgs=3D0 cs=3D0 l=3D0)=
=2Efault first
> > fault
> >=20
> > infinitely and the filesystem stops working (processes using files =
in it
> > block forever). Looks like it rties to connect to the killed monito=
r
> > instead of failing over to a working one.
> >=20
> > The first message after killing the node was:
> >=20
> > 2011-08-03 10:57:40.687871 7f4f01563700 monclient: hunting for new =
mon
> >=20
> > Do you have any idea what I'm doing wrong?
>=20
> Do you have the mon logs, or any core files?

No, and I nuked my ceph cluster since then, because I realized that the=
 monmap=20
was kinda screwed up. When I ran the client with the -m option, it repo=
rted=20
errors that it's unable to connect to some strange hostnames with binar=
y=20
characters in it. I guess it got broken in the tortures I've put my clu=
ster=20
under.

I'll report if I experience anything like this with the fresh cluster.

Thanks,
--=20
cc

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
