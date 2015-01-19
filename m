From: Sage Weil <sweil@redhat.com>
Subject: wip-proxy-write and (non-idempotent) client ops
Date: Mon, 19 Jan 2015 08:50:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501190838300.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbbASQut (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Jan 2015 11:50:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zhiqiang.wang@intel.com, sjust@redhat.com, ceph-devel@vger.kernel.org

Consider:

1- primary rx client delete
     proxy delete to base pool
2- primary initiate promote (list-snaps, copy-from)
3- primary rx delete reply
4- primary tx client reply
5- socket failure drops client reply
6- primary rx promote completion (enoent), writes a whiteout
7- client resents delete
8- primary replies with ENOENT

i.e., the problem seems to be that delete is not idempotent and we can't 
tell that the same client op is what triggered the delete.

We could special case delete since that is where this is noticeable, but I 
think the bigger problem is that the op history that is used for dup op 
detection is not preserved across the cache and base tier.  That is, this 
is another variation on this ticket:

	http://tracker.ceph.com/issues/8935

I have this sinking feeling we need to properly address that problem 
before we can do the write proxying...

sage
