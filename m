From: Sage Weil <sage@newdream.net>
Subject: Re: support for multiple data placement policies
Date: Thu, 2 Sep 2010 07:47:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009020745380.9344@cobra.newdream.net>
References: <AANLkTin8GVQfPmV0d3xGThEMPYeRMKYuCR1b6Fk5XPre@mail.gmail.com>
 <AANLkTi=K3ASGMoN1DTkQu-hqMzXm43eVyb64LhEqgxRC@mail.gmail.com>
 <Pine.LNX.4.64.1009011320280.9613@cobra.newdream.net>
 <AANLkTi=yYL2PZFZvQaS7ySbhmaSEDrrEhJbwBpU7TaXW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1280049253-1283438859=:9344"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33394 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab0IBOqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Sep 2010 10:46:38 -0400
In-Reply-To: <AANLkTi=yYL2PZFZvQaS7ySbhmaSEDrrEhJbwBpU7TaXW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: H Chang <heracles@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1280049253-1283438859=:9344
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 1 Sep 2010, H Chang wrote:
> Thanks Greg and Sage for your replies.
>=20
> Sage's suggestion seems more doable to me.
> With custom file layout policy, each file would potentially be able to
> use a customized CRUSH rule.
>=20
> I see that the feature is planned for v0.22.
> Out of curiosity, what will be an interface for specifying such a
> policy?  Use xattr?

That's the current thinking.  We haven't settled on anything specific yet. =
=20
There is also an ioctl to set the layout of an individual file.  The xattr=
=20
value could be that struct, with a name like 'ceph.default_file_layout'. =
=20

sage

>=20
> Best regards,
> HS
>=20
> On Wed, Sep 1, 2010 at 4:28 PM, Sage Weil <sage@newdream.net> wrote:
> > On Wed, 1 Sep 2010, Gregory Farnum wrote:
> >
> >> On Wed, Sep 1, 2010 at 11:33 AM, H Chang <heracles@gmail.com> wrote:
> >> > Hi Ceph team,
> >> >
> >> > I'm a newbie in Ceph, so please bear with me if my question sounds s=
tupid.
> >> >
> >> > I'd like to explore the possibility to support multiple placement
> >> > policies in Ceph.
> >
> > Some of the infrastructure is there for this. =A0Each file has a layout=
,
> > which specifies the striping strategy and which storage pool the file d=
ata
> > gets stored. =A0Each pool has a field specifying which CRUSH rule set t=
o use
> > (they can share).
> >
> >> > For example, suppose each user using Ceph has its own placement poli=
cy
> >> > which may be different from one user to another.
> >
> > Creating a pool for each user may be overkill, however. =A0The intentio=
n was
> > for pools and/or crush rules to be defined for things like "fast sas
> > disks", "slow sata pool", that sort of thing. =A0Currently everything i=
s
> > thrown in a single data pool.
> >
> > Currently the default file layout is compiled in and applies to all new
> > files. =A0There is an open bug/issue for specifying the default file la=
youts
> > on a directory basis (e.g, everthing in /home goes into this pool,
> > everything in /scratch goes in that pool). =A0See
> >
> > =A0 =A0 =A0 =A0http://tracker.newdream.net/issues/185
> >
> > In any case, creating per-user pools means pushing more awareness of us=
ers
> > into the file system, autocreating pools, and that sort of thing. =A0As
> > things stand, the layout policy is something an administrator has to
> > set up.
> >
> >> But it will require changing several pretty low-level structs and
> >> modifying the metadata server and both versions of the client to
> >> enable, so it's not a good introductory project and you shouldn't
> >> expect it soon. :(
> >
> > ...for per-user pools, at least. =A0Something along the lines of issue =
#185
> > above is more doable (and on the roadmap).
> >
> > sage
> >
> >> -Greg
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1280049253-1283438859=:9344--
