From: Sage Weil <sage@inktank.com>
Subject: scrub/snaptim io prio session
Date: Thu, 30 Oct 2014 13:42:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410301340500.16007@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47827 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513AbaJ3UmY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 16:42:24 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CCC7780068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:42:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 90AA480068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:42:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These tickets already exist:

7862 allow backfill/reads while below min_size (in progress)
7861 allow writes on degraded objects
3360 osd: Prevent primary from choosing a pg_temp that violates the crush rule spirit

I added

9952 osd: smarter choice of primary to minimize recovery disruption


