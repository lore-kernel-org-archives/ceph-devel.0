From: Sage Weil <sage@inktank.com>
Subject: v0.47.2 released
Date: Wed, 23 May 2012 16:17:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205231617100.15923@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1912575984-1337815064=:15923"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45014 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab2EWXRp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 19:17:45 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9DDD7BC7A5
	for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 16:17:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7A4E7BC7A5
	for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 16:17:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1912575984-1337815064=:15923
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

This point release fixes a librbd bug and a small items:

 * librbd: possible livelock with the caching enabled
 * libs3 compilation/install confusion (when building from source)
 * ceph.spec updates

You can get it from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at=C2=A0http://ceph.newdream.net/download/ceph-0.47.2.tar.gz
 * For Debian/Ubuntu packages, see=C2=A0http://ceph.newdream.net/docs/maste=
r/install/debian

sage
--557981400-1912575984-1337815064=:15923--
