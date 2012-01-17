From: Sage Weil <sage@newdream.net>
Subject: wip-backfill
Date: Mon, 16 Jan 2012 17:00:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201161658340.15646@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45227 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab2AQBAh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2012 20:00:37 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@dreamhost.com
Cc: ceph-devel@vger.kernel.org

I've been hammering this with thrashing tests all day and haven't managed 
to break it.  The only thing it hasn't seen is thrashing combined with a 
rados snap workload (running now).

Sam, can you take a final look of the last few days of fixups before I 
merge this? 

Thanks!
sage
