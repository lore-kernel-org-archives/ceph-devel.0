From: Sage Weil <sage@newdream.net>
Subject: Re: Bug #1047 reproduced
Date: Fri, 2 Dec 2011 08:57:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112020855440.10925@cobra.newdream.net>
References: <201112010937.37642.a.ott@m-privacy.de> <201112021217.10054.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2103562668-1322845044=:10925"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56797 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab1LBQ5Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2011 11:57:25 -0500
In-Reply-To: <201112021217.10054.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2103562668-1322845044=:10925
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 2 Dec 2011, Amon Ott wrote:
> On Thursday 01 December 2011 you wrote:
> > On all four nodes of my test cluster, MDS crashes with a trace like tha=
t in
> > bug #1047. Example and ceph.conf attached. Ceph server side is from git
> > master, last commit ce6572273943ffdca4b7dc5344152d6c35106a2d.
> >
> > MDS does not start on any node here, it reliably crashes with that asse=
rt.
>=20
> Does it makes sense for you to keep the cluster in that broken state, so =
that=20
> we can reproduce that bug or test a potential fix? Otherwise, I would=20
> recreate the Ceph filesystem to make more tests. I also have a full log o=
f=20
> one mds from start to crash here.

Can you attach the log to #1047 for posterity?  I'll take a quick look and=
=20
see if there is any further info to gain from the log.  I'm guessing the=20
actual bug occured before the crash, when the anchor table wasn't updated=
=20
properly, but there may be clues here.

Thanks!
sage


>=20
> Amon Ott
> --=20
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Am K=F6llnischen Park 1    Fax: +49 30 24342336
> 10179 Berlin             http://www.m-privacy.de
>=20
> Amtsgericht Charlottenburg, HRB 84946
>=20
> Gesch=E4ftsf=FChrer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
>=20
> GnuPG-Key-ID: 0x2DD3A649
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2103562668-1322845044=:10925--
