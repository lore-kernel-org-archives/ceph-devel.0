From: Sage Weil <sage@newdream.net>
Subject: Re: v0.24.2 released
Date: Thu, 27 Jan 2011 15:25:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101271119360.27554@cobra.newdream.net>
References: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
 <AANLkTinzcKg+ntYhqojh9H+nviinpsbZ20CR283OfMp7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-803363157-1296156007=:27554"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46406 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab1A0XZF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jan 2011 18:25:05 -0500
In-Reply-To: <AANLkTinzcKg+ntYhqojh9H+nviinpsbZ20CR283OfMp7@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1101271524540.27554@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-803363157-1296156007=:27554
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1101271524541.27554@cobra.newdream.net>

On Wed, 26 Jan 2011, Henry Chang wrote:
> Hi Sage,
>=20
> Is there any plan to update ceph-client-standalone recently?

I updated -standalone and the backport branches, but there is currently a=
=20
problem with the new alloc_workqueue stuff I don't have time right now to=
=20
sort out.

Thanks!
sage


>=20
> Thanks,
> Henry
>=20
> 2011/1/26 Sage Weil <sage@newdream.net>:
> > This is a bugfix release. =A0Changes since v0.24.1 include:
> >
> > =A0* osd: fix journal ordering bug/crash
> > =A0* osd: fix long sync delay
> > =A0* osd: don't overflow journal size
> > =A0* osd: snapshot trimming bugs
> > =A0* osd: fix messenger connection issues after restart
> > =A0* osd: don't crash on no-journal case
> > =A0* mds: fix double-pinning of stray inodes (crash)
> > =A0* mds: don't block signals after restart
> > =A0* mds: fix journaling of root inode layout policy
> > =A0* mds: fix journal dump
> > =A0* mds: C_Gather locking fix
> > =A0* msgr: fix connection cleanup on non-daemons
> > =A0* monclient: fix locking
> >
> > Relevant URLs:
> >
> > =A0* Direct download at: http://ceph.newdream.net/download/ceph-0.24.2.=
tar.gz
> > =A0* For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/=
Debian
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
>=20
>=20
>=20
> --=20
> Henry Chang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-803363157-1296156007=:27554--
