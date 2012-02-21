From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph 0.42: Cannot make RPM from spec-file (unpackaged file
 ceph-dencoder)
Date: Tue, 21 Feb 2012 13:02:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202211300550.20783@cobra.newdream.net>
References: <4008345.82nISvLeLu@pc10> <Pine.LNX.4.64.1202211107120.30694@cobra.newdream.net>
 <CAF3hT9AF=xb-rJ=JWWxspsbQSCeFGWwu+MKETC5YeC54h9ZVAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-356705784-1329858156=:20783"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36112 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2BUVCj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 16:02:39 -0500
In-Reply-To: <CAF3hT9AF=xb-rJ=JWWxspsbQSCeFGWwu+MKETC5YeC54h9ZVAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-356705784-1329858156=:20783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Feb 2012, Gregory Farnum wrote:
> On Tue, Feb 21, 2012 at 11:07 AM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 21 Feb 2012, Guido Winkelmann wrote:
> >> Hi,
> >>
> >> With Ceph 0.42, I am unable to create an RPM from supplied spec-file.
> >>
> >> When running rpmbuild -ba ceph-0.42/ceph.spec, the command fails at th=
e end
> >> with this:
> >>
> >> Checking for unpackaged file(s): /usr/lib/rpm/check-files
> >> /root/rpmbuild/BUILDROOT/ceph-0.42-6.fc14.x86_64
> >> error: Installed (but unpackaged) file(s) found:
> >> =A0 =A0/usr/bin/ceph-dencoder
> >>
> >>
> >> RPM build errors:
> >> =A0 =A0 Installed (but unpackaged) file(s) found:
> >> =A0 =A0/usr/bin/ceph-dencoder
> >>
> >> I could get it to build anyway by including the line
> >>
> >> %{_bindir}/ceph-dencoder
> >>
> >> in the files section of the spec file.
> >
> > Adding ceph-dencoder (and man page) to the .deb and .rpm now. =A0Thanks=
!
>=20
> Wouldn't it be better to only install those with the ceph-devel
> packages? Users won't ever want those binaries.

It's useful for general debugging, e.g. examing xattrs on filestore=20
objects.  We don't really have a separate package for extraneous optional=
=20
tools, though.  I was just going to lump it into ceph-common with all the=
=20
other command line tools.

sage
--557981400-356705784-1329858156=:20783--
