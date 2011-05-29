From: Sage Weil <sage@newdream.net>
Subject: v0.28.2 released
Date: Sun, 29 May 2011 16:57:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105291657220.9134@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1E2X4K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 May 2011 19:56:10 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B0396BC728
	for <ceph-devel@vger.kernel.org>; Sun, 29 May 2011 16:57:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 86828BC728
	for <ceph-devel@vger.kernel.org>; Sun, 29 May 2011 16:57:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've tagged v0.28.2, which includes several bugs fixed over the past 
week.  These include:

 * mds: crash on unlink (uninitialized variable)
 * mds: fix for multiclient writer vs stat hang
 * mds: tolerate ENOENT on journal prezeroing
 * osd: disable automatic marking of objects as lost (paranoia)
 * osd: fix race on pg activation (crash)
 * mkcephfs: fix for mon setup

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.28.2.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian
