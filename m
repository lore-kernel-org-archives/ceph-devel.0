From: Sage Weil <sweil@redhat.com>
Subject: Re: cls_rbd ops on rbd_id.$name objects in EC pool
Date: Fri, 5 Feb 2016 13:44:57 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602051340490.28396@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602051036131.28396@cpach.fuggernut.com> <1582262647.20033136.1454687586287.JavaMail.zimbra@redhat.com> <CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbcBESom (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 13:44:42 -0500
In-Reply-To: <CAN=+7FXJ6je1WpYpO-ozqo-ZKnBcRhv3hpaiH+GNku9YyK49Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Nick Fisk <nick@fisk.me.uk>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 5 Feb 2016, Samuel Just wrote:
> On Fri, Feb 5, 2016 at 7:53 AM, Jason Dillaman <dillaman@redhat.com> wrote:
> > #1 and #2 are awkward for existing pools since we would need a tool to 
> > inject dummy omap values within existing images.  Can the cache tier 
> > force-promote it from the EC pool to the cache when an unsupported op 
> > is encountered?  There is logic like that in jewel/master for handling 
> > the proxied writes.

That sounded familiar but I couldn't find this in the code or history 
between infernalis and master.  And then I went back and was unable to 
reproduce the a problem on either infernalis branch or v9.2.0.

Nick, I was doing
 1013  ./rbd -p ec create foo --size 10
 1014  ./rbd -p ec info foo
 1015  ./rados -p ec-cache cache-flush rbd_id.foo
 1016  ./rados -p ec-cache cache-evict rbd_id.foo
 1017  ./rbd -p ec info foo
 1018  ./rados -p ec-cache ls -

The rbd.get_id is successfully forcing a promotion.

Which makes me think something else is going on... Nick, can you try to 
reproduce this with a userspace librbd client?  'rbd info' will do a few 
basic operations, but if that isn't problematic, try 'rbd bench-write' or 
'rbd export', which will do real IO?

sage


> -Sam
> 
> >
> > --
> >
> > Jason Dillaman
> >
> > ----- Original Message -----
> >> From: "Sage Weil" <sweil@redhat.com>
> >> To: "Nick Fisk" <nick@fisk.me.uk>
> >> Cc: "Jason Dillaman" <dillaman@redhat.com>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org
> >> Sent: Friday, February 5, 2016 10:42:17 AM
> >> Subject: cls_rbd ops on rbd_id.$name objects in EC pool
> >>
> >> On Wed, 27 Jan 2016, Nick Fisk wrote:
> >> >
> >> > > -----Original Message-----
> >> > > From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf Of
> >> > > Jason Dillaman
> >> > > Sent: 27 January 2016 14:25
> >> > > To: Nick Fisk <nick@fisk.me.uk>
> >> > > Cc: ceph-users@lists.ceph.com
> >> > > Subject: Re: [ceph-users] Possible Cache Tier Bug - Can someone confirm
> >> > >
> >> > > Are you running with an EC pool behind the cache tier? I know there was
> >> > > an
> >> > > issue with the first Infernalis release where unsupported ops were being
> >> > > proxied down to the EC pool, resulting in that same error.
> >> >
> >> > Hi Jason, yes I am. 3x Replicated pool on top of an EC pool.
> >> >
> >> > It's probably something similar to what you mention. Either the client
> >> > should be able to access the RBD header object on the base pool, or it
> >> > should be flagged so that it can't be evicted.
> >>
> >> I just confirmed that the rbd_id.$name object doesn't have any omap, so
> >> from rados's perspective, flushing and evicting it is fine.  But yeah, the
> >> cls_rbd ops aren't permitted in the EC pool.
> >>
> >> In master/jewel we have a cache-pin function that prevents an object from
> >> being flushed.
> >>
> >> A few options are:
> >>
> >> 1) Have cls_rbd cache-pin it's objects.
> >>
> >> 2) Have cls_rbd put an omap key on the object to indirectly do the same.
> >>
> >> 3) Add a requires-cls type object flag that keeps hte object out of an EC
> >> pool *until* it eventually supports cls ops.
> >>
> >> I'd lean toward 1 since it's simple and explicit, and when we eventually
> >> make classes work we can remove the cache-pin behavior from cls_rbd.
> >> It's harder to fix in infernalis unless we also backport cache-pin/unpin
> >> ops, too, so maybe #2 would be a simple infernalis workaround?
> >>
> >> Jason?  Sam?
> >> sage
> >>
> >>
> >>
> >> >
> >> > >
> >> > > --
> >> > >
> >> > > Jason Dillaman
> >> > >
> >> > >
> >> > > ----- Original Message -----
> >> > > > From: "Nick Fisk" <nick@fisk.me.uk>
> >> > > > To: ceph-users@lists.ceph.com
> >> > > > Sent: Wednesday, January 27, 2016 8:46:53 AM
> >> > > > Subject: [ceph-users] Possible Cache Tier Bug - Can someone confirm
> >> > > >
> >> > > > Hi All,
> >> > > >
> >> > > > I think I have stumbled on a bug. I'm running Infernalis (Kernel 4.4
> >> > > > on the
> >> > > > client) and it seems that if the RBD header object gets evicted from
> >> > > > the cache pool then you can no longer map it.
> >> > > >
> >> > > > Steps to reproduce
> >> > > >
> >> > > > rbd -p cache1 create Test --size=10G
> >> > > > rbd - p cache1 map Test
> >> > > >
> >> > > > /dev/rbd1  <-Works!!
> >> > > >
> >> > > > rbd unmap /dev/rbd1
> >> > > >
> >> > > > rados -p cache1 cache-flush rbd_id.Test rados -p cache1 cache-evict
> >> > > > rbd_id.Test rbd - p cache1 map Test
> >> > > >
> >> > > > rbd: sysfs write failed
> >> > > > rbd: map failed: (95) Operation not supported
> >> > > >
> >> > > > or with the rbd-nbd client
> >> > > >
> >> > > > 2016-01-27 13:39:52.686770 7f9e54162b00 -1 asok(0x561837b88360)
> >> > > > AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen:
> >> > > > failed to bind the UNIX domain socket to
> >> > > > '/var/run/ceph/ceph-client.admin.asok': (17) File exists
> >> > > > 2016-01-27 13:39:52.703987 7f9e32ffd700 -1 librbd::image::OpenRequest:
> >> > > > failed to retrieve image id: (95) Operation not supported
> >> > > > rbd-nbd: failed to map, status: (95) Operation not supported
> >> > > > 2016-01-27 13:39:52.704138 7f9e327fc700 -1 librbd::ImageState: failed
> >> > > > to open image: (95) Operation not supported
> >> > > >
> >> > > > Nick
> >> > > >
> >> > > > _______________________________________________
> >> > > > ceph-users mailing list
> >> > > > ceph-users@lists.ceph.com
> >> > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> > > >
> >> > > _______________________________________________
> >> > > ceph-users mailing list
> >> > > ceph-users@lists.ceph.com
> >> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> >
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users@lists.ceph.com
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> >
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
