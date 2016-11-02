From: Zhiqiang Wang <wonzhq@gmail.com>
Subject: Re: Partial replicas read/write
Date: Wed, 2 Nov 2016 12:06:44 +0800
Message-ID: <CA+cZ7sjv4_FZ9tjb6OeqWasDUFCB6Htyo41PvdQgwMF1Z=D8nQ@mail.gmail.com>
References: <CA+cZ7shWJ7DLfJrEy-nZiq7=J3r=dzCd0ukEUpv6RLHDoVSYZg@mail.gmail.com>
 <686669248.875.1478008018724@ox.pcextreme.nl> <CA+cZ7sjynuwneCPM9Rzm1r_G2NsVTe1ekixUxOPjnyd6pB2iNw@mail.gmail.com>
 <CAN=+7FWtXgVasEqDGcPgE_KYN1yM+GwTyyaTT1ma2tH3EXXTaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38660 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbcKBEGq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2016 00:06:46 -0400
Received: by mail-it0-f42.google.com with SMTP id q124so13733889itd.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2016 21:06:46 -0700 (PDT)
In-Reply-To: <CAN=+7FWtXgVasEqDGcPgE_KYN1yM+GwTyyaTT1ma2tH3EXXTaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2016-11-02 0:49 GMT+08:00 Samuel Just <sjust@redhat.com>:
> I've actually implemented Case 1) before, but ended up needing to
> revert it.  See 836fdc512dcae6724c72e52cb84ee2a364f0d261
>
> The core issue is how we choose an authoritative log during peering.
> First, we contact every up osd between the current epoch and the
> newest epoch we can prove we accepted writes/reads in (as we get
> notifies from those osds, that epoch moves forward until it's a tight
> bound).  Then, among the osds which were in the acting set in that
> interval, we choose the one with the newest last_update to be the
> authoritative log.  With a replicated pool, we're often going to need
> to recover that object on the other osds (the same could well be true
> if we had chosen another of those osds with an older last_update --
> we'd just end up recovering the same objects on the other osd) If we
> allow degraded writes, that osd *might not actually have that object*,
> and the object would end up being unfound.  Fundamentally, because
> replicated pools rely on recovery to fix divergent log entries, we
> need every acting set osd which records the log entry for a write to
> remember the actual update, and it's important to complete those
> recovery operations ASAP to limit the data risk window.  Note, this
> issue doesn't impact ec pools in the same way because divergent log
> entries don't result in missing objects since they can be rolled back.

This is the same issue as what we currently have. Say we start
recovery after peering. But before the recovery is finished, we have
another osd failure in the acting set and we do peering again. In this
case, we still have some objects on some osds whose log entries are
divergent from its data. Degraded partial write doesn't introduce new
issues here. The only difference is that some new data could be
written to the objects whose data is divergent from its log entries.

>
> There are a few ways to work around this.
>
> First, when sending a notify, the replica could include a
> version->bool mapping indicating which log entries it is missing.
> That would allow the primary perhaps to make this issue less severe.
> It's not clear to me that this is sufficient however to recover the
> current failure resiliency.  You'd at least want to respect min_size,
> but if the set of acting set osds you use to satisfy min_size changes
> between writes, you do end up increasing the probability of unfound

Yes, we should respect min_size. The idea is to go with the degraded
partial write only when the object is not missing on >= min_size osds
of the current acting set. If we have less than min_size osds which an
object is not missing, we fall back to the current 'recovery-first'
way.

> objects.  Another issue is how we use min_size during peering.
> Normally, if you have at least min_size replicas from the same
> interval, they'd be up to date except for any divergent updates.  With
> degraded writes, that's not true.  If you can only get 2/3 and one of
> them has a long prefix of missing log entries, then you really only
> have 1 replica and you stand a high chance of selecting an
> unnecessarily recent last_update (more of a problem for ec pools).  A

I don't quite get this. But how about supporting only replicated pool?
EC pool probably don't care about the IOPS degration.

> final weakness of this approach is that Case 2) would be incredibly
> complicated and I really don't think it's tractable, so you'll still
> have to block in order to recover on the primary.

For case 2, if we only handle the read/write of head object (most
workloads do this kind of IOs during the majority of its run time) on
the replica, and fall back to the current way for the other cases,
this probably could make things a lot easier?

