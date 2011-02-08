From: Sage Weil <sage@newdream.net>
Subject: Re: Fixing NFS
Date: Mon, 7 Feb 2011 19:35:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102071933530.16784@cobra.newdream.net>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net> <20110203175242.GA6348@dreamer>
 <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
 <AANLkTikPRdsNFBws2wY1ZnngOoKLndCYO6Y+N05v01OG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1818780452-1297136130=:16784"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1BHDec (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 22:34:32 -0500
In-Reply-To: <AANLkTikPRdsNFBws2wY1ZnngOoKLndCYO6Y+N05v01OG@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1818780452-1297136130=:16784
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Feb 2011, Gregory Farnum wrote:
> On Mon, Feb 7, 2011 at 5:51 PM, Brian Chrisman <brchrisman@gmail.com> wro=
te:
> > I was playing around with implementing this. =A0I was trying to get the
> > ceph client's export functions to return NFS4ERR_FHEXPIRED instead of
> > ESTALE (hoping that my nfs4 clients would then attempt the full lookup
> > again). =A0I noticed also that the mds itself can also return an ESTALE
> > to the ceph kernel client, which seems to be getting propagated back
> > to the NFS client. =A0I'm wondering where I could intercept that and
> > send back an expiry notice?
>
> I don't think you want to: the MDS only returns ESTALE to the client
> if it can't find the inode, but that can happen normally if
> responsibility for the inode has been moved to another MDS. The client
> should be able to handle this circumstance and from a quick check
> that's the only way you're going to get ESTALE back from the MDS
> (unless something is horribly broken).

Normally, yes.  If the ceph client keeps the inode in its cache, it should=
=20
never get an ESTALE it can't mask (I think that'd only happen when a=20
request races with a metadata migration between MDSs).  NFS reexport is=20
the one case where that doesn't hold true, because the NFS client can hold=
=20
onto a file handle for as long as it wants and then present it back to the=
=20
server.

sage

--557981400-1818780452-1297136130=:16784--
