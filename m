From: Sage Weil <sage@newdream.net>
Subject: Re: Fixing NFS
Date: Thu, 10 Feb 2011 11:03:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102101059310.31178@cobra.newdream.net>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net> <20110203175242.GA6348@dreamer>
 <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
 <Pine.LNX.4.64.1102071931140.16784@cobra.newdream.net>
 <AANLkTikwSntg4R2tZ5wME-M7ZKXT0SXjZK28Dxci7D-f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-742046726-1297364595=:31178"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52939 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab1BJTCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Feb 2011 14:02:11 -0500
In-Reply-To: <AANLkTikwSntg4R2tZ5wME-M7ZKXT0SXjZK28Dxci7D-f@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-742046726-1297364595=:31178
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Feb 2011, Brian Chrisman wrote:
> On Mon, Feb 7, 2011 at 7:33 PM, Sage Weil <sage@newdream.net> wrote:
> ...
> >
> > I believe the only place an actual MDS call is exposed to an NFS export=
 is
> > in export.c's __cfh_to_dentry(). =A0This is where the ino search is goi=
ng to
> > need to get more sophisticated (at least on the client side).
> >
> > An ESTALE from the MDS generally means the starting ino in the request
> > isn't in the cache. =A0You can try all MDSs for one that has it. =A0Bey=
ond
> > that, we'll need to implement more smarts on the server side!
> >
> > sage
> >
>=20
> With further testing, I tracked this down to ESTALEs indeed being
> returned from __cfh_to_dentry().
> I'm guessing this is because it has been flushed from the MDS cache,
> as my max mds is 1 and it hasn't failed/migrated.
>=20
> It looks like CEPH_MDS_OP_LOOKUPHASH is failing to find the dentry...
> I was hoping to see how the rest of the kernel client implements
> lookup when LOOKUPHASH fails, but it looks like only export.c is using
> that operation.  Is it possible to perform a full lookup (past the
> cache) of a file from a cfh?  Would appreciate pointers on
> implementation.

The idea with LOOKUPHASH is to take a dir ino, dentry hash, and ino, and=20
try to locate it on the MDS.  The MDS will (currently) start with the dir=
=20
(if it has it; otherwise ESTALE, what you're seeing), find the right=20
directory fragment based on the dentry hash, and then look for the given=20
ino in that dir frag.

We can improve LOOKUPHASH to leverage the directory object backpointers on=
=20
the MDS to make the dir location reliable.  That shoud eliminate ESTALE=20
for everything except the case where the file was renamed to a new=20
directory and then dropped out of caches.  Good enough, I hope?

> I also noticed that NFS4ERR_FHEXPIRED is not referenced anywhere in
> the kernel (particularly nfs client), so I'm guessing support for
> filehandle expiry is quite a ways off.
>=20
> Another question: I'd like to reproduce this error more quickly by
> reducing the mds cache size.  I wanted to confirm 'mds_cache_size' is
> what i'm looking for... and that I'd set it in the mds stanza of the
> config with 'mds cache size =3D ####'?

Right.  You'll also want to reduce the size of the journal so that the=20
dirty inodes are flushed to the dir objects more quickly (so they can be=20
expired).  'mds log max segments =3D 2' should be okay.  You'll need to=20
scribble some other metadata to fill up the journal and make the item you=
=20
care about get flushed/trimmed.

sage

--557981400-742046726-1297364595=:31178--
