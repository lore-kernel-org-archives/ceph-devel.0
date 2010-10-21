From: Sage Weil <sage@newdream.net>
Subject: handling lost objects
Date: Thu, 21 Oct 2010 16:41:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010211631150.27821@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46680 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab0JUXis (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Oct 2010 19:38:48 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2A086BC7C5
	for <ceph-devel@vger.kernel.org>; Thu, 21 Oct 2010 16:41:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E21BDBC7C5
	for <ceph-devel@vger.kernel.org>; Thu, 21 Oct 2010 16:41:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If you have an unfortunate series of OSD failures, you can get into a 
situation where you know that objects were modified, but weren't able to 
copy the data off of the OSDs that contained them before they failed.  
Or, you only have what are (at least potentially) stale copies, but the 
OSDs with the most recent copies are down and declared (by an 
administrator) "lost" and irretrieable.

The current strategy is/was to go through and log LOST events for any 
object for which we have no copy.  Essentially it is treated like a 
delete... the object is gone.  For objects where we have an old version of 
the data, a LOST_REVERT event would be logged and we'd revert back to the 
old content (this second case isn't implemented yet).

I wonder if a better strategy would be to _not_ delete the objects, but to 
create a placeholder, and mark it such that any attempts to read it return 
EIO or ESTALE or something along those lines.  That would let an 
application know when data is gone instead of 'silently' (well, at the 
behest of a desperate administrator) losing the data.  Things like remove 
and replace would succeed, but reads would not.  Stale objects could then 
always be removed on a per-object basis.

The other nice thing about this is currently the peering phase stalls 
until it locates all lost objects.  But we know exactly which objects 
those are, and can go active (allowing IO to the rest of the PG) and stall 
only requests for those objects (until they are located or declared lost).  
(Actually, we can make this change regardless of whether we decide to mark 
or silently delete/revert.)

Any thoughts here?

sage

