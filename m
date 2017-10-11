From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: deleting snapshots in batches?
Date: Wed, 11 Oct 2017 14:32:47 -0700
Message-ID: <CAJ4mKGZGhPEv8Ak+-nuq9V2ciNoFXm-OsAKt_KBBWy8Gh8tUZA@mail.gmail.com>
References: <CAGbvivLpWC=WUgmPA0q5Tt5wXF=1bx3kcAWP7drnYWfznBBUBg@mail.gmail.com>
 <CAAM7YAm08zrKjFvKRZamJYDSDHd1Z3aacXJxyiEpqTcPW-RiTQ@mail.gmail.com>
 <CAGbvivL8SKGgVVDoxCQKTdcewEwSbk=gxHGjVsdr-0VpJNsRZA@mail.gmail.com>
 <CAJ4mKGY=6LT5k98C_NeF_L2KtUkU_cVsy-kYcwa82fzM=cZ2uA@mail.gmail.com>
 <CAGbvivLcJ-Ziyt5PdsFj17o4KgtPfNpVOVhMf7+gt8Jw0Byc6A@mail.gmail.com> <CAGbvivJ9wLR7XhPfWg3LHHTAJAkGW8Xz_Ye6Xs3aUPOe1TYwyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:56498 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdJKVct (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Oct 2017 17:32:49 -0400
Received: by mail-it0-f42.google.com with SMTP id g18so4540179itg.5
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 14:32:49 -0700 (PDT)
In-Reply-To: <CAGbvivJ9wLR7XhPfWg3LHHTAJAkGW8Xz_Ye6Xs3aUPOe1TYwyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Oct 11, 2017 at 11:46 AM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> I checked and this is what our current trim settings are:
>
>     "osd_snap_trim_sleep": "0",

Forces a sleep of this time (seconds, I think?)) between each (set of)
operation(s) when trimming snaps.

>     "osd_pg_max_concurrent_snap_trims": "2",

The number of objects within a PG which a primary OSD will do snap
trimming on at a time.

>     "osd_max_trimming_pgs": "2",

The number of PGs which a primary OSD will do snap trimming on at a time.

(So multiply this by the previous for total number of concurrent
operations it will allow at a time)

>     "osd_preserve_trimmed_log": "false",
>     "osd_pg_log_trim_min": "100",

These are different; don't mess with them for this.

>     "osd_snap_trim_priority": "5",

This is the priority in the main op workqueue of trimming operations,
in relation to other outstanding ops. Higher is more important.

>     "osd_snap_trim_cost": "1048576",

This is the cost of a single snap trim, applied in various throttler
systems. The unit here is bytes, more or less. A 4MB read or write is
generally given a cost of 4MB, but since it's a 1-dimensional value
you don't want any given disk access to have a cost less than
~1s/(drive IOPS)*(drive sequential throughput)

So snap trim sleep is the biggest single hammer, but with these you
ought to be able to limit the amount of work being done on each OSD as
snapshots are trimmed.


