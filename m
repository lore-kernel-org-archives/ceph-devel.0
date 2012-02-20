From: Sage Weil <sage@newdream.net>
Subject: v0.42 released
Date: Mon, 20 Feb 2012 10:01:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1530147798-1329760915=:30602"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47663 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2BTSB4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 13:01:56 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1612DBC60D
	for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2012 10:01:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DCF7ABC60D
	for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2012 10:01:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1530147798-1329760915=:30602
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

v0.42 is ready! =A0This has mostly been a stabilization release, with a few=
=20
critical bugs fixed. =A0There is also an across-the-board change in data=20
structure encoding that is not backwards-compatible, but is designed to=20
allow future changes to be (both forwards- and backwards-).

Notable changes include:

 * osd: new (non-backwards compatible!) encoding for all structures
 * osd: fixed bug with transactions being non-atomic (leaking across=20
   commit boundaries)
 * osd: track in-progress requests, log slow ones
 * osd: randomly choose pull target during recovery (better load balance)
 * osd: fixed recovery stall
 * mon: a few recovery bug fixes
 * mon: trim old auth files
 * mon: better detection/warning about down pgs
 * objecter: expose in-process requests via admin socket
 * new infrastructure for testing data structure encoding changes (forward=
=20
   and backward compatibility)

Aside from the data structure encoding change, there is relatively little=
=20
new code since v0.41. =A0This should be a pretty solid release.

For v0.43, we are working on merging a few big changes. =A0The main one is =
a=20
new key/value interface for objects: each object, instead of storing a=20
blob of bytes, would consist of a (potentially large) set of key/value=20
pairs that can be set/queried efficiently. =A0This is going to make a huge=
=20
difference for radosgw performance with large buckets, and will help with=
=20
large directories as well. =A0There is also ongoing stabilization work with=
=20
the OSD and new interfaces for administrators to query the state of the=20
cluster and diagnose common problems.

v0.42 can be found from the usual locations:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at=A0http://ceph.newdream.net/download/ceph-0.42.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/latest/ops=
/install/mkcephfs/#installing-the-packages

sage
--557981400-1530147798-1329760915=:30602--
