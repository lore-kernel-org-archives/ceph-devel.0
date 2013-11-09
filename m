From: Sage Weil <sage@inktank.com>
Subject: pending osd/rados branches
Date: Sat, 9 Nov 2013 00:25:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311082245120.4750@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab3KIIZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 03:25:50 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0641F80079
	for <ceph-devel@vger.kernel.org>; Sat,  9 Nov 2013 00:25:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0386680079
	for <ceph-devel@vger.kernel.org>; Sat,  9 Nov 2013 00:25:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are several:

wip-promote-copies (greg)
	https://github.com/ceph/ceph/pull/705
	looks good to me; my branches build on this.
	Reviewed-by: Sage Weil <sage@inktank.com>
	-> let's merge

wip-rados-list (sage)
	https://github.com/ceph/ceph/pull/710
	updates to the object list api, and some cleanup/refactoring in 
objecter.  will be needed for the agent to start iterating objects at 
random points.
	-> needs review, merge

wip-tier (sage)
	https://github.com/ceph/ceph/pull/745
	adds HitSet infrastructure and tests
	-> needs review, merge

wip-cache (sage)
	https://github.com/ceph/ceph/pull/842
	most of hte remaining bits (cache evict, flush)
	-> needs review

We should start integrating these quickly.  Unfortunately I'm not going to 
be around to go back and forth with the review over the next two weeks 
(vacation starts in 24 hrs or so and I will be only marginally available 
during that period), and I suspect there will be a fair bit of feedback on 
wip-cache in particular.  I suggest just going ahead and fixing things up 
as appropriate, or if there are burning questions about wtf any of my 
patches are doing fire me an email and sms.

A few other unrelated branches that need review/merge:

https://github.com/ceph/ceph/pull/785
https://github.com/ceph/ceph/pull/841
https://github.com/ceph/ceph/pull/798

sage
