From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Bug #1047 reproduced
Date: Mon, 5 Dec 2011 11:21:50 +0100
Message-ID: <201112051121.51834.a.ott@m-privacy.de>
References: <201112010937.37642.a.ott@m-privacy.de> <201112021217.10054.a.ott@m-privacy.de> <Pine.LNX.4.64.1112020855440.10925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:48010 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755772Ab1LEKWB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 05:22:01 -0500
In-Reply-To: <Pine.LNX.4.64.1112020855440.10925@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Friday 02 December 2011 wrote Sage Weil:
> On Fri, 2 Dec 2011, Amon Ott wrote:
> > On Thursday 01 December 2011 you wrote:
> > > On all four nodes of my test cluster, MDS crashes with a trace li=
ke
> > > that in bug #1047. Example and ceph.conf attached. Ceph server si=
de is
> > > from git master, last commit ce6572273943ffdca4b7dc5344152d6c3510=
6a2d.
> > >
> > > MDS does not start on any node here, it reliably crashes with tha=
t
> > > assert.
> >
> > Does it makes sense for you to keep the cluster in that broken stat=
e, so
> > that we can reproduce that bug or test a potential fix? Otherwise, =
I
> > would recreate the Ceph filesystem to make more tests. I also have =
a full
> > log of one mds from start to crash here.
>
> Can you attach the log to #1047 for posterity?  I'll take a quick loo=
k and
> see if there is any further info to gain from the log.  I'm guessing =
the
> actual bug occured before the crash, when the anchor table wasn't upd=
ated
> properly, but there may be clues here.

Log attached to the bug on Saturday. Will retry with Ceph 0.39, too.

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
