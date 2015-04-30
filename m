From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/10] rbd: distribute scsi pr info through rbd class
 calls
Date: Thu, 30 Apr 2015 00:56:55 -0700
Message-ID: <20150430075655.GA3400@infradead.org>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
 <1430258747-12506-11-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41645 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbbD3H44 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 03:56:56 -0400
Content-Disposition: inline
In-Reply-To: <1430258747-12506-11-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org

On Tue, Apr 28, 2015 at 05:05:47PM -0500, mchristi@redhat.com wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
> 
> This stores the LIO PR info in the rbd header. Other
> clients (LIO nodes) are notified when the data changes,
> so they can update their info.
> 
> I added a sysfs file to test it here temporarily. I will
> remove it in the final version. The final patches will
> have a LIO callout call the rados locking and these
> functions instead.

So this is just an RFC and you'll have a real interface later?

I'd be curious what you're planning there as I'll need something similar
for the pNFS scsi-layouts client which will call into the block device
to ask for persistent reservations.
