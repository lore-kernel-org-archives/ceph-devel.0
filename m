From: Sage Weil <sage@inktank.com>
Subject: Re: cephx auth question
Date: Tue, 12 Jun 2012 11:15:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206121114100.6742@cobra.newdream.net>
References: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
 <Pine.LNX.4.64.1206120942040.6742@cobra.newdream.net>
 <CAMmJxtJaS3dXtkLXkieS6Z_8y+L56JCfBdfOoxy3NhpQqPEWtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1567536011-1339524903=:6742"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49447 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab2FLSPV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 14:15:21 -0400
In-Reply-To: <CAMmJxtJaS3dXtkLXkieS6Z_8y+L56JCfBdfOoxy3NhpQqPEWtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1567536011-1339524903=:6742
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Jun 2012, John Axel Eriksson wrote:
> Thanks alot for your input Sage!
>=20
> I get a feeling that this is good for a larger cluster, especially
> when you have many people logging in - some without root access.
> We are currently a VERY small company (two people have logins and root
> access - noone else has a login at all). We've been running
> another distributed object storage solution for quite some time which
> has no authentication whatsoever and it has worked just fine for
> us. Now we're looking for a replacement since we're not entirely happy
> with our current solution - it hasn't been entirely stable and we've
> lost data twice.
>=20
> I guess we could simply start off without authentication and later on
> enable it if we do need it. Is that relatively easy to do in a running
> cluster?

Yes.  The doc linked below outlines the steps that will be needed.

> Also is there a good place where I could read up on exactly what
> happens if an OSD or something else fails? For example with the
> default two replicas - will that data be copied to another OSD if one
> fails, do I have to manually do anything, can I read the data as long
> as there is one copy somewhere?

http://ceph.com/docs/master/ops/manage/failures/

has lots of information about managing and diagnosing failures.  If there=
=20
are gaps, please let us know!

sage


>=20
> john
>=20
> On Tue, Jun 12, 2012 at 6:56 PM, Sage Weil <sage@inktank.com> wrote:
> > A few things that Wido missed:
> >
> > On Tue, 12 Jun 2012, John Axel Eriksson wrote:
> >
> >> I asked a similar question in a previous email but I didn't get any
> >> satisfying answers. What exactly does cephx auth secure?
> >> >From the wiki I just get "this makes your cluster more secure", well
> >> from what? If I run on an internal network accessible only
> >> by a few trusted people - what does cephx auth secure in such a scenar=
io?
> >
> > There is some very preliminary docs at
> >
> > =A0 =A0 =A0 =A0http://ceph.com/docs/wip-auth/ops/manage/security/
> >
> > Basically:
> >
> > =A0* mutual authentication between client and server
> > =A0* capabilities limiting what clients are allowed to do
> >
> > But:
> >
> > =A0* no encryption of over-the-wire communications
> > =A0* no protection from hijacked TCP sessions (although simpler
> > =A0 man-in-the-middle attacks aren't possible)
> >
> >> In that previous email I got the answer that it secures the cluster
> >> from mistakenly connecting to wrong cluster with rados and
> >> accidentally deleting a pool... well, can rados really "accidentally"
> >> connect to the wrong cluster?
> >
> > The client can accidentally connect to the wrong cluster if fed the
> > wrong monitor address or config.
> >
> >> Only if I have the wrong config
> >> file right? And if I have the wrong config-file won't it be possible
> >> that I also have the "wrong" key in that case?
> >
> > Yes.
> >
> > That said, daemons are careful to validate the cluster fsid before
> > communicating regardless of whether cephx is enabled or not.
> >
> > You *can* put fsid =3D ... in the config file, but the client side isn'=
t
> > validating it currently, and that won't help if you point at the wrong
> > config file.
> >
> >> Another scenario would be if I take down an OSD that just sits in
> >> storage for say 6 months and then someone starts that machine
> >> again - with key-based auth that OSD wouldn't be able to
> >> connect(somehow? but if it has a working key?) but without auth it
> >> could
> >> possibly connect and wreak havoc in the cluster (since it is so much
> >> behind perhaps in both version of software and what's stored on it).
> >> I thought marking and OSD as down or out would do that?
> >
> > Marking out manually will prevent the osd from being marked in
> > automatically, but it will still start up and 'join' the cluster.
> > However, whenever there is an incompatible change, we bump protocol
> > numbers or add feature fits, so it shouldn't be able to do any damage.
> >
> > I think the main motivation is to prevent a non-root user from, say,
> > deleting your data pool, or to limit such 'admin' activity to a select
> > number of nodes (e.g., the monitor hosts).
> >
> > sage
> >
> >> Are those the main reasons for having cephx auth? Is it to secure the
> >> cluster against people (myself included) making mistakes or =A0from
> >> hacking, or is there some technical reason that I don't know of or und=
erstand?
> >>
> >> The reason I'm asking is because having cephx enabled makes cluster
> >> setup much more complicated...
> >>
> >>
> >> Thanks,
> >>
> >> John
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1567536011-1339524903=:6742--
