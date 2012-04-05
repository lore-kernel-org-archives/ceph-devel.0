From: Sage Weil <sage@newdream.net>
Subject: Re: Recommended btrfs mount options
Date: Thu, 5 Apr 2012 08:11:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204050809360.2059@cobra.newdream.net>
References: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com>
 <Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net> <or39dful05.fsf@livre.localdomain>
 <Pine.LNX.4.64.1111230704560.5214@cobra.newdream.net> <4F7D9679.5050006@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1716992958-1333638664=:2059"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37576 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab2DEPLL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 11:11:11 -0400
In-Reply-To: <4F7D9679.5050006@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Alexandre Oliva <oliva@lsd.ic.unicamp.br>, Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1716992958-1333638664=:2059
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Apr 2012, Yann Dupont wrote:
> Le 23/11/2011 16:13, Sage Weil a =E9crit :
> > On Wed, 23 Nov 2011, Alexandre Oliva wrote:
> > > On Nov 22, 2011, Sage Weil<sage@newdream.net>  wrote:
> > >=20
> > > > On Tue, 22 Nov 2011, Christian Brunner wrote:
> > >=20
> > > > > - compression: I'm using lzo compression right now, as my CPUs in=
 the
> > > > > OSD nodes where idle most of the time and it is improving through=
put
> > > > > quite a bit.
> > >=20
> > > > The caveat here is that there is a corner case with inline extents =
and
> > > > the
> > > > clone ioctl that isn't implemented.
> > >=20
> > > What happens when you trigger that case?  Crash or corruption?
> > >=20
> > > I ask because I've been running with zlib compression, and I haven't
> > > noticed any problems along these lines, though I haven't got to a poi=
nt
> > > in which I'm doing more than rsyncing whole trees into the filesystem
> > > yet.
> >=20
> > Took another look at this.  The ioctl will return EINVAL from
> > fs/btrfs/ioctl.c:2416:
> >=20
> > =09=09=09=09if (comp&&  (skip || trim)) {
> > =09=09=09=09=09ret =3D -EINVAL;
> > =09=09=09=09=09btrfs_end_transaction(trans, root);
> > =09=09=09=09=09goto out;
> > =09=09=09=09}
> >=20
> > If os/FileStore.cc::_do_clone_range() sees EINVAL, it falls back to doi=
ng
> > a copy.  That may not be ideal in some cases, but at least it's
> > "correct".  For example,
> >=20
> > 0-8192 compressed inline
> > 8192-100MB normal extent
> >=20
> > and we clone 4k - 100MB, and get EINVAL, we ideally wouldn't fall back =
to
> > naively copying 100MB.  For RBD, those blocks are 4MB by default, so it=
's
> > not a big deal.
> >=20
> > So you should be okay here.
> >=20
> > sage
> >=20
>=20
> So, right now, in recent ceph versions (Using 0.44.1 for the moment), doe=
s
> using compress=3Dlzo in btrfs IS considered stable ?

Yes, it's safe.  We fall back to a manual copy if we see EINVAL from the=20
ioctl.

sage
--557981400-1716992958-1333638664=:2059--
