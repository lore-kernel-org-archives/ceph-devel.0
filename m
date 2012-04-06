From: Sage Weil <sage@newdream.net>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 10:55:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204061038430.3020@cobra.newdream.net>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
 <Pine.LNX.4.64.1204052204290.21401@cobra.newdream.net>
 <CAORUGqBq93+nWutxEAb=uWmEqCpCPCjcRKrzkTY4rRPMhfX1Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-707766596-1333734797=:3020"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52566 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab2DFRzq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 13:55:46 -0400
In-Reply-To: <CAORUGqBq93+nWutxEAb=uWmEqCpCPCjcRKrzkTY4rRPMhfX1Vw@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1204061053260.3020@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-707766596-1333734797=:3020
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1204061053261.3020@cobra.newdream.net>

On Fri, 6 Apr 2012, Tommi Virtanen wrote:
> On Thu, Apr 5, 2012 at 22:12, Sage Weil <sage@newdream.net> wrote:
> > Here's what I'm thinking:
> >
> > =A0- No data paths are hard-coded except for /etc/ceph/*.conf
> > =A0- We initially mount osd volumes in some temporary location (say,
> > =A0 /var/lib/ceph/temp/$uuid)
> > =A0- We identify the oid, cluster uuid, etc., and determine where to mo=
unt
> > =A0 it with
> >
> > =A0 =A0 =A0 =A0ceph-osd --cluster $cluster -i $id --show-config-value o=
sd_data
> >
> > =A0 This will normally give you the default, unless the conf file speci=
fied
> > =A0 something else.
> > =A0- Normal people get a default of /var/lib/ceph/$type/$id
> > =A0- Multicluster crazies put
> >
> > =A0 =A0 =A0 =A0[global]
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd data =3D /var/lib/ceph/$type/$cluste=
r-$id
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0osd journal =3D /var/lib/ceph/$type/$clu=
ster-$id/journal
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mon data =3D /var/lib/ceph/$type/$cluste=
r-$id
> >
> > =A0 (or whatever) in /etc/ceph/$cluster.conf and get something else.
> >
> > Code paths are identical, data flow is identical. =A0We get a simple ge=
neral
> > case, without closing the door on multicluster configurations, which va=
ry
> > only by the config value that is easily adjusted on a per-cluster basis=
=2E..
>=20
> Except we lost features. Now I can't iterate the contents of a
> directory and know what they mean. I think we'll need that.

Unless you infer it from the conf value or some such kludge, but that=20
would be fragile.  Okay.  I'm good with /var/lib/ceph/$type/$cluster-$id=20
then.

Hopefully we can keep things as general as possible, so that brave souls=20
can go out of bounds without getting bitten.  For example, never parse the=
=20
directory name if the same information can be had from the directory=20
contents.

Bernard, I suspect it would be pretty simple to make ceph-osd start up=20
either via -i <id> or --uuid <uuid> which would enable a uuid-based scheme=
=20
like you describe.  For these cookbooks, though, it'll be an <id>-based=20
approach.

sage
--557981400-707766596-1333734797=:3020--
