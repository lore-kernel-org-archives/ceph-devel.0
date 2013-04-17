From: Gregory Farnum <greg@inktank.com>
Subject: Re: Using locally replicated OSDs to reduce Ceph replication
Date: Wed, 17 Apr 2013 15:23:43 -0700
Message-ID: <CAPYLRzj0LMK_hCArN4K2t9DyLQsjqx-ysHidvvXi4=fDVBbdFw@mail.gmail.com>
References: <20130417220251.GZ4565@nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:35036 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965974Ab3DQWXn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 18:23:43 -0400
Received: by mail-qa0-f51.google.com with SMTP id g10so1173067qah.17
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 15:23:43 -0700 (PDT)
In-Reply-To: <20130417220251.GZ4565@nist.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steve Barber <steve.barber@nist.gov>
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 17, 2013 at 3:02 PM, Steve Barber <steve.barber@nist.gov> wrote:
> On Wed, Apr 17, 2013 at 04:49:53PM -0400, Jeff Mitchell wrote in
> another thread:
>> ... If you
>> set up the OSDs such that each OSD is based off of a ZFS mirror, you
>> get these benefits locally. For some people, especially when heavy on
>> reads (due to the intelligent caching), a solution that knocks the
>> remote replication level down by one but uses local mirrors for OSDs
>> may provide good functionality and safety compromises.
>
> Funny that you mention this today; that's exactly an idea I was thinking
> about pursuing yesterday, so that I don't have to do repl=4 for data
> protection both between two sites and within each site (i.e. 2 copies of
> data at each site).
>
> If anybody is actively doing/trying this (whether via RAID or ZFS or
> whatever, although I'm particularly interested in a ZFS/ZoL solution) I'd
> love to see some discussion about it.
>
> In particular, has anyone tried making a big RAID set (of any type) and
> carving out space (logical volumes, zvols, etc.) to become virtual OSDs?
> Any architectural gotchas with this idea?

I believe there are some people running with this architecture;
there's just less knowledge about how it behaves in the long term. It
should be fine subject to the standard issues with RAID5/6 small
writes, which OSDs do a lot of (and I don't know why you'd bother
using a mirroring RAID instead of Ceph replication!).
I can say that there would be little point to carving up the arrays
into multiple OSDs; other than that, have fun. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


>
> I'm trying to set up a cluster spread across two server rooms in separate
> buildings that can survive an outage of one building and still have
> replicated (safe) data in the event of e.g. a disk failure during the
> outage.  It seems like some local data protection would be much more
> efficient than having Ceph manage the extra replicas - subject to testing
> of course!
>
> As a side note I do like the thought of ZFS ensuring data integrity, and
> in the long run it might allow some of the same optimizations with Ceph that
> btrfs is used for now (re: snapshots, compression, etc.) and as Jeff
> mentioned, ZFS gives you a lot of performance tuning options.  I'm
> thrilled to see that it's getting some attention.
>
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
