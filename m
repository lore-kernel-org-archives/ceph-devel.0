From: Sage Weil <sage@newdream.net>
Subject: v0.29.1 released
Date: Thu, 16 Jun 2011 15:28:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106161525360.29922@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44338 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab1FPWZx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2011 18:25:53 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 35593BC77D
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2011 15:28:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 12E36BC77D
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2011 15:28:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've released 0.29.1 with a few fixes.  The main thing is a fix for a 
race condition in librbd that was biting people using rbd with qemu/kvm.  
There was also a fixed memory leak in the OSD.  The shortlog is below.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/downloads/ceph-0.29.1.tar.gz
 * Debian/Ubuntu packages: see http://ceph.newdream.net/wiki/Debian



Greg Farnum (1):
      man: update cosd man page to include info on flush-journal option.

Josh Durgin (3):
      librbd: fix AioCompletion race condition
      librbd: add AioCompletion debugging
      librbd: fix block_completion race condition

Sage Weil (5):
      moncaps: whitespace
      mon: weaken pool creation caps check
      Makefile: remove ancient comment
      mkcephfs: fix ceph.conf reference
      v0.29.1

Sam Lang (2):
      Fix segfault caused by invalid argument string.
      Fix typo in usage output for --num-osds

Samuel Just (2):
      ReplicatedPG: make_writeable, use correct size for clone_size entry
      PG: clear scrub_received_maps in scrub_clear_state

