From: Sage Weil <sage@inktank.com>
Subject: v0.47.3 released
Date: Wed, 20 Jun 2012 21:56:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206202155380.28982@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1917140879-1340254583=:28982"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52070 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2FUE4h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 00:56:37 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E664BBC934
	for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 21:56:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C1EBFBC934
	for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 21:56:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1917140879-1340254583=:28982
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

This is a bugfix release with one major fix and a few small ones:

 * osd: disable use of the FIEMAP ioctl by default as its use was leading=
=20
   to corruption for RBD users
 * a few minor compile/build/specfile fixes

I was going to wait for v0.48, but that is still several days away. =A0If=
=20
you are using RBD in production, you should either add

=09filestore fiemap =3D false

to your ceph.conf file or upgrade.

You can get this release from the usual places, with the exception of=20
Debian sid and wheezy packages; the upstream repos were sufficiently=20
broken to make pbuilder cranky so I left them out.

 * Git at git://github.com/ceph/ceph.git
 * Tarball at=A0http://ceph.newdream.net/download/ceph-0.47.3.tar.gz
 * For Debian/Ubuntu packages, see=A0http://ceph.newdream.net/docs/master/i=
nstall/debian

--557981400-1917140879-1340254583=:28982--
