From: Sage Weil <sage@newdream.net>
Subject: Re: ceph and ext4
Date: Mon, 14 Nov 2011 12:03:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111141157500.29742@cobra.newdream.net>
References: <4EC10664.1080501@tuxadero.com>
 <CAMvP8PAuBbG_hcgjD+WJGRFo=p59Um3HAAoRN5zjuRPWjsLh1A@mail.gmail.com>
 <4EC118A1.1030008@tuxadero.com> <CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1043169808-1321301005=:29742"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46303 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119Ab1KNUD0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 15:03:26 -0500
In-Reply-To: <CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Martin Mailand <martin@tuxadero.com>, Tomasz Paszkowski <ss7pro@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1043169808-1321301005=:29742
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Nov 2011, Gregory Farnum wrote:
> On Mon, Nov 14, 2011 at 5:33 AM, Martin Mailand <martin@tuxadero.com> wro=
te:
> > Hi Tomasz,
> > as far as I know it still has this limit.
> > But it should be relatively safe to use it.
> >
> > http://marc.info/?l=3Dceph-devel&m=3D131942130322957&w=3D2
> >
> > If we hit the 4KB limit of xattrs in ext4 how does it show up in the rb=
d
> > layer?
> >
> > How does it show up in the fs layer, would the fs still be clean?
>=20
> Right now it would show up very badly, unfortunately. (And yes, the
> limit is still there.) You'd notice, though you might manage to
> corrupt some of your data first. :/

Well, the osd's are now more careful about being fail-stop, so if they hit=
=20
the xattr limit they crash.  So there won't be data corruption per se,=20
except that you won't be able to start the OSD up again because the=20
journal replay will keep hitting the limit.

> However, if you're not taking snapshots and you're not using xattrs
> yourself, you won't hit it with rbd or the Ceph FS.

Right.  Nothing sets large xattrs on objects in rbd.  For the file system,=
=20
this would only happen on extremely (!) deeply nested directories (ceph=20
dfs xattrs are managed by the MDS, not as object attrs).

sage


> -Greg
>=20
> >
> > -martin
> >
> >
> > Am 14.11.2011 14:09, schrieb Tomasz Paszkowski:
> >>
> >> what about limit on xattr size ? Is it still limited to 4KB ?
> >>
> >>
> >>
> >> On Mon, Nov 14, 2011 at 1:15 PM, Martin Mailand<martin@tuxadero.com>
> >> =A0wrote:
> >>>
> >>> Hi Christian,
> >>> I am not sure if you noticed, but your ext4 bug is fixed in mainline.=
 I
> >>> am
> >>> running a ceph cluster with 40+ vms for over a week by now, without a=
ny
> >>> problems. An fsck.ext4 shows the ext4 is clean.
> >>> The performance of ext4 is much better than btrfs, no rise in the loa=
d of
> >>> the osd's.
> >>>
> >>> -martin
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >>
> >>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1043169808-1321301005=:29742--
