From: Sage Weil <sage@newdream.net>
Subject: v0.21.1 released
Date: Mon, 16 Aug 2010 08:04:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008160804100.16542@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38247 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab0HPPEL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Aug 2010 11:04:11 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9BE49BC699
	for <ceph-devel@vger.kernel.org>; Mon, 16 Aug 2010 08:04:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6E87EBC699
	for <ceph-devel@vger.kernel.org>; Mon, 16 Aug 2010 08:04:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We did a bugfix release for v0.21 last week.  Changes include:

    * debian and rpm packaging fixes
    * mds: fixed crash on some mds->client messages
    * mds: fix snaprealm behavior on readdir (occasional client misbehavior)
    * monmaptool: man page typo
    * rados: usage fix
    * osd: fix heartbeat to/from osds (fixing osd up/down flapping)
    * osd: fix replies to dup/committed requests (fixes client hangs)
    * librados: .hpp fix
    * cclass: fix .so loading
    * cauthtool: fix man page example for fs clients
    * fix log rotation

Relevant URLs:

    * Direct download at http://ceph.newdream.net/download/ceph-0.21.1.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

sage
