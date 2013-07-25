From: Sage Weil <sage@inktank.com>
Subject: a few rados blueprints
Date: Thu, 25 Jul 2013 16:01:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307251556550.12830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40023 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab3GYXBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 19:01:24 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9E9EF8004F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 16:01:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6D9CB8004F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 16:01:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've added a blueprint for avoiding double-writes when using btrfs:

	http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd:_clone_from_journal_on_btrfs

This should improve throughput significantly when the journal is a file in 
btrfs.

---

Also, there's one for improving the localized read behavior:

	http://wiki.ceph.com/01Planning/02Blueprints/Emperor/librados%2F%2Fobjecter%3A_smarter_localized_reads

For example, for read-only parents of rbd clones, we may as well read from 
the replica in the same host or rack or row--whatever crush can tell 
us--and not the primary.  This is good for locality and load distribution 
when certain object sets are hot.


