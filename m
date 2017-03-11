From: Paul Cuzner <pcuzner@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Sun, 12 Mar 2017 10:24:42 +1300
Message-ID: <CAO=rSOtrey4NL+P8SM8fJdoiunKFwcd+ywNniViQJxkU_akh_g@mail.gmail.com>
References: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
 <CALe9h7f7Mspny1fx2aMiXunS2C8GJrWFsp7YKdnmhu42+EVPmA@mail.gmail.com>
 <CAO=rSOsftK8YAA5Q3jEpuCee16ek=tA++an+weBKHgXSL7bkNw@mail.gmail.com> <CALe9h7dBSZM64NSKF6_S+74Wrv-mLfAtSbQbQvq-UXSSfUL8dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35235 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932781AbdCKVYp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Mar 2017 16:24:45 -0500
Received: by mail-wm0-f45.google.com with SMTP id v186so16887288wmd.0
        for <ceph-devel@vger.kernel.org>; Sat, 11 Mar 2017 13:24:44 -0800 (PST)
In-Reply-To: <CALe9h7dBSZM64NSKF6_S+74Wrv-mLfAtSbQbQvq-UXSSfUL8dA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Mar 12, 2017 at 9:49 AM, John Spray <jspray@redhat.com> wrote:
> On Fri, Mar 10, 2017 at 8:52 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>> Thanks John
>>
>> This is weird then. When I look at the data with client load I see the
>> following;
>> {
>> "pool_name": "default.rgw.buckets.index",
>> "pool_id": 94,
>> "recovery": {},
>> "recovery_rate": {},
>> "client_io_rate": {
>> "read_bytes_sec": 19242365,
>> "write_bytes_sec": 0,
>> "read_op_per_sec": 12514,
>> "write_op_per_sec": 0
>> }
>>
>> No object related counters - they're all block based. The plugin I
>> have rolls-up the block metrics across all pools to provide total
>> client load.
>
> Where are you getting the idea that these counters have to do with
> block storage?  What Ceph is telling you about here is the number of
> operations (or bytes in those operations) being handled by OSDs.
>

Perhaps it's my poor choice of words - apologies.

read_op_per_sec is read IOP count to the OSDs from client activity
against the pool

My point is that client-io is expressed in these terms, but recovery
activity is not. I was hoping that both recovery and client I/O would
be reported in the same way so you gain a view of the activity of the
system as a whole. I can sum bytes_sec from client i/o with
recovery_rate bytes_sec, which is something, but I can't see inside
recovery activity to see how much is read or write, or how much IOP
load is coming from recovery.
