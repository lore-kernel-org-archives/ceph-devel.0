From: Sage Weil <sage@newdream.net>
Subject: bug tracker status
Date: Fri, 21 Oct 2011 11:16:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110211109040.20281@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55328 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1JUSQK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2011 14:16:10 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 114B5BC8D2
	for <ceph-devel@vger.kernel.org>; Fri, 21 Oct 2011 11:16:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DCAFDBC8D2
	for <ceph-devel@vger.kernel.org>; Fri, 21 Oct 2011 11:16:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I added a few new statuses to the tracker:

 - Need More Info (e.g. logs, core, whatever)
 - Verified

The problem I was having was keeping track of which bugs needed more info, 
which ones someone was actively trying to reproduce, and then which ones 
had been reproduced and had logs. 

Once it is in Need More Info, if it's assigned to a person that means they 
are actively working on/responsible for getting that info (e.g., 
reproducing with logs or core).  It can then move back to Verified (and 
clear the assignee).  Then someone can pick it up and continue on to In 
Progress etc.

That leaves us with open states

 New
 Verified
 Need More Info
 In Progress
 Feedback
 Testing

and closed states

 Resolved
 Closed
 Won't Fix
 Rejected
 Can't reproduce
 Duplicate

There is still a Feedback state which has no clear meaning for me...

sage

