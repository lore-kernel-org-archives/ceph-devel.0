From: kefu chai <tchaikov@gmail.com>
Subject: Re: new scrub and repair discussion
Date: Wed, 25 May 2016 22:34:01 +0800
Message-ID: <CAJE9aONiGxx4DEee-hSEoLbX3dyjjGxo4RwtZD8wV2jj35rimA@mail.gmail.com>
References: <CAJE9aOMW9REHMc8b3o63CwxN2doY0O3pU+QcWrErKZMvwVtznw@mail.gmail.com>
	<CAFdRU71uu+jzZ_OkZ8ppR94GUE1yWi1DR7LCJGTw5DR7reMR=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34776 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEYOeD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2016 10:34:03 -0400
Received: by mail-yw0-f175.google.com with SMTP id c127so49120027ywb.1
        for <ceph-devel@vger.kernel.org>; Wed, 25 May 2016 07:34:02 -0700 (PDT)
In-Reply-To: <CAFdRU71uu+jzZ_OkZ8ppR94GUE1yWi1DR7LCJGTw5DR7reMR=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: skinjo@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 23, 2016 at 11:54 AM, Shinobu Kinjo <shinobu.kj@gmail.com> wrote:
> On Wed, Nov 11, 2015 at 8:44 PM, kefu chai <tchaikov@gmail.com> wrote:
>> currently, scrub and repair are pretty primitive. there are several
>> improvements which need to be made:
>>
> [snip]
>> - repair will create a new version so that possibly corrupted copies
>> on down OSDs will get fixed naturally.
>
> If this new feature is executed by end users manually, it may be
> better to implement dry-run mechanism so that the above process could
> be skipped, and end users initialize scrub process with more
> information, and maybe more safely.

to implement a dry-run, we have two possible ways:

1. export the inconsistency detection logic to client, and expose the
full scrub map to client, so user can run the inconsistency detection
algorithm through the updated scrub map.
2. persist the proposed change in osd, and override the object
information with the proposed ones if any when running the
inconsistency detection logic

imho, the first one is more viable. but it is much more complicated
than current design. maybe we can do it after the repair write API is
ready.

>
> Make sense?
>
> Cheers,
> Shinobu
>
>>
>> so librados will offer enough information and facilities, with which a
>> smart librados client/script will be able to fix the inconsistencies
>> found in the scrub.
>>
>> as an example, if we run into a data inconsistency where the 3
>> replicas failed to agree with each other after performing a deep
>> scrub. probably we'd like to have an election to get the auth copy.
>> following pseudo code explains how we will implement this using the
>> new rados APIs for scrub and repair.
>>
>>      # something is not necessarily better than nothing
>>      rados.aio_scrub(pg, completion)
>>      completion.wait_for_complete()
>>      for pool in rados.get_inconsistent_pools():
>>           for pg in rados.get_inconsistent_pgs(pool):
>>                # rados.get_inconsistent_pgs() throws if "epoch" expires
>>
>>                for oid, inconsistent in rados.get_inconsistent_pgs(pg,
>> epoch).items():
>>                     if inconsistent.is_data_digest_mismatch():
>>                          votes = defaultdict(int)
>>                          for osd, shard_info in inconsistent.shards:
>>                               votes[shard_info.object_info.data_digest] += 1
>>                          digest, _ = mavotes, key=operator.itemgetter(1))
>>                          auth_copy = None
>>                          for osd, shard_info in inconsistent.shards.items():
>>                               if shard_info.object_info.data_digest == digest:
>>                                    auth_copy = osd
>>                                    break
>>                          repair_op = librados.ObjectWriteOperation()
>>                          repair_op.repair_pick(auth_copy,
>> inconsistent.ver, epoch)
>>                          rados.aio_operate_scrub(oid, repair_op)
>>
>> this plan was also discussed in the infernalis CDS. see
>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Scrub_and_Repair.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Email:
> shinobu@linux.com
> shinobu@redhat.com



-- 
Regards
Kefu Chai