>
> I think a far better solution would be to use the temp acting
> machinery we use for backfill in cases where there is an osd which is
> clearly pretty far from current.  The idea would be to improve
> choose_acting with a heuristic which notices when it has more than
> min_size viable acting_set candidates, but a subset of them is much
> farther behind than they should be.  That subset would be excluded
> from the acting set and recovered asyncronously much like backfill
> (but using the log entries to avoid a scan!).  Done right, I think
> we'd end up restricting the current syncronous replication behavior to
> the very few entries at the head of the log representing divergent
> updates and cases where the pg is degraded beyond min_size -- exactly
> the cases where we need to perform recovery ASAP.
> -Sam
>
> On Tue, Nov 1, 2016 at 8:57 AM, Zhiqiang Wang <wonzhq@gmail.com> wrote:
>> 2016-11-01 21:46 GMT+08:00 Wido den Hollander <wido@42on.com>:
>>>
>>>> Op 31 oktober 2016 om 10:50 schreef Zhiqiang Wang <wonzhq@gmail.com>:
>>>>
>>>>
>>>> Currently if an object is missing on either primary or replicas during
>>>> recovery, and there are IO requests on this object, the IO requests
>>>> are blocked, and the recovery of the whole object is kicked off, which
>>>> includes a 4M object and some attrs/omaps reads/writes. These IO
>>>> requests are not resumed until the object is recovered on all OSDs of
>>>> the acting set. When there are many objects in this kind of scenario,
>>>> especially at the beginning of the recovery, the client IO is
>>>> significantly impacted during this period of time. This is not
>>>> acceptable for many enterprise workloads. We've seen many cases of
>>>> this issue even if we've lowered the parameters which control the
>>>> recovery traffic.
>>>>
>>>> To fix this issue, I plan to implement a feature which I call it
>>>> 'partial replicas read/write' for the replicated pool. The basic idea
>>>> is that for an op which accesses a degraded object, it's not blocked
>>>> until the object is recovered. Instead, the data of the object is only
>>>> read from or written to those OSDs of the acting set on which the
>>>> object is not missing. But for pglog, they are written to all OSDs of
>>>> the acting set regardless of their missing status. This is to comply
>>>> with the current peering design.
>>>>
>>>
>>> Will this be configurable per pool for example?
>>
>> Yes, This can be made configurable.
>>
>>>
>>> It sounds scary to me that we modify a object on the primary only and only write to the PG log. What if the disk of the primary fails before backfilling/recovery has finished. The pglog is enough to fully reconstruct the object from just the pglog?
>>>
>>> Just wondering if we still get the data consistency RADOS currently has, e.g. be always consistent.
>>>
>>
>> If the primary osd fails before recovery is done, and it's the only
>> osd who contains the latest data, the object will be unfound after
>> peering. This is the same as the current logic. The data consistency
>> will remain unchanged.
>>
>>>> To be more specific, there are two cases.
>>>>
>>>> ## Case 1. Object is degraded but available on primary
>>>> This case is kind of straightforward, but we need to carefully update
>>>> the missing set, missing_loc, etc. Read op is not blocked even in the
>>>> current code in this case, so let's forget it. For write, the
>>>> objectstore transaction, pglog/pgstat are built on primary. For those
>>>> acting set OSDs which are missing this object, only the pglog/pgstat
>>>> is shipped to them. For the others, the prepared objectstore
>>>> transaction is shipped as well, which is the same as what we do now.
>>>>
>>>> ## Case 2. Object is missing on the primary
>>>> IO on this object can't be handled on the primary in this case, they
>>>> are proxied to one of the acting set OSDs who is not missing this
>>>> object. Again, we divide it into read and write.
>>>> ### Read
>>>> Primary proxies the degraded read to one of the replicas who is not
>>>> missing this object. The replica OSD does the read and returns to the
>>>> primary. And then primary replies to the client.
>>>> ### Write
>>>> Primary proxies the degraded write to one of the replicas who is not
>>>> missing this object, together with some infos, such as the acting set,
>>>> missing status, etc. This replica OSD handles the op and builds the
>>>> transaction/pglog/pgstat. As in case 1, it ships the new pglog/pgstat
>>>> to all the acting set OSDs, but only ships the object data to the OSDs
>>>> who are not missing the object. After applied and committed pglog
>>>> and/or object data, they replied to the replica OSD. The replica OSD
>>>> then replies back to the primary, finally back to the client.
>>>> Two notes for this case:
>>>> 1) Carefully update the missing set, missing_loc as in case 1
>>>> 2) When there are partial replica writes inflight, the later writes on
>>>> this PG should wait after the primary has received the new pglog of
>>>> the inflight partial replica write. Though this may induce some wait
>>>> time, it should be OK since it's much lightweight.
>>>>
>>>> For some complex scenarios, we can fall back to the original way for
>>>> simplicity, such as the snapshot read, hybrid read/write/cache ops,
>>>> etc.
>>>>
>>>> Does this make sense? Comments are appreciated!
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
