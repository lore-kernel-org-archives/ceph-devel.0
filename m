From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: wip-proxy-write and (non-idempotent) client ops
Date: Tue, 20 Jan 2015 07:04:36 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348979125@SHSMSX101.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1501190838300.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63381 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbbATHEk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 02:04:40 -0500
In-Reply-To: <alpine.DEB.2.00.1501190838300.26676@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Do we have any proposed solutions for this problem? Copy the needed info from base tier to cache tier during promotion? I see it has been there for over 6 months.

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Tuesday, January 20, 2015 12:51 AM
To: Wang, Zhiqiang; sjust@redhat.com; ceph-devel@vger.kernel.org
Subject: wip-proxy-write and (non-idempotent) client ops

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

i.e., the problem seems to be that delete is not idempotent and we can't tell that the same client op is what triggered the delete.

We could special case delete since that is where this is noticeable, but I think the bigger problem is that the op history that is used for dup op detection is not preserved across the cache and base tier.  That is, this is another variation on this ticket:

	http://tracker.ceph.com/issues/8935

I have this sinking feeling we need to properly address that problem before we can do the write proxying...

sage
