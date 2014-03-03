From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-brag ready
Date: Mon, 3 Mar 2014 15:35:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403031528410.17314@cobra.newdream.net>
References: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com> <alpine.DEB.2.00.1402150942070.17892@cobra.newdream.net> <6FD0B3B6-DA32-4EBD-A807-2DDA3388E345@enovance.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-748641576-1393889733=:17314"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35194 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaCCXfe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 18:35:34 -0500
In-Reply-To: <6FD0B3B6-DA32-4EBD-A807-2DDA3388E345@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-748641576-1393889733=:17314
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sebastien,

Good seeing you last week in Frankfurt!

I meant to follow up earlier (or hack on this a bit myself) but haven't=20
had time.  After taking a look, my wish list here would be:

- simplify the 'bytes' info to just be bytes.

- maybe prefix these all with 'num_'

- for crush_types, make it a map of type to count, so we can tell how man=
y=20
racks/rows/hosts/etc there are.

- i wouldn't include the pool names in the pool metadata; that is probabl=
y=20
too sensitive.

- but, we can include 'type' (replicated|erasure) and change 'rep_size' t=
o=20
'size' (which is a more general name)

- for sysinfo, i would remove nw_info entirely?  not sure what this would=
=20
be for, but generally if there is any identifying info people will not=20
want to use this

- for all the other metadata, i wonder if it would be better to break it=20
down into a histogram (like the crush types) with a value and count, so=20
that we just see how many of each version/distro/kernel/os/arch/cpu/etc=20
are running.  unless people think it would be useful to see how they=20
correlate?

In general, it seems like the more compact the info is, the easier and=20
more likely it is for a person to look at it, see it is safe to share, an=
d=20
then do so.

Thanks!
sage




On Sun, 16 Feb 2014, Sebastien Han wrote:

> Sorry for the late response Sage..
> As discussed on IRC, LGPL is fine.
>=20
> Thanks for taking care of this :)
>=20
> Cheers.
> =96=96=96=96=20
> S=E9bastien Han=20
> Cloud Engineer=20
>=20
> "Always give 100%. Unless you're giving blood.=94=20
>=20
> Phone: +33 (0)1 49 70 99 72=20
> Mail: sebastien.han@enovance.com=20
> Address : 10, rue de la Victoire - 75009 Paris=20
> Web : www.enovance.com - Twitter : @enovance=20
>=20
> On 15 Feb 2014, at 18:43, Sage Weil <sage@inktank.com> wrote:
>=20
> > On Wed, 12 Feb 2014, Sebastien Han wrote:
> >> Hi guys,
> >>=20
> >> First implementation of the ceph-brag is ready.
> >> We have a public repo available here, so can try it out.
> >>=20
> >> https://github.com/enovance/ceph-brag
> >>=20
> >> However I don=92t have any idea on how to submit this to github.com/=
ceph.
> >> Can someone help me on that?
> >=20
> > I'm merging this into ceph.git now (src/brag/{client, server}).  I do=
n't=20
> > see Signed-off-by lines on the commits, though, or an indication of w=
hat=20
> > the license is.  Can you confirm whether this should be LGPL or MIT o=
r=20
> > whatever?
> >=20
> > Thanks!
> > sage
>=20
>=20
--557981400-748641576-1393889733=:17314--
