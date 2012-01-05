From: Sage Weil <sage@newdream.net>
Subject: osd out states
Date: Wed, 4 Jan 2012 16:06:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201041557470.17055@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33655 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360Ab2AEAGL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2012 19:06:11 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DFB5FBC93F
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2012 16:06:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B71BBBC93F
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2012 16:06:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I pushed branch wip-osd-out-states that adds a few new osd state bits to 
the osdmap:

 * CEPH_OSD_AUTOOUT: osd was marked out automatically by the monitor 
because it was down for too long
 * CEPH_OSD_NEW: osd is new and has never been marked in

Both are implicitly cleared when the osd_weight becomes non-zero (i.e. 
when they are no longer out).  The AUTOOUT is set by the monitor when it 
automatically marks the osd out.

There are then some new monitor options to go along with

 * mon osd auto mark in (default true): mark osd in when it boots
 * mon osd auto mark auto out in (default true): mark AUTOOUT osd in when 
it boots
 * mon osd auto mark new in (default true): mark NEW osd in when it boots

I would imagine an admin might want the first to be false (so that an osd 
they mark out stays out, even if the daemon restarts).  In fact, we should 
make that default to false, I think.  This is true for the teuthology 
thrashing tests, which explicity control the up/down and in/out state of 
OSDs.

For a new cluster, you want new osds to automatically get data.  For an 
existing cluster, you might want that off, so that when you bring a new 
rack of storage online you can explicitly control when you want to start 
using it (i.e., not necessarily when you first boot things up).

The autoout one will likely ways be true, since it is probably safe to 
automatically mark something in that we automatically marked out.

Anyway, comments welcome!

sage

