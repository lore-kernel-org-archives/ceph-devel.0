From: John Spray <john.spray@redhat.com>
Subject: Re: RBD mirroring design draft
Date: Thu, 28 May 2015 11:42:07 +0100
Message-ID: <5566F0FF.2020400@redhat.com>
References: <55529E04.1070202@redhat.com> <CAC6JEv_gGMnNUVFr5m2PaTum9Pa2z2YadVSJA+JBE7BvqOMKuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbE1KmJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 06:42:09 -0400
In-Reply-To: <CAC6JEv_gGMnNUVFr5m2PaTum9Pa2z2YadVSJA+JBE7BvqOMKuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, Josh Durgin <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 28/05/2015 06:37, Gregory Farnum wrote:
> On Tue, May 12, 2015 at 5:42 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>> It will need some metadata regarding positions in the journal. These
>> could be stored as omap values in a 'journal header' object in a
>> replicated pool, for rbd perhaps the same pool as the image for
>> simplicity. The header would contain at least:
>>
>> * pool_id - where journal data is stored
>> * journal_object_prefix - unique prefix for journal data objects
>> * positions - (zone, purpose, object num, offset) tuples indexed by zone
>> * object_size - approximate size of each data object
>> * object_num_begin - current earliest object in the log
>> * object_num_end - max potential object in the log
>>
>> Similar to rbd images, journal data would be stored in objects named
>> after the journal_object_prefix and their object number. To avoid
>> issues of padding or splitting journal entries, and to make it simpler
>> to keep append-only, it's easier to allow the objects to be near
>> object_size before moving to the next object number instead of
>> sticking with an exact object size.
>>
>> Ideally this underlying structure could be used for both rbd and
>> cephfs. Variable sized objects are different from the existing cephfs
>> journal, which uses fixed-size objects for striping. The default is
>> still 4MB chunks though. How important is striping the journal to
>> cephfs? For rbd it seems unlikely to help much, since updates need to
>> be batched up by the client cache anyway.
> I think the journaling v2 stuff that John did actually made objects
> variably-sized as you've described here. We've never done any sort of
> striping on the MDS journal, although I think it was
> possible.previously.

The objects are still fixed size: we talked about changing it so that 
journal events would never span an object boundary, but didn't do it -- 
it still uses Filer.

>
>>
>> Parallelism
>> ^^^^^^^^^^^
>>
>> Mirroring many images is embarrassingly parallel. A simple unit of
>> work is an image (more specifically a journal, if e.g. a group of
>> images shared a journal as part of a consistency group in the future).
>>
>> Spreading this work across threads within a single process is
>> relatively simple. For HA, and to avoid a single NIC becoming a
>> bottleneck, we'll want to spread out the work across multiple
>> processes (and probably multiple hosts). rbd-mirror should have no
>> local state, so we just need a mechanism to coordinate the division of
>> work across multiple processes.
>>
>> One way to do this would be layering on top of watch/notify. Each
>> rbd-mirror process in a zone could watch the same object, and shard
>> the set of images to mirror based on a hash of image ids onto the
>> current set of rbd-mirror processes sorted by client gid. The set of
>> rbd-mirror processes could be determined by listing watchers.
> You're going to have some tricky cases here when reassigning authority
> as watchers come and go, but I think it should be doable.

I've been fantasizing about something similar to this for CephFS 
backward scrub/recovery.  My current code supports parallelism, but 
relies on the user to script their population of workers across client 
nodes.

I had been thinking of more of a master/slaves model, where one guy 
would get to be the master by e.g. taking the lock on an object, and he 
would then hand out work to everyone else that was a watch/notify 
subscriber to the magic object.  It seems like that could be simpler 
than having workers have to work out independently what their workload 
should be, and have the added bonus of providing a command-like 
mechanism in addition to continuous operation.

Cheers,
John
