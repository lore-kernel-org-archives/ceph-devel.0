From: Sage Weil <sage@newdream.net>
Subject: v0.44.1 released
Date: Tue, 27 Mar 2012 20:19:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203272018290.7257@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-356731340-1332904740=:7257"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57785 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab2C1DTC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 23:19:02 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7B381BC883
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 20:19:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7006BBC883
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 20:19:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-356731340-1332904740=:7257
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi everyone,

This point release has a few important fixes:

 * osd: a few replay fixes for non-btrfs users
 * librados: resend watch operations at appropriate times
 * fix rpm builds
 * fix libnss builds

It's also worth mentioning (since several people have mentioned problems=20
on the list) that you need to do

=09git submodule init
=09git submodule update

from the source tree before you build for the first time to get the=20
correct version of leveldb.

You can get this release from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at=A0http://ceph.newdream.net/download/ceph-0.44.1.tar.gz
 * For Debian/Ubuntu packages, see=A0http://ceph.newdream.net/docs/master/o=
ps/install/mkcephfs/#installing-the-packages

sage
--557981400-356731340-1332904740=:7257--
