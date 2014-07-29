From: Sage Weil <sweil@redhat.com>
Subject: giant and hammer dates
Date: Tue, 29 Jul 2014 16:11:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54696 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaG2XLF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 19:11:05 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7B1BF800BB
	for <ceph-devel@vger.kernel.org>; Tue, 29 Jul 2014 16:11:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5164A800BB
	for <ceph-devel@vger.kernel.org>; Tue, 29 Jul 2014 16:11:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've talked a bit about moving to a ~4 month (instead of 3 month) 
cadence.  I'm still inclined in this direction because it means fewer 
stable releases that we will be maintaining and a longer and (hopefully) 
more productive interval to do real work in between.

The other key point is that we don't want a repeat of the firefly delay.  
I think we should stay as close to a train model as we can.  If something 
isn't ready by freeze, let it wait for the next cycle.  We shouldn't be 
cramming things in at the end, especially big things.  As a general rule, 
big things should be merged early in the cycle so that we have lots of 
time to shake out the issues that only come out of lots of testing and 
aren't obvious from code review.

Anyway, how about:

          Freeze         Approx Release
  Giant   Mon Sep  1     Mon Sep 29
  Hammer  Mon Jan  4     Mon Feb  2

That gives us another month for Giant, then September to shake out 
anything issues.  And then three full months before the Hammer freeze.

What say ye?
sage
