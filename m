From: Sage Weil <sage@newdream.net>
Subject: Re: subdir quotas
Date: Fri, 4 Jun 2010 09:42:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006040933330.2384@cobra.newdream.net>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
 <Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
 <l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
 <Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
 <m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
 <w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
 <Pine.LNX.4.64.1006011206040.14408@cobra.newdream.net>
 <AANLkTimi8lrwiblFXYJIiprfy3gCZOoGu5auL3umEqA2@mail.gmail.com>
 <Pine.LNX.4.64.1006021223590.1269@cobra.newdream.net>
 <AANLkTinsL5X_DtHbfk-tLAMW_yu2bH-Q0or_mQt7X1gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1425214679-1275669777=:2384"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42614 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab0FDQmg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 12:42:36 -0400
In-Reply-To: <AANLkTinsL5X_DtHbfk-tLAMW_yu2bH-Q0or_mQt7X1gQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1425214679-1275669777=:2384
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Jun 2010, Henry C Chang wrote:
> > preserves the current doubling logic but caps it at some value, so the
> > admin can trade throughput vs quota precision. =A0And/or we can make it=
 also
> > dynamic reduce that window as the user approaches the limit.
>=20
> Yes. But if there are multiple clients writing one subtree concurrently,=
=20
> it is a little bit difficult to say if we are approaching the limit....=
=20
> we need to know how many clients are writing to the same subtree...

I would suggest some sort of recursive 'nested_max_size_diff' accounting=20
on each mds that works similarly to the nested_* values in CInode etc. =20
Basically, fix up the cache link/unlink methods in CDir to adjust the=20
recursive counts (like the anchor and auth_pin counters), and define some=
=20
specific rules like:

 - max_size_diff for any given node is max_size - size (if max_size >=20
size)
 - nested_max_size diff is max_size_diff + sum over children, if child=20
does not have it's own recursive quota set

The accounting can initially be done local to the mds, which means the=20
extent to which clients can exceed their quota before getting shut down=20
would increase if the quota subtree spans multiple mds's.  (I don't think=
=20
that's a big deal, personally, but it depends on how strict you want to=20
be.  Later we could devise some additional mechanism that allocates=20
remaining quota space among nodes the region spans or something.)

Maybe a similar counter can simply count how many open files are=20
contributing to that sum, so you can tell a bit more about how that=20
available space should be distributed...?

> The export_dir command working well, and gives us a convenient way to tes=
t
> multi-mds scenarios. Not surprisingly, our current implementation is not
> working in mult-mds environment... :)
>=20
> My test setup:
> Under mount point, I created /volume, /volume/aaa, /volume/bbb.
>     mds0 is authoritative for /volume, /volume/aaa.
>     mds1 is authoritative for /volume/bbb.
> Quota is set on /volume: 250M
>=20
> Test case 0: pass
> cp 100M file to /volume/aaa/a0
> cp 100M file to /volume/aaa/a1
> cp 100M file to /volume/aaa/a2  =3D=3D> quota exceeded error is expected =
here
>=20
> Test case 1: pass
> cp 100M file to /volume/bbb/b0
> cp 100M file to /volume/bbb/b1
> cp 100M file to /volume/aaa/a1  =3D=3D> quota exceeded error is expected =
here
>=20
> Test case 2: failed
> cp 100M file to /volume/bbb/b0
> cp 100M file to /volume/bbb/b1
> cp 100M file to /volume/bbb/b2  =3D=3D> quota exceeded error is expected =
here
>=20
> It seems that rstat can be propagated up (from mds1 to mds0) quickly (cas=
e 1);
> however, the ancestor replica (/volume) in mds1 is not updated (case 2).
> I wonder how/when the replicas get updated. I'm still digging the source =
code
> to find where. :(

There is a Locker::scatter_nudge() function that periodically twiddles the=
=20
lock state on the subtree boundary so that the rstat information=20
propagates betweeen nodes.  There is an interval in g_conf that controls=20
how often that happens...

sage
--557981400-1425214679-1275669777=:2384--
