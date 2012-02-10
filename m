From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about OSD recovery
Date: Fri, 10 Feb 2012 14:34:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202101431120.2943@cobra.newdream.net>
References: <CANExM-NCijMZX89Bp6wOGkLmkqKeqiqhnMJ8VKKN_QSQXnm7LA@mail.gmail.com>
 <4F333A0C.7080902@dreamhost.com> <CANExM-NOQQqshVeXnNkwSgkBCg5p3C15zA5K_1ejdy_uPucdVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-671411277-1328913253=:2943"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46946 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab2BJWeN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 17:34:13 -0500
In-Reply-To: <CANExM-NOQQqshVeXnNkwSgkBCg5p3C15zA5K_1ejdy_uPucdVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-671411277-1328913253=:2943
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Feb 2012, Henry C Chang wrote:
> =FF=FF 2012=FF=FF2=FF=FF9=FF=FF=FF=FF=FF=FF11:14=FF=FFJosh Durgin <josh.d=
urgin@dreamhost.com> =FF=FF=FF=FF=FF=FF
> > Detecting missing objects on startup is possible by looking at
> > the pg log and comparing it to the objects on disk, but this can
> > be a pretty expensive operation. The osd might also be out of
>=20
> Yeah. It can be pretty expensive, but we only do it once on startup.
> Also, since the osd has not yet joined the cluster, it shouldn't
> affect the cluster
> performance.
>=20
> > date, so it's log might be useless (for example it could have
> > divergent history that was not acked). It can't know how many
> > current objects that should be there aren't until it goes through
> > peering (to get an up to date and authoritative log) and
> > recovery (to get missing data the logs say should be there). This
> > is why scrub skips pgs that aren't active+clean. More details of
> > peering can be found at http://ceph.newdream.net/docs/latest/dev/peerin=
g/.
>=20
> Since peering only compare logs, I was thinking at least the osd should
> check the existence of the objects the log claims to have. Then, we
> would have the chance to recover the object before the pg goes active.
>=20
> Also, I like the idea of storing crc/hash alongside the object as Tv said=
=2E
> With that, we can even prevent the client from reading the corrupt data
> by checking the crc/hash on each read. (Though, the read performance
> will surely degrade.)

It would be nice.  There would be a fair bit of additional complexity to=20
do it, though.  We'd need crcs for smallish blocks, for example, to=20
minimize reading adjacent data when we modify things.  It's also sort of=20
frustrating that btrfs is doing exactly this one layer down.

On a semi-related note, we should be using hashes for scrub to avoid=20
shipping a lot of metadata over the wire for comparison.

sage

--557981400-671411277-1328913253=:2943--
