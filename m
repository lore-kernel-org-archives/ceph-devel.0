From: Sage Weil <sage@newdream.net>
Subject: Re: Circular lock / deadlock in kernel client
Date: Thu, 1 Dec 2011 08:12:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112010812090.18236@cobra.newdream.net>
References: <201111301321.47514.a.ott@m-privacy.de>
 <Pine.LNX.4.64.1111300919520.28417@cobra.newdream.net>
 <Pine.LNX.4.64.1111300952290.28417@cobra.newdream.net>
 <201112010916.09576.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-962192031-1322755944=:18236"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34793 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab1LAQM1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2011 11:12:27 -0500
In-Reply-To: <201112010916.09576.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-962192031-1322755944=:18236
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Dec 2011, Amon Ott wrote:
> On Wednesday 30 November 2011 wrote Sage Weil:
> > I pushed a wip-i-ceph-lock branch to ceph-client.git that replaces our
> > (ab?)use of i_lock with a new i_ceph_lock in the ceph inode.  This avoi=
ds
> > being bitten by the lock ordering constraint imposed by igrab(), which
> > requires i_lock to safely take a reference to an inode without racing w=
ith
> > inode destruction.  This lets us keep two inode list locks logically
> > ordered inside i_ceph_lock (with i_lock as an inner lock).
>=20
> I see the branch, but there is nothing new in it. Is that the right locat=
ion?=20
> Maybe forgot to push?
>=20
> https://github.com/NewDreamNetwork/ceph-client/tree/wip-i-ceph-lock

Oops, I pushed the wrong branch.  It's there now.

Sorry!
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
--557981400-962192031-1322755944=:18236--
