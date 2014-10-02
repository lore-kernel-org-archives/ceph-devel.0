From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: FW: Weekly Ceph Performance Meeting Invitation
Date: Thu, 2 Oct 2014 17:39:43 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F522@SACMBXIP02.sdcorp.global.sandisk.com>
References: <542B043F.6020600@redhat.com>
 <20141001183717.GA31430@oder.mch.fsc.net> <542C4E18.8080201@redhat.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F027@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1410011311330.31126@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F0C3@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1410011553220.31126@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0073.outbound.protection.outlook.com ([157.56.110.73]:6733
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751959AbaJBRju convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 13:39:50 -0400
In-Reply-To: <alpine.DEB.2.00.1410011553220.31126@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Please share your opinion on this..

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Wednesday, October 01, 2014 3:57 PM
To: Somnath Roy
Cc: Mark Nelson; Kasper Dieter; Andreas Bluemle; Paul Von-Stamwitz
Subject: RE: Weekly Ceph Performance Meeting Invitation

On Wed, 1 Oct 2014, Somnath Roy wrote:
> Yes Sage, it's all read..Each call to lfn_open() will incur this 
> lookup in case of FDCache miss (which will be in 99% of cases).
> The following patch will certainly help the write path (which is
> exciting!)  but not read as read is not through the transaction path. 
> My understanding is in the read path per io only two calls are going 
> to filestore , one xattr ("_") and followed by read to the same 
> object. If somehow, we can club (or something) this two requests, 
> reads will be benefitted. I did some prototype earlier by passing the 
> fd (and path) to the replicated pg during getattr call and pass the 
> same fd/path during next read. This improving performance as well as 
> cpu usage. But, this is against the objectstore interface logic :-( 
> Basically, sole purpose of FDCache for serving this kind of scenario 
> but since it is sharded based on object hash now (and FDCache itself 
> is cpu
> intensive) it is not helping much. May be sharding based on PG 
> (Col_id) could help here ?

I suspect a more fruitful approach would be to make a read-side handle-based API for objectstore... so you can 'open' an object, keep that handle to the ObjectContext, and then do subsequent read operations against that.

Sharding the FDCache per PG would help with lock contention, yes, but is that the limiter or are we burning CPU?

> Also, I don't think ceph io path is very memory intensive and we can 
> leverage some memory for cache usage. For example, if we can have a 
> object_context cache at Replicated PG level (now the cache is there 
> but the contexts are not persisted), the performance (and cpu 
> usage)will be improved dramatically. I know that there can be lot of 
> PGs and thus memory usage can be a challenge. But, certainly we can 
> control that by limiting per cache size and what not. What could be 
> the size of an object_context instance, shouldn't be much I guess. I 
> did some prototyping on that too and got significant improvement. This 
> will eliminate the getattr path in case of cache hit.

Can you propose this on ceph-devel?  I think this is promising.  And probably quite easy to implement.

> Another challenge for read ( and for write too probably)  is the 
> sequential io in case of rbd . With the Linux default read_ahead , 
> performance of sequential read is significantly less than random read 
> with latest code in case of io_size say 64K. The obvious reason is 
> that with rbd, the default object size being 4MB, lot of sequential 
> 64K reads are coming to same PG and getting bottlenecked there. 
> Increasing read_ahead size improving performance but that will have an 
> effect in random workload. I think PG level cache should help here. 
> Striped images from librbd will not be facing this problem I guess but 
> krbd is not supporting striping and it is definitely a problem there.

I still think the key here is a comprehensive set of IO hints.  Then it's a problem of making sure we are using them effectively...

> We can discuss these in next meeting if this sounds interesting.

Yeah, but let's discuss on list first, no reason to wait!

s

> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, October 01, 2014 1:14 PM
> To: Somnath Roy
> Cc: Mark Nelson; Kasper Dieter; Andreas Bluemle; Paul Von-Stamwitz
> Subject: RE: Weekly Ceph Performance Meeting Invitation
> 
> On Wed, 1 Oct 2014, Somnath Roy wrote:
> > CPU wise the following are still hurting us in Giant. Lot of fixes 
> > like IndexManager stuff went in Giant that helped cpu consumption 
> > wise as well.
> >
> > 1. LFNIndex lookup logic . I have a fix that will save around one 
> > cpu core on that path. I am yet to address comments made by Greg/Sam 
> > on that. But, lot of improvement can happen here.
> 
> Have you looked at
> 
>         
> https://github.com/ceph/ceph/commit/74b1cf8bf1a7a160e6ce14603df63a46b2
> 2d8b98
> 
> The patch is incomplete, but with that change we should be able to drop to a single path lookup per ObjectStore::Transaction (as opposed to one for each op in the transaction that touches the given object).  I'm not sure if you were looking at ops that had a lot of those or they were simple single-io type operations?  That would only help on the write path; I think you said you've been focusing in reads.
> 
> > 2. Buffer class is very cpu intensive. Fixing that part will be 
> > helping every ceph components.
> 
> +1
> 
> sage
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
