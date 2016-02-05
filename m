From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: cls_rbd ops on rbd_id.$name objects in EC pool
Date: Fri, 5 Feb 2016 10:53:06 -0500 (EST)
Message-ID: <1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:45865 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbcBEPxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 10:53:09 -0500
In-Reply-To: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nick Fisk <nick@fisk.me.uk>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

#1 and #2 are awkward for existing pools since we would need a tool to inject dummy omap values within existing images.  Can the cache tier force-promote it from the EC pool to the cache when an unsupported op is encountered?  There is logic like that in jewel/master for handling the proxied writes. 

-- 

Jason Dillaman 

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "Nick Fisk" <nick@fisk.me.uk>
> Cc: "Jason Dillaman" <dillaman@redhat.com>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org
> Sent: Friday, February 5, 2016 10:42:17 AM
> Subject: cls_rbd ops on rbd_id.$name objects in EC pool
> 
> On Wed, 27 Jan 2016, Nick Fisk wrote:
> > 
> > > -----Original Message-----
> > > From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf Of
> > > Jason Dillaman
> > > Sent: 27 January 2016 14:25
> > > To: Nick Fisk <nick@fisk.me.uk>
> > > Cc: ceph-users@lists.ceph.com
> > > Subject: Re: [ceph-users] Possible Cache Tier Bug - Can someone confirm
> > > 
> > > Are you running with an EC pool behind the cache tier? I know there was
> > > an
> > > issue with the first Infernalis release where unsupported ops were being
> > > proxied down to the EC pool, resulting in that same error.
> > 
> > Hi Jason, yes I am. 3x Replicated pool on top of an EC pool.
> > 
> > It's probably something similar to what you mention. Either the client
> > should be able to access the RBD header object on the base pool, or it
> > should be flagged so that it can't be evicted.
> 
> I just confirmed that the rbd_id.$name object doesn't have any omap, so
> from rados's perspective, flushing and evicting it is fine.  But yeah, the
> cls_rbd ops aren't permitted in the EC pool.
> 
> In master/jewel we have a cache-pin function that prevents an object from
> being flushed.
> 
> A few options are:
> 
> 1) Have cls_rbd cache-pin it's objects.
> 
> 2) Have cls_rbd put an omap key on the object to indirectly do the same.
> 
> 3) Add a requires-cls type object flag that keeps hte object out of an EC
> pool *until* it eventually supports cls ops.
> 
> I'd lean toward 1 since it's simple and explicit, and when we eventually
> make classes work we can remove the cache-pin behavior from cls_rbd.
> It's harder to fix in infernalis unless we also backport cache-pin/unpin
> ops, too, so maybe #2 would be a simple infernalis workaround?
> 
> Jason?  Sam?
> sage
> 
> 
> 
> > 
> > > 
> > > --
> > > 
> > > Jason Dillaman
> > > 
> > > 
> > > ----- Original Message -----
> > > > From: "Nick Fisk" <nick@fisk.me.uk>
> > > > To: ceph-users@lists.ceph.com
> > > > Sent: Wednesday, January 27, 2016 8:46:53 AM
> > > > Subject: [ceph-users] Possible Cache Tier Bug - Can someone confirm
> > > >
> > > > Hi All,
> > > >
> > > > I think I have stumbled on a bug. I'm running Infernalis (Kernel 4.4
> > > > on the
> > > > client) and it seems that if the RBD header object gets evicted from
> > > > the cache pool then you can no longer map it.
> > > >
> > > > Steps to reproduce
> > > >
> > > > rbd -p cache1 create Test --size=10G
> > > > rbd - p cache1 map Test
> > > >
> > > > /dev/rbd1  <-Works!!
> > > >
> > > > rbd unmap /dev/rbd1
> > > >
> > > > rados -p cache1 cache-flush rbd_id.Test rados -p cache1 cache-evict
> > > > rbd_id.Test rbd - p cache1 map Test
> > > >
> > > > rbd: sysfs write failed
> > > > rbd: map failed: (95) Operation not supported
> > > >
> > > > or with the rbd-nbd client
> > > >
> > > > 2016-01-27 13:39:52.686770 7f9e54162b00 -1 asok(0x561837b88360)
> > > > AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen:
> > > > failed to bind the UNIX domain socket to
> > > > '/var/run/ceph/ceph-client.admin.asok': (17) File exists
> > > > 2016-01-27 13:39:52.703987 7f9e32ffd700 -1 librbd::image::OpenRequest:
> > > > failed to retrieve image id: (95) Operation not supported
> > > > rbd-nbd: failed to map, status: (95) Operation not supported
> > > > 2016-01-27 13:39:52.704138 7f9e327fc700 -1 librbd::ImageState: failed
> > > > to open image: (95) Operation not supported
> > > >
> > > > Nick
> > > >
> > > > _______________________________________________
> > > > ceph-users mailing list
> > > > ceph-users@lists.ceph.com
> > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > >
> > > _______________________________________________
> > > ceph-users mailing list
> > > ceph-users@lists.ceph.com
> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
