From: Sage Weil <sage@newdream.net>
Subject: v0.30 released
Date: Tue, 28 Jun 2011 10:00:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106280959460.24993@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59078 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182Ab1F1Q5m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2011 12:57:42 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9958CBC6C2
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2011 10:00:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 747A3BC6C2
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2011 10:00:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We're pushing out v0.30.  Highlights include:

 * librbd: Fixed race/crash
 * mds: misc clustered mds fixes
 * mds: misc rename journaling/replay fixes
 * mds: fixed flock deadlock when processes die during lock wait
 * osd: snaptrimmer fixes, misc races, recovery bugs
 * auth: fixed cephx race/crash
 * librados: rados bench fix
 * librados: flush
 * radosgw: multipart uploads
 * debian: gceph moved to separate package
 * lots of g_conf refactoring, removing of globals, and related cleanup
 * qa: lots

The focus this time around continues to be with QA, bug fixes, and 
cleanup.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.30.tar.gz
 * Debian/Ubuntu packages: see http://ceph.newdream.net/wiki/Debian

