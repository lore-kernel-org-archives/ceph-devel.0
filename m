From: Wido den Hollander <wido@42on.com>
Subject: Re: Expose pool quota for Libvirt
Date: Fri, 05 Dec 2014 10:05:47 +0100
Message-ID: <5481756B.6050301@42on.com>
References: <CACKLxkC0Xy1AShOK=cfo1F+-OJnus74KPWSgWubduhjY0+YVow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:60774 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbaLEJFu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Dec 2014 04:05:50 -0500
In-Reply-To: <CACKLxkC0Xy1AShOK=cfo1F+-OJnus74KPWSgWubduhjY0+YVow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Logan Barfield <lbarfield@tqhosting.com>, ceph-devel@vger.kernel.org

On 12/03/2014 05:39 PM, Logan Barfield wrote:
> I'm not sure if this is already in place, but if not I think pool quotas
> should be exposed in the same way as pool size so Libvirt can pick up on
> them.
> 

Yes, that would be ideal indeed.

> We currently run several KVM hypervisors backed by Ceph RBD.  We have a
> CRUSH ruleset that defines SSD backed servers for RBD, and high capacity
> HDD backed servers for RadosGW.
> 
> Right now when adding our RBD pool via Libvirt it sees the entire cluster's
> capacity, even though the actual pool capacity is much lower.  This means
> that any deployment tools that look at the available capacity when creating
> VMs can't be relied upon, and we have to continually track usage manually
> (we audit it anyway, but that should be in addition to built-in checks).
> We can currently work around this by manually setting the capacity in the
> deployment tool, but fixing it at the source seems like a much better
> option.
> 
> Obviously capacity can't be automatically estimated from the CRUSH ruleset,
> but with the recent addition of pool quotas it would be useful to let
> Libvirt (and other clients) pull the quota size so we could set them as
> needed.
> 
> Some changes will need to be made on the Libvirt side as well, but the
> functionality has to be implemented in Ceph first.
> 

The main problem here is that I currently don't see a way in librados to
fetch this information.

rados_pool_stat_t in librados.h does not expose a quota or anything
similar. So what currently happens is that Libvirt does a cluster stat()
in librados and fetches how large the cluster is.

If librados exposes a way to get the quota from a pool it would be very
simple to fix this in Libvirt.

> I have opened an issue in the tracker for this:
> http://tracker.ceph.com/issues/10226
> 

I'll assign this to myself.

> If this functionality already exists I'll close the issue and work on
> things from the Libvirt side.
> 
> 
> Thank You,
> 
> Logan Barfield
> Tranquil Hosting
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
