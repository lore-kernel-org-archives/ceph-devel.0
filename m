From: Sage Weil <sage@newdream.net>
Subject: Re: Fixing NFS
Date: Mon, 7 Feb 2011 19:33:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102071931140.16784@cobra.newdream.net>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net> <20110203175242.GA6348@dreamer>
 <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-59741195-1297136025=:16784"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60147 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab1BHDcr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 22:32:47 -0500
In-Reply-To: <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-59741195-1297136025=:16784
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Feb 2011, Brian Chrisman wrote:
> On Thu, Feb 3, 2011 at 9:52 AM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > On Thu, Feb 03, 2011 at 09:29:32AM -0800, Sage Weil wrote:
> >> Which leaves us with a final problem: what if the fh is generated for
> >> /foo/bar, but bar is renamed to /baz/bar, bar drops out of all caches,=
 and
> >> the client tries to use the fh. =A0We're still stuck with ESTALE in th=
at
> >> case. =A0The only real solution there is to include a backpointer on t=
he
> >> file's data object. =A0This is doable, but comes at a cost. =A0We coul=
d make
> >> it optional, and/or mitigate it somewhat (backpointer is only created =
once
> >> a file is renamed, or something like that).
> >>
> >> I'm not really sure to what lengths a server is supposed to go to avoi=
d
> >> ESTALE. =A0I seem to remember that NFSv4 has a different class of fh's=
 that
> >> are allowed to expire. =A0I'm not sure how that helps, though; it seem=
s
> >> likeif a client has a file open that is renamed by another node and th=
en
> >> idle for long enough and then tries to read it'll still be screwed,
> >> regardless of what the server does/does not promise the client.
> >
> > NFSv4 volatile filehandles move away from the whole "stale"
> > terminology into "expiring" filehandles, which a client SHOULD recover
> > from, and that's said with fairly strong language in RFC3530. The
> > volatile filehandles may go away at any moment (for FH4_VOLATILE_ANY).
> >
> > The RFC suggests clients remember the full path of every volatile
> > filehandle, and points out that doesn't let you recover if someone
> > else renamed the file.. which means your "final problem" above is
> > still a problem, and smells unavoidable. But at least shifting
> > responsibility for remembering the path to the client makes recovery
> > easy in the typical case.
> >
> > If the real-world support is there, I'd say NFSv4 is the way to go,
> > for future Ceph re-exporting.
>=20
>=20
> I was playing around with implementing this.  I was trying to get the
> ceph client's export functions to return NFS4ERR_FHEXPIRED instead of
> ESTALE (hoping that my nfs4 clients would then attempt the full lookup
> again).  I noticed also that the mds itself can also return an ESTALE
> to the ceph kernel client, which seems to be getting propagated back
> to the NFS client.  I'm wondering where I could intercept that and
> send back an expiry notice?

I believe the only place an actual MDS call is exposed to an NFS export is=
=20
in export.c's __cfh_to_dentry().  This is where the ino search is going to=
=20
need to get more sophisticated (at least on the client side).

An ESTALE from the MDS generally means the starting ino in the request=20
isn't in the cache.  You can try all MDSs for one that has it.  Beyond=20
that, we'll need to implement more smarts on the server side!

sage

--557981400-59741195-1297136025=:16784--
