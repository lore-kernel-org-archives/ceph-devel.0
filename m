From: Sage Weil <sage@inktank.com>
Subject: osd scrub/repair at CDS
Date: Thu, 30 Oct 2014 13:40:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410301339370.15946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47810 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513AbaJ3Uku (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 16:40:50 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 99C7480068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:40:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DC1C680068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:40:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I created these tickets:

9947 osd: store scrub error state in kv store; clear on peering event 
9948 osd: add scrub result query interface
9949 librados: add ability to read a specific replica or shard
9950 rados: add ability to read a specific replica/shard from CLI
9951 librados, osd: per-object scrub operation

They are near the top of the backlog.

sage
