From: Sage Weil <sage@newdream.net>
Subject: some naming changes
Date: Thu, 22 Sep 2011 16:27:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109221617430.30381@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58572 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab1IVX1E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 19:27:04 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DF4BFBC717
	for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 16:27:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B3AECBC717
	for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 16:27:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've made a few adjustments in naming in the master branch:

c* -> ceph-*: The cosd, cmds, cmon, cfuse, etc. daemons and commands have 
been renamed ceph-osd, ceph-mds, ceph-fuse, etc.  You may now 'ps ax | 
grep ceph' to your heart's content.

libceph -> libcephfs: The libceph is a userspace implementation of the 
_filesystem_ interface.  Reflect that in the name.  This change will be a 
annoying for anything actually using the library, but there are a small 
number of those users at the moment, and sooner is better than later!

sage



