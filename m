From: Sage Weil <sage@inktank.com>
Subject: emperor leftovers
Date: Thu, 7 Nov 2013 07:05:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311070659420.17943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42526 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab3KGPFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 10:05:13 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 810008044E
	for <ceph-devel@vger.kernel.org>; Thu,  7 Nov 2013 07:05:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7EC308044E
	for <ceph-devel@vger.kernel.org>; Thu,  7 Nov 2013 07:05:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are several blueprints that were put together for emperor even 
though we didn't have the developer time to actually do them.  For anyone 
interested in getting involved in Ceph development, these may present an 
easy way to get involved in the process.  If you're interested in 
adopting any of these orphan blueprints, speak up and we can make sure it 
gets onto the firefly CDS schedule.

In (very) approximate order of difficulty:

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Source_tree_restructuring
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_shared_read_cache
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_namespace_support
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_copy-on-read_for_clones
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds%3A_dumpability
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd%3A_clone_from_journal_on_btrfs
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds%3A_reduce_memory_consumption

sage
