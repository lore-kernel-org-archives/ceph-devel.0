From: John Spray <jspray@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Mon, 13 Mar 2017 22:14:02 +0000
Message-ID: <CALe9h7eWi5mfGLVoRfgLChW7sMY9C+NdttDrS1stTfvcD9khqA@mail.gmail.com>
References: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
 <CALe9h7f7Mspny1fx2aMiXunS2C8GJrWFsp7YKdnmhu42+EVPmA@mail.gmail.com>
 <CAO=rSOsftK8YAA5Q3jEpuCee16ek=tA++an+weBKHgXSL7bkNw@mail.gmail.com>
 <CALe9h7dBSZM64NSKF6_S+74Wrv-mLfAtSbQbQvq-UXSSfUL8dA@mail.gmail.com>
 <CAO=rSOtrey4NL+P8SM8fJdoiunKFwcd+ywNniViQJxkU_akh_g@mail.gmail.com>
 <CALe9h7fWgrt2CM-4u7jrpgE5Xrwm0zSVamkTjShfDieWxUpiOg@mail.gmail.com>
 <CAO=rSOvfakqcdkQ5EC-2YqjBg8VwYGWZ8qF551MajezJ2uAZJA@mail.gmail.com> <CALe9h7dXbhdF_-_-QDWdLJLbtOPGQ87p2-iu4u8gcmJUHMnOAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36106 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbdCMWOZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Mar 2017 18:14:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id n11so51070014wma.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Mar 2017 15:14:24 -0700 (PDT)
In-Reply-To: <CALe9h7dXbhdF_-_-QDWdLJLbtOPGQ87p2-iu4u8gcmJUHMnOAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Cuzner <pcuzner@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Mar 13, 2017 at 10:13 PM, John Spray <jspray@redhat.com> wrote:
> On Mon, Mar 13, 2017 at 9:50 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>> Fundamentally, the metrics that describe the IO the OSD performs in
>> response to a recovery operation should be the same as the metrics for
>> client I/O.
>
> Ah, so the key part here I think is "describe the IO that the OSD
> performs" -- the counters you've been looking at do not do that.  They
> describe the ops the OSD is servicing, *not* the (disk) IO the OSD is
> doing as a result.
>
> That's why you don't get an apples-to-apples comparison between client
> IO and recovery -- if you were looking at disk IO stats from both, it
> would be perfectly reasonable to combine/compare them.  When you're
> looking at Ceph's own counters of client ops vs. recovery activity,
> that no longer makes sense.
>
>> So in the context of a recovery operation, one OSD would
>> report a read (recovery source) and another report a write (recovery
>> target), together with their corresponding num_bytes. To my mind this
>> provides transparency, and maybe helps potential automation.
>
> Okay, so if we were talking about disk IO counters, this would
> probably make sense (one read wouldn't necessarily correspond to one
> write), but if you had a counter that was telling you how many Ceph
> recovery push/pull ops were "reading" (being sent) vs "writing" (being
> received) the totals would just be zero.

Sorry, that should have said the totals would just be equal.

John

>
> John
>
>>
>
>>
>>
>>
>>
>>
>> On Mon, Mar 13, 2017 at 1:13 AM, John Spray <jspray@redhat.com> wrote:
>>> On Sat, Mar 11, 2017 at 9:24 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>>> On Sun, Mar 12, 2017 at 9:49 AM, John Spray <jspray@redhat.com> wrote:
>>>>> On Fri, Mar 10, 2017 at 8:52 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>>>>> Thanks John
>>>>>>
>>>>>> This is weird then. When I look at the data with client load I see the
>>>>>> following;
>>>>>> {
>>>>>> "pool_name": "default.rgw.buckets.index",
>>>>>> "pool_id": 94,
>>>>>> "recovery": {},
>>>>>> "recovery_rate": {},
>>>>>> "client_io_rate": {
>>>>>> "read_bytes_sec": 19242365,
>>>>>> "write_bytes_sec": 0,
>>>>>> "read_op_per_sec": 12514,
>>>>>> "write_op_per_sec": 0
>>>>>> }
>>>>>>
>>>>>> No object related counters - they're all block based. The plugin I
>>>>>> have rolls-up the block metrics across all pools to provide total
>>>>>> client load.
>>>>>
>>>>> Where are you getting the idea that these counters have to do with
>>>>> block storage?  What Ceph is telling you about here is the number of
>>>>> operations (or bytes in those operations) being handled by OSDs.
>>>>>
>>>>
>>>> Perhaps it's my poor choice of words - apologies.
>>>>
>>>> read_op_per_sec is read IOP count to the OSDs from client activity
>>>> against the pool
>>>>
>>>> My point is that client-io is expressed in these terms, but recovery
>>>> activity is not. I was hoping that both recovery and client I/O would
>>>> be reported in the same way so you gain a view of the activity of the
>>>> system as a whole. I can sum bytes_sec from client i/o with
>>>> recovery_rate bytes_sec, which is something, but I can't see inside
>>>> recovery activity to see how much is read or write, or how much IOP
>>>> load is coming from recovery.
>>>
>>> What would it mean to you for a recovery operation (one OSD sending
>>> some data to another OSD) to be read vs. write?
>>>
>>> John
