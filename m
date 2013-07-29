From: Sage Weil <sage@inktank.com>
Subject: blueprint: mds memory efficiency
Date: Sun, 28 Jul 2013 21:06:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307282058080.12925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44991 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3G2EGg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 00:06:36 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E1A5F8004F
	for <ceph-devel@vger.kernel.org>; Sun, 28 Jul 2013 21:06:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BD73B8004F
	for <ceph-devel@vger.kernel.org>; Sun, 28 Jul 2013 21:06:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One of the current problems with the ceph MDS is that the in-memory inode, 
dentry, and dir structures (CInode, CDentry, CDir) are quite large.  They 
contain lots of fields for tracking the somewhat complicated lifecycle 
that modified metadata takes before it is fully committed.

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds:_reduce_memory_consumption

This is an interesting project for someone who wants to get invovled in 
the MDS C++ without having to immediate make difficult design decisions.  
It will have a big impact on the memory (and subsequently cache) 
performance but is mostly about following and enforcing good C++ coding 
practices.

sage
