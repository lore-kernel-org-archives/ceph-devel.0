From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: wip-proxy-write and (non-idempotent) client ops
Date: Wed, 21 Jan 2015 02:16:46 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489792FD@SHSMSX101.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1501190838300.26676@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C5348979125@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1501200702380.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47887 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbbAUCQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 21:16:57 -0500
In-Reply-To: <alpine.DEB.2.00.1501200702380.26676@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Is it sufficient to only preserve the list of osd_reqid_t? It's able to match dup ops. But it can't tell if the op is already completed, acked or still undergoing.

However, maybe we could say these ops have completed since they are from the base tier and we just do a RWORDERED promotion. That is, all the ops before initiating the promotion have completed in base tier, and all the ops after initiating the promotion are requeued after the promotion. Sounds right?

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Tuesday, January 20, 2015 11:06 PM
To: Wang, Zhiqiang
Cc: sjust@redhat.com; ceph-devel@vger.kernel.org
Subject: RE: wip-proxy-write and (non-idempotent) client ops

On Tue, 20 Jan 2015, Wang, Zhiqiang wrote:
> Do we have any proposed solutions for this problem? Copy the needed 
> info from base tier to cache tier during promotion? I see it has been 
> there for over 6 months.

Yeah...

1. keep a list of osd_reqid_t's in each object_info_t and match against that for dup ops (i forget if the patch for this already went in?).  
there should probably be a tunable for the max list len and age cutoff.

2. preserve that list on copy-from when a flag is specified so that we preserve it for both promote and flush.

sage


> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Tuesday, January 20, 2015 12:51 AM
> To: Wang, Zhiqiang; sjust@redhat.com; ceph-devel@vger.kernel.org
> Subject: wip-proxy-write and (non-idempotent) client ops
> 
> Consider:
> 
> 1- primary rx client delete
>      proxy delete to base pool
> 2- primary initiate promote (list-snaps, copy-from)
> 3- primary rx delete reply
> 4- primary tx client reply
> 5- socket failure drops client reply
> 6- primary rx promote completion (enoent), writes a whiteout
> 7- client resents delete
> 8- primary replies with ENOENT
> 
> i.e., the problem seems to be that delete is not idempotent and we can't tell that the same client op is what triggered the delete.
> 
> We could special case delete since that is where this is noticeable, but I think the bigger problem is that the op history that is used for dup op detection is not preserved across the cache and base tier.  That is, this is another variation on this ticket:
> 
> 	http://tracker.ceph.com/issues/8935
> 
> I have this sinking feeling we need to properly address that problem before we can do the write proxying...
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
