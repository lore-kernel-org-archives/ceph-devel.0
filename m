From: Sage Weil <sage@newdream.net>
Subject: Re: rados import/export
Date: Mon, 30 Apr 2012 14:08:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204301406120.32303@cobra.newdream.net>
References: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
 <Pine.LNX.4.64.1204301348170.3920@cobra.newdream.net>
 <CAORUGqD=neAYCH2qPZTF6oG=V4yNKhfupXoViAbV5TiR0Qfotg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1893867592-1335820139=:32303"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50701 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab2D3VJB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 17:09:01 -0400
In-Reply-To: <CAORUGqD=neAYCH2qPZTF6oG=V4yNKhfupXoViAbV5TiR0Qfotg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1893867592-1335820139=:32303
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 30 Apr 2012, Tommi Virtanen wrote:
> On Mon, Apr 30, 2012 at 13:50, Sage Weil <sage@newdream.net> wrote:
> > The real question here is how *should* we be storing omap values when w=
e
> > export to/import from regular files? =A0A specially-marked (with xattr)=
 .db
> > file?
>=20
> Does just adding a .db suffix make the name safe? If yes, xattr is not
> needed; if no, it's not enough. Reading src/rados_export.cc and
> src/rados_sync.cc, I see nothing like that. What if I have objects
> "foo" and "foo.db" in a pool?

I'm pretty sure we need to mark the object with a magic xattr.  Which=20
probably means the filename itself needs to be mangled to avoid colliding=
=20
with other objects.  Probably an xattr on the object file referring to the=
=20
external mangled file with the k/v content.

> Note to self: the only thing avoiding collisions for e.g. "foo/" and
> "foo$" is the hash.

I vaguely recall Colin talking about the trailing /, but we may have=20
decided to ignore the problem for now.

> > A related problem is how to store placement key strings for objects wit=
h
> > modified placement; I can't remember if we already did something for th=
at
> > yet or not (maybe specially-named xattr?).
>=20
> Commit 717621f66eb7da54c0000ff52985235dc6a17843, combined with nothing
> else touching src/rados_export.cc after it, makes me think we don't
> preserve the locator.

Ok, we should fix that at the same time, then.

sage

--557981400-1893867592-1335820139=:32303--
