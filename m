From: Sage Weil <sage@newdream.net>
Subject: v0.22.2 released
Date: Sat, 30 Oct 2010 15:18:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010301515140.29414@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43094 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab0J3WOo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Oct 2010 18:14:44 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E58FDBC6C6
	for <ceph-devel@vger.kernel.org>; Sat, 30 Oct 2010 15:18:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AF797BC6C6
	for <ceph-devel@vger.kernel.org>; Sat, 30 Oct 2010 15:18:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.22.2 is out with a few minor bug fixes:

  * cfuse: fix truncation problem
  * osd: fix decoding of legacay (0.21) coll_t
  * osd: handle missing objects on snap reads
  * filestore: escape xattr chunk names 

Relevant URLs:

  * Direct download at: http://ceph.newdream.net/download/ceph-0.22.2.tar.gz
  * For Debian packages, see http://ceph.newdream.net/wiki/Debian

sage
