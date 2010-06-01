From: Sage Weil <sage@newdream.net>
Subject: subdir quotas
Date: Tue, 1 Jun 2010 12:17:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006011206040.14408@cobra.newdream.net>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
 <Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
 <l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
 <Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
 <m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
 <w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1469970337-1275419827=:14408"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52832 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab0FATQy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 15:16:54 -0400
In-Reply-To: <w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1469970337-1275419827=:14408
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

The subject of quota enforcement came up in the IRC channel last week so I=
=20
thought I'd resurrect this discussion.

> > On Fri, 30 Apr 2010, Henry C Chang wrote:
> > > In fact, I am trying to add "folder quota support" to ceph right now.
> > > My rough idea is as below:
> > >
> > > (1) Store the quota limit in the xattr of the folder;
> > > (2) When the client requests a new max size for writing content to a =
file,
> > > MDS authorizes the request according to the quota and the rstat of th=
e
> > > folder.
> >
> > One thing to keep in mind is that because the recursive rsize info is
> > lazily propagated up the file tree, this won't work perfectly. =A0If yo=
u set
> > a limit of 1GB on /foo and are writing data in /foo/bar/baz, it won't s=
top
> > you right at 1GB. =A0Similarly, if you hit the limit, and delete some s=
tuff,
> > it will take time before the MDS notices and lets you start writing aga=
in.
> >
> Hmm... this would be a problem....
> From the perspective of a user, I would be happy if I can write more=20
> than my quota. However, I would get pissed off if I have deleted some=20
> stuff but still cannot write anything and don't know how long I have to=
=20
> wait.
>=20
> Is it possible to force MDS to propaget rsize info when files are deleted=
?
> Or, can lazy propagation be bounded to a maximum interval (say 5 seconds)=
?

The propagation is bounded by a tunable timeout (30 seconds by default,=20
but adjustable).  That's per ancestor.. so if you're three levels deep,=20
the max is 3x that.  In practice, it's typically less, though, and I think=
=20
we could come up with something that would force propagation to happen=20
faster in these situations.  The reason it's there is just to limit the=20
overhead of maintaining the recursive stats.  We don't want to update all=
=20
ancestors every time we change something, and because we're distributed=20
over multiple nodes we can't.

> > What is your use case?
>
> I want to create "depots" inside ceph:
> - Each depot has its own quota limit and can be resized as needed.
> - Multiple users can read/write the same depot concurrently.
>=20
> My original plan is to create a first-level folder for each depot
> (e.g., /mnt/ceph/depot1, /mnt/ceph/depot2, ...) and set quota on it.
> Do you have any suggestion on implementing such a use case?

There's no reason to restrict this to first-level folders (if that's what=
=20
you were suggesting).  We should allow a subdir quota to be set on any=20
directory, probably iff you are the owner.  We can make the user interface=
=20
based on xattrs, since that's generally nicer to interact with than an=20
ioctl based interface.  That's not to say the quota should necessarily be=
=20
handled/stored internally as an xattr (although it could be).  It might=20
make more sense to add a field to the inode and extend the client/mds=20
protocol to manipulate it.

Either way, I think a coarse implementation could be done pretty easily,=20
where by 'coarse' I mean we don't necessarily stop writes exactly at the=20
limit (they can write a bit more before they start getting ENOSPC).

On IRC the subject of soft quotas also came up (where you're allowed over=
=20
the soft limit for some grace period before writes start failing).  That's=
=20
also not terribly difficult to implement (we just need to store some=20
timestamp field as well so we know when they initially cross the soft=20
threashold).

Are you still interested in working on this?

sage
--557981400-1469970337-1275419827=:14408--
