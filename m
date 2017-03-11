From: John Spray <jspray@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Sat, 11 Mar 2017 20:49:05 +0000
Message-ID: <CALe9h7dBSZM64NSKF6_S+74Wrv-mLfAtSbQbQvq-UXSSfUL8dA@mail.gmail.com>
References: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
 <CALe9h7f7Mspny1fx2aMiXunS2C8GJrWFsp7YKdnmhu42+EVPmA@mail.gmail.com> <CAO=rSOsftK8YAA5Q3jEpuCee16ek=tA++an+weBKHgXSL7bkNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36224 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932683AbdCKUt2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Mar 2017 15:49:28 -0500
Received: by mail-wm0-f47.google.com with SMTP id n11so16564227wma.1
        for <ceph-devel@vger.kernel.org>; Sat, 11 Mar 2017 12:49:27 -0800 (PST)
In-Reply-To: <CAO=rSOsftK8YAA5Q3jEpuCee16ek=tA++an+weBKHgXSL7bkNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Cuzner <pcuzner@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Mar 10, 2017 at 8:52 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
> Thanks John
>
> This is weird then. When I look at the data with client load I see the
> following;
> {
> "pool_name": "default.rgw.buckets.index",
> "pool_id": 94,
> "recovery": {},
> "recovery_rate": {},
> "client_io_rate": {
> "read_bytes_sec": 19242365,
> "write_bytes_sec": 0,
> "read_op_per_sec": 12514,
> "write_op_per_sec": 0
> }
>
> No object related counters - they're all block based. The plugin I
> have rolls-up the block metrics across all pools to provide total
> client load.

Where are you getting the idea that these counters have to do with
block storage?  What Ceph is telling you about here is the number of
operations (or bytes in those operations) being handled by OSDs.

John

> And as in the prior email recovery_rate counters are object related.
>
> As far as merging the stats is concerned, I *do* believe it's useful
> info for the admin to know - and maybe even the admin's boss :)
>
> It would answer questions like - how busy is the cluster as a whole,
> and with both client and recovery metrics aligned you could then drill
> down into client/recovery components. It might also be interesting to
> derive a ratio metric of client:recovery and maybe key of that for
> automation (alerts/notifications, automated tuning etc etc)
>
>
>
>
>
>
>
>
>
>
> On Fri, Mar 10, 2017 at 10:55 PM, John Spray <jspray@redhat.com> wrote:
>> The reason they're different is that they originate from separate
>> internal counters:
>>  * The client_io_rate bits come from
>> https://github.com/ceph/ceph/blob/jewel/src/mon/PGMap.cc#L1212
>>  * The recovery bits come from
>> https://github.com/ceph/ceph/blob/jewel/src/mon/PGMap.cc#L1146
>>
>> Not sure what you mean about bytes_sec vs objects_sec: client io and
>> recovery rate both have both objects and bytes counters.
>>
>> The empty dicts are something that annoys me too, some of the output
>> functions have an if() right at the start that drops the output when
>> none of the deltas are nonzero.  I doubt anyone would have a big
>> problem with changing these to output the zeros rather than skipping
>> the fields.
>>
>> BTW I'm not sure it's smart to merge these in practice: would result
>> in showing users a "your cluster is doing 10GB/s" statistics while
>> their workload is crawling because all that IO is really recovery.
>> Confusing.
>>
>> John
>>
>>
>> On Fri, Mar 10, 2017 at 2:37 AM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>> Hi,
>>>
>>> I've been putting together a collectd plugin for ceph - since the old
>>> one's I could find no longer work. I'm gathering data from the mon's
>>> admin socket, merged with a couple of commands I issue through the
>>> rados mon_command interface.
>>>
>>> Nothing complicated, but the data has me a little confused
>>>
>>> When I run "osd pool stats" I get *two* different sets of metrics that
>>> describe client i/o and recovery i/o. Since the metrics are different
>>> I can't merge them to get a consistent view of what the cluster is
>>> doing as a whole at any given point in time. For example, client i/o
>>> reports in bytes_sec, but the recovery dict is empty and the
>>> recovery_rate is in objects_sec...
>>>
>>> i.e.
>>>
>>> }, {
>>> "pool_name": "rados-bench-cbt",
>>> "pool_id": 86,
>>> "recovery": {},
>>> "recovery_rate": {
>>> "recovering_objects_per_sec": 3530,
>>> "recovering_bytes_per_sec": 14462655,
>>> "recovering_keys_per_sec": 0,
>>> "num_objects_recovered": 7148,
>>> "num_bytes_recovered": 29278208,
>>> "num_keys_recovered": 0
>>> },
>>> "client_io_rate": {}
>>>
>>> This is running Jewel - 10.2.5-37.el7cp
>>>
>>> Is this a bug or a 'feature' :)
>>>
>>> Cheers,
>>>
>>> Paul C
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
