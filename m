From: Sage Weil <sage@newdream.net>
Subject: v0.21.2 released
Date: Sat, 28 Aug 2010 09:52:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008280951260.17637@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47017 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab0H1Qva (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Aug 2010 12:51:30 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C22FFBC76E
	for <ceph-devel@vger.kernel.org>; Sat, 28 Aug 2010 09:52:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 82A1CBC76E
	for <ceph-devel@vger.kernel.org>; Sat, 28 Aug 2010 09:52:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a second bugfix release for the v0.21 series.  Changes include:

    * osd: less log noise
    * osd: mark down old heartbeat peers
    * filejournal: clean up init sequence, less confusing errors on 
      startup
    * msgr: fix throttler leak (fixes deadlock)
    * osdmaptool: don't crash on corrupt input
    * mds: error to client on invalid opcode
    * mds: fix ENOTEMPTY checks on rmdir
    * osd: fix race between reads and cloned objects
    * auth: fix keyring search path when $HOME not defined
    * client: fix xattr writeback
    * client: fix snap vs metadata writeback
    * osd: fix journal, btrfs throttling
    * msgr: fix memory leak on closed connections

Relevant URLs:

    * Direct download at http://ceph.newdream.net/download/ceph-0.21.2.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

The roadmap is at

    * http://tracker.newdream.net/projects/ceph/roadmap

sage
