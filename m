From: Marcel Lauhoff <lauhoff@uni-mainz.de>
Subject: Re: Started developing a deduplication feature
Date: Mon, 4 Apr 2016 14:38:45 +0200
Message-ID: <87wpodv99m.fsf@uni-mainz.de>
References: <8737r5w89m.fsf@uni-mainz.de> <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate-02.zdv.uni-mainz.de ([134.93.178.246]:15089 "EHLO
	mailgate-02.zdv.uni-mainz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751995AbcDDMix (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 08:38:53 -0400
In-Reply-To: <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


Hi Sage,

Sage Weil <sage@newdream.net> writes:
> On Fri, 1 Apr 2016, Marcel Lauhoff wrote:
>> The first pool uses a new PG backend ("CAS Backend"),
>> while the second can use replication or erasure coding.
>>
>> The CAS backend computes fingerprints for incoming objects and
>> stores the fingerprint <-> original object name mapping.
>> It then forwards the data to a storage pool, addressing the objects by
>> fingerprint (the content defined name).
>>
>> The storage pool therefore serves as a distributed fingerprint index.
>> CRUSH selects the responsible OSDs. The OSDs know their objects.
>>
>> Deduplication happens when two objects/chunks have the same
>> fingerprint.
>
> This is a little different, though.
>
> The plan so far has been to match this up with the next stage of tiering.
> We'll add the ability for and object to be a 'redirect' and store a bit of
> metadata indicating where to look next.  That might be a simple as "go
> look in this cold RADOS pool over there," or a URL into another storage
> system (e.g., a tape archive), or.. a complicated mapping of bytes to CAS
> chunks in another rados pool.

"OSD - tiering - object redirects" [42]?
As I understood the design, it is "client driven": Clients accessing a
redirected object get a reply "try again" + metadata from the primary
OSD.

What I'm proposing does not change the client. Plus, all the redirection
and dedup magic happens on the OSDs. Therefore the additional round
trip stays in the Ceph cluster.

On the other hand, the "layered pool" approach adds additional PGs and
load to the OSDs that the clients could do.

> The original thought was that this would just be a regular ReplicatedPG,
> not a new pool type.  I haven't thought about what we'd gain by having a
> new pool type.  One thing we get by using the existing pool is that we're
> not forced to do the demotion/dedup immediately--we can just store the
> object normally, and dedup it later when we decide it's cold.

Which also means that you could dedup an existing pool after a software upgrade..
Still, the common drawback/counter argument of/against offline dedup:
You can't factor in the deduplication ratio and end up having to buy more storage.

> For the CAS pool, the idea would be to use the refcount class, or
> something like it, so that you'd say "write object $hash" and if the
> object already exists it'd increment the ref count.  Similarly, when you
> delete the logical object, you do a refcount 'put' on each chunk, and the
> chunk would only go away when the last ref did too.  (In practice we need
> to be careful to avoid leaked refs in the case of failures; this would
> probably be done by having a 'deduping' and 'deleting' state on the
> logical object and named references.

Sound good. Maybe even with write-once-then-read-only objects like, for
example, Venti?

>> My current milestones:
>> - Develop CAS backend, fingerprinting, recipes store
>> - Support limited set of operations (like EC does)
>> - Support RBD (with/without Cache) and evaluate
>> - Add Chunking, Garbage Collection, ..
>>
>> Currently I'm adding a new PG backend into the OSD code base. I'll
>> push the code the my github clone as soon as it does "something" :)
>
> This would be a good thing to discuss during the Ceph Developer Monthly
> call next Wednesday:
>
> 	http://tracker.ceph.com/projects/ceph/wiki/Planning
> 	http://tracker.ceph.com/projects/ceph/wiki/CDM_06-APR-2016

Added. See you Wednesday


~irq0

[42] http://tracker.ceph.com/projects/ceph/wiki/Osd_-_tiering_-_object_redirects

--
Marcel Lauhoff
Mail: lauhoff@uni-mainz.de
XMPP: mlauhoff@jabber.uni-mainz.de
