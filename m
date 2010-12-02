From: Sage Weil <sage@newdream.net>
Subject: Re: Status of ceph ITP?
Date: Wed, 1 Dec 2010 22:05:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012012026250.606@cobra.newdream.net>
References: <1290365977.9821.3.camel@clint-MacBookPro>
 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
 <1290436452.9821.5.camel@clint-MacBookPro> <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
 <1291075213.14018.101.camel@julia.gcs.org.hu> <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
 <1291221518.14018.564.camel@julia.gcs.org.hu> <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
 <1291249852.14018.611.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1943029508-1291269950=:606"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab0LBGBW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 01:01:22 -0500
In-Reply-To: <1291249852.14018.611.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1943029508-1291269950=:606
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 2 Dec 2010, Laszlo Boszormenyi wrote:
> Hi Sage,
>=20
> On Wed, 2010-12-01 at 10:15 -0800, Sage Weil wrote:
> > Can you take a look at the 'testing' branch in git commit 5bdae2af? =20
> > That's how I've been doing releases, more or less.  Assuming packaging=
=20
> > issues are sorted out prior to that point, that's all that should be=20
> > needed, right?=20
>  I think I've noted that cephfs and radosacl are without manpages.
> Please write one for them. Do you have an upstream changelog somewhere?
> ChangeLog is still empty. Really minor that I write 'new upstream
> release' to debian/changelog . Otherwise it's OK for uploading.

I'm wondering if it's even worth generating a ChangeLog.  Maybe only for=20
the release tarball?  It's all in git.  I guess we can just put the old=20
debian/changelog at ChangeLog and continue summarizing the main items...

> > (BTW, the v0.23.2 bugfix release is mostly pointless as v0.24 is just a=
=20
> > couple days away anyway.  Just for the sake of illustration...)
> There's no chance that ceph will be included in Squeeze and the next
> release of Ubuntu is several months away. You have time and it's your
> decision when should I first upload ceph. Please note that Debian is in
> freeze ATM, it may need even two weeks to be accepted to the archive[1];
> and even if it's in the NEW queue, I can upload new versions into it.

Okay.  I'd mainly like to get the packaging issues sorted out so that it's=
=20
just a matter of updating on each release, and so that sid users can get=20
it.

> I'm not an ftp-master, but your package maybe rejected[2] for two
> reasons. I think only debian/copyright is not enough, all source files
> should have a comment header about their license in short. You have it
> in cephfs.cc , cfuse.cc , etc; but missing in barclass.cc , cconf.cc ,
> cls_acl.cc and in others.

Any chance you want to submit a patch?  Unless otherwise noted, everything=
=20
is LGPL2 and copyright whatever git log tells you.

> Second is that you link with OpenSSL when your
> license is (L)GPL. See their FAQ[3] and the fact that I can't find any
> upstream license file permitting that nor it's mentioned in
> debian/copyright . Also you may see the debian/copyright of my packages,
> like neon27[4]: it has a pointer to the full license file
> under /usr/share/common-licenses/ .
> On the other hand, it went into Ubuntu without any problems. Clint,
> No=E8l? Feel free to post comment on what needs to be done with ceph
> packaging to be accepted on the first round.

Hmm, yeah, that may be an issue here.  See [1] and [2].  Maybe we should=20
look at using gnutls instead of openssl.

sage

[1] http://lists.debian.org/debian-legal/2002/11/msg00253.html
[2] http://www.mail-archive.com/debian-legal@lists.debian.org/msg14110.html
--557981400-1943029508-1291269950=:606--