> Its not clear to me how to tune these to minimize the impact on the
> cluster for large snapshot deletions. Can you give some insight here -
> how does changing something like "max_trimming_pgs" affect the OSD
> operations?
> I did watch your presentation, but the impact of changing these
> individual parameters is not clear.
>
>
>
> On Wed, Oct 11, 2017 at 2:23 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> Probably not, I'll need to go look those up.
>>
>> On Wed, Oct 11, 2017 at 2:13 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> Have you adjusted any of the snapshot trimming tunables that were
>>> added in the later Jewel releases, and explicitly designed to throttle
>>> down trimming and prevent these issues? They're discussed pretty
>>> extensively in past threads on the list and in my presentation at the
>>> latest OpenStack Boston Ceph Day.
>>> -Greg
>>>
>>> On Tue, Oct 10, 2017 at 5:46 AM, Wyllys Ingersoll
>>> <wyllys.ingersoll@keepertech.com> wrote:
>>>> The "rmdir" command takes seconds.
>>>>
>>>> However, the resulting storm of activity on the cluster AFTER the
>>>> deletion is bringing our cluster down completely.   The blocked
>>>> requests count goes into the thousands.  The individual OSD processes
>>>> begin taking up all of the memory that they can grab which causes the
>>>> kernel to kill them off, which further throws the cluster into
>>>> disarray due to down/out OSDs.  It takes multiple DAYS to completely
>>>> recover from deleting 1 snapshot and constant monitoring to make sure
>>>> OSDs come up and stay up after they get killed for eating too much
>>>> memory.  This is a serious issue that we have been fighting with for
>>>> over a month now.  The obvious solution is to destroy the cephfs
>>>> entirely, but that would mean we have to then recover about 40TB of
>>>> data, which could take a very long time and we'd prefer not to do
>>>> that.
>>>>
>>>> For example:
>>>> 2521055 ceph      20   0 16.908g 0.013t  29172 S  28.4 10.6  36:39.52
>>>> ceph-osd
>>>> 2507582 ceph      20   0 22.919g 0.019t  42076 S  17.6 15.5  58:48.00
>>>> ceph-osd
>>>> 2501393 ceph      20   0 22.024g 0.018t  39648 S  14.7 14.9  79:05.28
>>>> ceph-osd
>>>> 2547090 ceph      20   0 21.316g 0.017t  26584 S   7.8 14.0  18:14.76
>>>> ceph-osd
>>>> 2455703 ceph      20   0 20.872g 0.017t  19784 S   4.9 13.8 111:02.06
>>>> ceph-osd
>>>>  246368 ceph      20   0 22.657g 0.018t  37416 S   3.9 14.5 462:31.79
>>>> ceph-osd
>>>>
>>>>
>>>>
>>>>
>>>> On Tue, Oct 10, 2017 at 12:03 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>>>>> On Tue, Oct 10, 2017 at 12:13 AM, Wyllys Ingersoll
>>>>> <wyllys.ingersoll@keepertech.com> wrote:
>>>>>> We have a cluster (10.2.9 based) with a cephfs filesytem that has
>>>>>> 4800+ snapshots. We want to delete most of the very old ones to get it
>>>>>> to a more manageable number (such as 0).  However, deleting even 1
>>>>>> snapshot right now takes up to a full 24 hours due to their age and
>>>>>> size. It would literally take 13 years to delete all of them at the
>>>>>> current pace.
>>>>>>
>>>>>> Here is one snapshot directory statistics:
>>>>>>
>>>>>> # file: cephfs/.snap/snapshot.2017-02-24_22_17_01-1487992621
>>>>>> ceph.dir.entries="3"
>>>>>> ceph.dir.files="0"
>>>>>> ceph.dir.rbytes="30500769204664"
>>>>>> ceph.dir.rctime="1504695439.09966088000"
>>>>>> ceph.dir.rentries="7802785"
>>>>>> ceph.dir.rfiles="7758691"
>>>>>> ceph.dir.rsubdirs="44094"
>>>>>> ceph.dir.subdirs="3"
>>>>>>
>>>>>> There is a bug filed with details here: http://tracker.ceph.com/issues/21412
>>>>>>
>>>>>> Im wondering if there is a faster, undocumented, "backdoor" way to
>>>>>> clean up our snapshot mess without destroying the entire filesystem
>>>>>> and recreating it.
>>>>>
>>>>> deleting snapshot in cephfs is a simple operation, it should complete
>>>>> in seconds. something must  go wrong If 'rmdir .snap/xxx' tooks hours.
>>>>> please set debug_mds to 10, retry deleting a snapshot and send us the
>>>>> log. (it's better to stop all other fs activities while deleting
>>>>> snapshot)
>>>>>
>>>>> Regards
>>>>> Yan, Zheng
>>>>>
>>>>>>
>>>>>> -Wyllys Ingersoll
>>>>>>  Keeper Technology, LLC
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
