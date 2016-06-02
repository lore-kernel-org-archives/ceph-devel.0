From: Samuel Just <sjust@redhat.com>
Subject: Re: Lose allocation hint attribute after recovery or backfill
Date: Thu, 2 Jun 2016 09:35:45 -0700
Message-ID: <CAN=+7FX87cvPQGw8SECGzCxsgeK1xYpTgB4uGyX9PWRX3ttEug@mail.gmail.com>
References: <CALZt5jzdVMgZo7jxw9oxDJHUiQ72j1ubKN7=CP1cE7uX0+u+OA@mail.gmail.com>
	<alpine.DEB.2.11.1606020919050.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33503 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbcFBQfs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 12:35:48 -0400
Received: by mail-qk0-f181.google.com with SMTP id n63so40176214qkf.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 09:35:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606020919050.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ning Yao <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

2 would be way simpler.
-Sam

On Thu, Jun 2, 2016 at 6:21 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 2 Jun 2016, Ning Yao wrote:
>> Hi, Sage
>>
>> Currently, allocation hint is set into filesystem fsxattr, like XFS.
>> Or directly assign to onode_t in Blustore and Kstore.
>> It works as expected normally.  However, if the cluster begins to
>> recovering or backfilling object. Those recovered object will lose
>> allocation hint fsxattr forever. This means if a cluster experienced
>> osd up/down flapping, then those kind of hot accessed object will not
>> have the allocation hint xattr any more.
>> As a result, those objects will not be fully written (1M/4M)
>> eventually become fragmented. This will also happen if an object is
>> truncated (become of enabling qume discard option).
>>
>> Therefore, we may want to preserve the allocation hint fsxattr during
>> recovery, there are two alternatives to do this.
>> 1. issue set_alloc_hint with the current object size during recovery, like
>>     t->set_alloc_hint(cid, oid,  expected_object_size, expected_object_size)
>>     but it would be a problem for us to retrieve the
>> expected_object_size. For a block image, it may be object_size in
>> image metadata.
>>
>> 2. So I would like to directly transfer the information of hint
>> fsxattr to the recovered object. Also, I find that a new param flags
>> will be used to indicated whether the data will be compressed.
>> So I propose a PR Like this:
>> https://github.com/ceph/ceph/pull/9452
>>
>> I think the issue may not be related to BlueStore or KStore because of
>> the allocation hint attribute can be overwritten in later
>> set_allocation_hint Ops?
>
> Good catch!
>
> It seems like we have two choices...
>
> 1) get_alloc_hint (like in your PR) in ObjectStore interface.
>
> 2) Store the alloc hint parameters in the object_info_t so the OSD
> remembers them independently and they can be set during recovery.
>
> I'm partial to #2 because it means we still preserve the metadata while
> allowing the ObjectStore implementations to ignore the hint if they so
> choose.  There are new hints, for example, that FileStore/XFS won't store
> at all.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
