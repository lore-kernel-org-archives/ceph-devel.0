From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Bug #1047 reproduced
Date: Tue, 6 Dec 2011 14:20:27 +0100
Message-ID: <201112061420.29220.a.ott@m-privacy.de>
References: <201112010937.37642.a.ott@m-privacy.de> <Pine.LNX.4.64.1112020855440.10925@cobra.newdream.net> <201112051121.51834.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:52193 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933167Ab1LFNWX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 08:22:23 -0500
In-Reply-To: <201112051121.51834.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Monday 05 December 2011 wrote Amon Ott:
> On Friday 02 December 2011 wrote Sage Weil:
> > On Fri, 2 Dec 2011, Amon Ott wrote:
> > > On Thursday 01 December 2011 you wrote:
> > > > On all four nodes of my test cluster, MDS crashes with a trace =
like
> > > > that in bug #1047. Example and ceph.conf attached. Ceph server =
side
> > > > is from git master, last commit
> > > > ce6572273943ffdca4b7dc5344152d6c35106a2d.
> > > >
> > > > MDS does not start on any node here, it reliably crashes with t=
hat
> > > > assert.
> > >
> > > Does it makes sense for you to keep the cluster in that broken st=
ate,
> > > so that we can reproduce that bug or test a potential fix? Otherw=
ise, I
> > > would recreate the Ceph filesystem to make more tests. I also hav=
e a
> > > full log of one mds from start to crash here.
> >
> > Can you attach the log to #1047 for posterity?  I'll take a quick l=
ook
> > and see if there is any further info to gain from the log.  I'm gue=
ssing
> > the actual bug occured before the crash, when the anchor table wasn=
't
> > updated properly, but there may be clues here.
>
> Log attached to the bug on Saturday. Will retry with Ceph 0.39, too.

Seems to be fixed with 0.39.

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
