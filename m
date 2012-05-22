From: Sage Weil <sage@inktank.com>
Subject: v0.47.1 released
Date: Mon, 21 May 2012 20:49:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205212048530.6377@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1799250133-1337658566=:6377"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48259 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2EVDt3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 23:49:29 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DC606BC98C
	for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 20:49:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id ACAE2BC98C
	for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 20:49:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1799250133-1337658566=:6377
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

There was a problem with v0.47 that prevented new OSDs from detecting=20
xattr support properly. =A0We've released v0.47.1 to resolve this issue. =
=A0If=20
you've installed v0.47, and plan to create new OSDs, you should upgrade.

You can get v0.47.1 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at=A0http://ceph.newdream.net/download/ceph-0.47.1.tar.gz
 * For Debian/Ubuntu packages, see=A0http://ceph.newdream.net/docs/master/i=
nstall/debian
--557981400-1799250133-1337658566=:6377--
