From: Sage Weil <sage@inktank.com>
Subject: out of order osd replies
Date: Mon, 13 Aug 2012 18:21:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208131815500.21875@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51477 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab2HNBVR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Aug 2012 21:21:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

I just tracked down what caused the out-of-order reply:

- req 1 hit a degraded object, put on waiting_for_missing_object
- pg change, NullEvt queued
- req 2 dequeued, put on waiting_on_active list
- on_change()
  - scrub_clear_state()
    - requeues waiting_on_active
  - requeues waiting_for_missing_object
...

Obvious fix for this case is to reoder the call to scrub_clear_state() in 
on_change(), but I wonder if there are other cases where scrub's use of 
waiting_for_active could break ordering.

It is probably worth mapping out what the wait lists order, where they 
overlap, and carefully define what order they need to be woken up in.  I 
suspect that re-using waiting_for_active in this case is problematic...

sage
