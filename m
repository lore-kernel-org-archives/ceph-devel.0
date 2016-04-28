From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Started developing a deduplication feature
Date: Thu, 28 Apr 2016 21:08:49 +0000
Message-ID: <BN3PR02MB12066770AEB734AEA5D42662E8650@BN3PR02MB1206.namprd02.prod.outlook.com>
References: <8737r5w89m.fsf@uni-mainz.de>
 <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0096.outbound.protection.outlook.com ([157.56.111.96]:65056
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753631AbcD1VI5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 17:08:57 -0400
In-Reply-To: <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Marcel Lauhoff <lauhoff@uni-mainz.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Friday, April 01, 2016 4:31 PM
> To: Marcel Lauhoff <lauhoff@uni-mainz.de>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Started developing a deduplication feature
> 
> Hi Marcel,
> 
> On Fri, 1 Apr 2016, Marcel Lauhoff wrote:
> > Hi Ceph,
> >
> > deduplication has been discussed on the list a couple of times.
> > Over the next months I'll be working on a prototype.
> >
> > In short: Use a content-addressed storage pool backed by a pool acting
> > as storage and distributed fingerprint index.
> >
> > Two pools: (1) pool that does the content addressing, (2) storage /
> > index pool.
> >
> > OSDs in the first pool readdress and chuck/reassemble objects.
> > They then store the new objects/chunks in a second pool.
> 
> I think this is the right architecture for dedup in Ceph, and matches the ideas
> we've been kicking around.
> 
> > The first pool uses a new PG backend ("CAS Backend"), while the second
> > can use replication or erasure coding.
> >
> > The CAS backend computes fingerprints for incoming objects and stores
> > the fingerprint <-> original object name mapping.
> > It then forwards the data to a storage pool, addressing the objects by
> > fingerprint (the content defined name).
> >
> > The storage pool therefore serves as a distributed fingerprint index.
> > CRUSH selects the responsible OSDs. The OSDs know their objects.
> >
> > Deduplication happens when two objects/chunks have the same
> > fingerprint.
> 
> This is a little different, though.
> 
> The plan so far has been to match this up with the next stage of tiering.
> We'll add the ability for and object to be a 'redirect' and store a bit of
> metadata indicating where to look next.  That might be a simple as "go look in
> this cold RADOS pool over there," or a URL into another storage system (e.g.,
> a tape archive), or.. a complicated mapping of bytes to CAS chunks in another
> rados pool.
> 
> The original thought was that this would just be a regular ReplicatedPG, not a
> new pool type.  I haven't thought about what we'd gain by having a new pool
> type.  One thing we get by using the existing pool is that we're not forced to
> do the demotion/dedup immediately--we can just store the object normally,
> and dedup it later when we decide it's cold.

To me, using a replicated pool to store the chunks significantly degrades the value of deduplication.
Also, the usage of a standard RADOS object for each chunk will severely degrade performance for small chunk sizes at large data scales.

The advantage of a new pool type is that you can create a metadata structure that's better crafted to this use case and that uses erasure coding to really get the full value out of deduplication.

Lots more work of course :(

> 
> For the CAS pool, the idea would be to use the refcount class, or something
> like it, so that you'd say "write object $hash" and if the object already exists
> it'd increment the ref count.  Similarly, when you delete the logical object,
> you do a refcount 'put' on each chunk, and the chunk would only go away
> when the last ref did too.  (In practice we need to be careful to avoid leaked
> refs in the case of failures; this would probably be done by having a
> 'deduping' and 'deleting' state on the logical object and named references.
> 
> > My current milestones:
> > - Develop CAS backend, fingerprinting, recipes store
> > - Support limited set of operations (like EC does)
> > - Support RBD (with/without Cache) and evaluate
> > - Add Chunking, Garbage Collection, ..
> >
> > Currently I'm adding a new PG backend into the OSD code base. I'll
> > push the code the my github clone as soon as it does "something" :)
> 
> This would be a good thing to discuss during the Ceph Developer Monthly call
> next Wednesday:
> 
> 	http://tracker.ceph.com/projects/ceph/wiki/Planning
> 	http://tracker.ceph.com/projects/ceph/wiki/CDM_06-APR-2016
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
