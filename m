From: Sage Weil <sage@newdream.net>
Subject: Queue for 2.6.38
Date: Thu,  3 Mar 2011 12:40:02 -0800
Message-ID: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52156 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280Ab1CCUj6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:58 -0500
Received: from localhost.localdomain (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by cobra.newdream.net (Postfix) with ESMTPA id 68CFABC69F
	for <ceph-devel@vger.kernel.org>; Thu,  3 Mar 2011 12:41:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here is the current queue for 2.6.38.  The main bummer here are the 
patches that disable I_COMPLETE caching behavior (faster ENOENT lookups 
and cached readdir) that will slow things down.  This is fallout from 
the VFS changes that turned up a problem in d_release and shone some 
light on the raciness of the current implementation.  I hope to have a  
proper fix ready for 2.6.39.  In the meantime, things will be slower.

The other patches are mostly fixes for socket error handling in the 
messenger, fallout from the switch to WQ_NON_REENTRANT mode on the 
work_queue.  This was a good thing since it replaced some fancy bit 
twiddling for mutual exclusion, but the behavior is slightly different  
because we can now queue work while con_work is still running (before we 
didn't).  

A few other small fixes are in there too.

I hope to send this to Linus in a day or two after some more testing.

sage

