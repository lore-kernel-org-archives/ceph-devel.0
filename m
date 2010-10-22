From: Sage Weil <sage@newdream.net>
Subject: Re: handling lost objects
Date: Thu, 21 Oct 2010 17:41:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010211739540.11295@cobra.newdream.net>
References: <Pine.LNX.4.64.1010211631150.27821@cobra.newdream.net>
 <AANLkTimdhDv_Xd5JanvOhso08GN9DbUVv59LZukSqKN-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1290084607-1287708118=:11295"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42839 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab0JVAi6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Oct 2010 20:38:58 -0400
In-Reply-To: <AANLkTimdhDv_Xd5JanvOhso08GN9DbUVv59LZukSqKN-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1290084607-1287708118=:11295
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Oct 2010, Colin McCabe wrote:
> On Thu, Oct 21, 2010 at 4:41 PM, Sage Weil <sage@newdream.net> wrote:
> > I wonder if a better strategy would be to _not_ delete the objects, but=
 to
> > create a placeholder, and mark it such that any attempts to read it ret=
urn
> > EIO or ESTALE or something along those lines. =A0That would let an
> > application know when data is gone instead of 'silently' (well, at the
> > behest of a desperate administrator) losing the data. =A0Things like re=
move
> > and replace would succeed, but reads would not. =A0Stale objects could =
then
> > always be removed on a per-object basis.
>=20
> It sounds promising. I wonder what the metadata servers should do if
> they get an ESTALE?

They should probably pass it back to the user, in one form or another. =20
For now at least it's can be treated the same as EIO or ENOENT.

> Others using the object store would probably appreciate the
> flexibility of being able to read other objects which didn't get lost.
>=20
> We probably want to make the "ceph health" command comment about lost
> objects if they exist.

Right.  The pg_stat_t structure can be extended to include lost objects=20
(if it doesn't already), so that it can be included in the pool and system=
=20
totals on the monitors.

sage

--557981400-1290084607-1287708118=:11295--
