From: Sage Weil <sage@newdream.net>
Subject: Re: Circular lock / deadlock in kernel client
Date: Wed, 7 Dec 2011 08:33:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112070831250.22025@cobra.newdream.net>
References: <201111301321.47514.a.ott@m-privacy.de> <201112011724.48724.a.ott@m-privacy.de>
 <201112061421.30695.a.ott@m-privacy.de> <201112071620.42437.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1388493126-1323275605=:22025"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48533 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719Ab1LGQd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 11:33:26 -0500
In-Reply-To: <201112071620.42437.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1388493126-1323275605=:22025
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

I pushed a patch to wip-d-lock that may fix this one, but unfortunately=20
don't have time to test this very carefully right now.  Let us know if=20
that helps, or you can wait until next week.

The call path that was triggering both of these can be exercised by=20
restarting the ceph-mds daemon.  Try running your client for a bit and=20
the doing that and see if you get any more splats.

Thanks!
sage


On Wed, 7 Dec 2011, Amon Ott wrote:

> On Tuesday 06 December 2011 wrote Amon Ott:
> > Merged in and bug seems to be fixed. No more deadlock warnings today.
>=20
> Unfortunately, I got another deadlock message in the log today. Full log =
of=20
> one boot time is attached.
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
>=20
--557981400-1388493126-1323275605=:22025--
