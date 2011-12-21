From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Bug #1047 reproduced
Date: Wed, 21 Dec 2011 17:36:24 +0100
Message-ID: <201112211736.25725.a.ott@m-privacy.de>
References: <201112010937.37642.a.ott@m-privacy.de> <201112211337.44363.a.ott@m-privacy.de> <CAF3hT9AHa_7WNx+x5qf0iHwmphWu1LLfR-9NUvFjVScZy94JqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:46966 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab1LUQgn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2011 11:36:43 -0500
In-Reply-To: <CAF3hT9AHa_7WNx+x5qf0iHwmphWu1LLfR-9NUvFjVScZy94JqA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Alexandre Oliva <oliva@lsd.ic.unicamp.br>

On Wednesday 21 December 2011 wrote Gregory Farnum:
> On Wed, Dec 21, 2011 at 4:37 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > On Friday 02 December 2011 wrote Sage Weil:
> >> On Fri, 2 Dec 2011, Amon Ott wrote:
> >> > On Thursday 01 December 2011 you wrote:
> >> > > On all four nodes of my test cluster, MDS crashes with a trace=
 like
> >> > > that in bug #1047. Example and ceph.conf attached. Ceph server=
 side
> >> > > is from git master, last commit
> >> > > ce6572273943ffdca4b7dc5344152d6c35106a2d.
> >> > >
> >> > > MDS does not start on any node here, it reliably crashes with =
that
> >> > > assert.
> >> >
> >> > Does it makes sense for you to keep the cluster in that broken s=
tate,
> >> > so that we can reproduce that bug or test a potential fix? Other=
wise,
> >> > I would recreate the Ceph filesystem to make more tests. I also =
have a
> >> > full log of one mds from start to crash here.
> >>
> >> Can you attach the log to #1047 for posterity? =A0I'll take a quic=
k look
> >> and see if there is any further info to gain from the log. =A0I'm =
guessing
> >> the actual bug occured before the crash, when the anchor table was=
n't
> >> updated properly, but there may be clues here.
> >
> > Did you find some time to look into this? The bug makes Ceph unusab=
le for
> > us even with moderate load. All mds instances die with the same ass=
ert,
> > the only way to recover in that state is to recreate the complete c=
eph fs
> > and restore backups.
>
> Sage is gone on vacation right now (unless he decides not to be for a
> while), but we've been focusing our efforts on the OSDs lately so I
> don't think he's looked at it. I'll see if I can carve out some time
> tomorrow or Friday, but I can't promise anything.
>
> Alexandre, can you check this bug and make sure it looks like the sam=
e
> one you reported as #1850?

Thank you for looking into it. The behaviour in #1850 looks quite simil=
ar to=20
our bug, apart from the hardlinks. We copy many files here in our tests=
, too.=20
Last time I hit the bug I had really restarted the master mds.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
