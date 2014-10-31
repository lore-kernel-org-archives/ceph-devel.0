From: Sage Weil <sage@inktank.com>
Subject: deprecation warning: object 'category'
Date: Fri, 31 Oct 2014 09:44:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410310942460.21851@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53457 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaJaQog (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Oct 2014 12:44:36 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0482C80068
	for <ceph-devel@vger.kernel.org>; Fri, 31 Oct 2014 09:44:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CCDDF80068
	for <ceph-devel@vger.kernel.org>; Fri, 31 Oct 2014 09:44:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is an undocumented and (to my knowledge) unused feature that lets 
you specify a category for an object on creation, and totals up the pool
stats on a per-category basis.  We originally were going to use this for 
RGW bug opted for something more manageable.

We plan to kill it because it can potentially bloat the pg stat 
structures in an unbounded way.

If you're a librados user and making use of this feature, speak now, 
or expect it to be gone in hammer!

sage


