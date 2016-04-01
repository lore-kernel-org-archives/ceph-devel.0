From: Sage Weil <sage@newdream.net>
Subject: Re: Started developing a deduplication feature
Date: Fri, 1 Apr 2016 17:31:24 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com>
References: <8737r5w89m.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54670 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbcDAVbd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 17:31:33 -0400
In-Reply-To: <8737r5w89m.fsf@uni-mainz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <lauhoff@uni-mainz.de>
Cc: ceph-devel@vger.kernel.org

Hi Marcel,

On Fri, 1 Apr 2016, Marcel Lauhoff wrote:
> Hi Ceph,
> 
> deduplication has been discussed on the list a couple of times.
> Over the next months I'll be working on a prototype.
> 
> In short: Use a content-addressed storage pool backed by a pool
> acting as storage and distributed fingerprint index.
> 
> Two pools: (1) pool that does the content addressing, (2) storage / 
> index pool.
> 
> OSDs in the first pool readdress and chuck/reassemble objects.
> They then store the new objects/chunks in a second pool.

I think this is the right architecture for dedup in Ceph, and matches the 
ideas we've been kicking around.

> The first pool uses a new PG backend ("CAS Backend"),
> while the second can use replication or erasure coding.
> 
> The CAS backend computes fingerprints for incoming objects and
> stores the fingerprint <-> original object name mapping.
> It then forwards the data to a storage pool, addressing the objects by
> fingerprint (the content defined name).
> 
> The storage pool therefore serves as a distributed fingerprint index.
> CRUSH selects the responsible OSDs. The OSDs know their objects.
> 
> Deduplication happens when two objects/chunks have the same
> fingerprint.

This is a little different, though.

The plan so far has been to match this up with the next stage of tiering.  
We'll add the ability for and object to be a 'redirect' and store a bit of 
metadata indicating where to look next.  That might be a simple as "go 
look in this cold RADOS pool over there," or a URL into another storage 
system (e.g., a tape archive), or.. a complicated mapping of bytes to CAS 
chunks in another rados pool.

The original thought was that this would just be a regular ReplicatedPG, 
not a new pool type.  I haven't thought about what we'd gain by having a 
new pool type.  One thing we get by using the existing pool is that we're 
not forced to do the demotion/dedup immediately--we can just store the 
object normally, and dedup it later when we decide it's cold.

For the CAS pool, the idea would be to use the refcount class, or 
something like it, so that you'd say "write object $hash" and if the 
object already exists it'd increment the ref count.  Similarly, when you 
delete the logical object, you do a refcount 'put' on each chunk, and the 
chunk would only go away when the last ref did too.  (In practice we need 
to be careful to avoid leaked refs in the case of failures; this would 
probably be done by having a 'deduping' and 'deleting' state on the 
logical object and named references.

> My current milestones:
> - Develop CAS backend, fingerprinting, recipes store
> - Support limited set of operations (like EC does)
> - Support RBD (with/without Cache) and evaluate
> - Add Chunking, Garbage Collection, ..
> 
> Currently I'm adding a new PG backend into the OSD code base. I'll
> push the code the my github clone as soon as it does "something" :)

This would be a good thing to discuss during the Ceph Developer Monthly 
call next Wednesday:

	http://tracker.ceph.com/projects/ceph/wiki/Planning
	http://tracker.ceph.com/projects/ceph/wiki/CDM_06-APR-2016

sage
