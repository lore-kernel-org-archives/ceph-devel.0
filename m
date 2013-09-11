From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: Deep-Scrub and High Read Latency with QEMU/RBD
Date: Wed, 11 Sep 2013 15:42:28 -0400
Message-ID: <5230C7A4.7030207@cloudapt.com>
References: <5220C23A.8010709@cloudapt.com> <CABYiri_+D14srFbCdviG5hdA57qwZ_WY+HqGTOr+u9efbys0sg@mail.gmail.com> <5220DA19.3090809@cloudapt.com> <CABYiri9377tYrj3voUjpgWebrRCB_AiKb73ztN1thjjQ-UEsVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38207 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab3IKTmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 15:42:31 -0400
Received: by mail-ie0-f171.google.com with SMTP id 16so9379236iea.30
        for <ceph-devel@vger.kernel.org>; Wed, 11 Sep 2013 12:42:30 -0700 (PDT)
In-Reply-To: <CABYiri9377tYrj3voUjpgWebrRCB_AiKb73ztN1thjjQ-UEsVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Andrey Korolyov <andrey@xdel.ru>

I created Issue #6278 (http://tracker.ceph.com/issues/6278) to track 
this issue.

Thanks,
Mike Dawson


On 8/30/2013 1:52 PM, Andrey Korolyov wrote:
> On Fri, Aug 30, 2013 at 9:44 PM, Mike Dawson <mike.dawson@cloudapt.com> wrote:
>> Andrey,
>>
>> I use all the defaults:
>>
>> # ceph --admin-daemon /var/run/ceph/ceph-osd.1.asok config show | grep scrub
>>    "osd_scrub_thread_timeout": "60",
>>    "osd_scrub_finalize_thread_timeout": "600",
>
>
>>    "osd_max_scrubs": "1",
>
> This one. I may suggest to increase max_interval and write some kind
> of script doing per-pg scrub with low intensity, so you`ll have one
> scrubbing PG or less anytime and you may wait some time before
> scrubbing next, so they will not start scrubbing at once when
> max_interval will expire. I had discussed some throttling mechanisms
> to scrubbing some months ago here or in ceph-devel, but there still no
> such implementation (it is ultimately low-priority task since it can
> be handled by such simple thing as proposal above).
>
>>    "osd_scrub_load_threshold": "0.5",
>>    "osd_scrub_min_interval": "86400",
>>    "osd_scrub_max_interval": "604800",
>>    "osd_scrub_chunk_min": "5",
>>    "osd_scrub_chunk_max": "25",
>>    "osd_deep_scrub_interval": "604800",
>>    "osd_deep_scrub_stride": "524288",
>>
>> Which value are you referring to?
>>
>>
>> Does anyone know exactly how "osd scrub load threshold" works? The manual
>> states "The maximum CPU load. Ceph will not scrub when the CPU load is
>> higher than this number. Default is 50%." So on a system with multiple
>> processors and cores...what happens? Is the threshold .5 load (meaning half
>> a core) or 50% of max load meaning anything less than 8 if you have 16
>> cores?
>>
>> Thanks,
>> Mike Dawson
>>
>>
>> On 8/30/2013 1:34 PM, Andrey Korolyov wrote:
>>>
>>> You may want to reduce scrubbing pgs per osd to 1 using config option
>>> and check the results.
>>>
>>> On Fri, Aug 30, 2013 at 8:03 PM, Mike Dawson <mike.dawson@cloudapt.com>
>>> wrote:
>>>>
>>>> We've been struggling with an issue of spikes of high i/o latency with
>>>> qemu/rbd guests. As we've been chasing this bug, we've greatly improved
>>>> the
>>>> methods we use to monitor our infrastructure.
>>>>
>>>> It appears that our RBD performance chokes in two situations:
>>>>
>>>> - Deep-Scrub
>>>> - Backfill/recovery
>>>>
>>>> In this email, I want to focus on deep-scrub. Graphing '% Util' from
>>>> 'iostat
>>>> -x' on my hosts with OSDs, I can see Deep-Scrub take my disks from around
>>>> 10% utilized to complete saturation during a scrub.
>>>>
>>>> RBD writeback cache appears to cover the issue nicely, but occasionally
>>>> suffers drops in performance (presumably when it flushes). But, reads
>>>> appear
>>>> to suffer greatly, with multiple seconds of 0B/s of reads accomplished
>>>> (see
>>>> log fragment below). If I make the assumption that deep-scrub isn't
>>>> intended
>>>> to create massive spindle contention, this appears to be a problem. What
>>>> should happen here?
>>>>
>>>> Looking at the settings around deep-scrub, I don't see an obvious way to
>>>> say
>>>> "don't saturate my drives". Are there any setting in Ceph or otherwise
>>>> (readahead?) that might lower the burden of deep-scrub?
>>>>
>>>> If not, perhaps reads could be remapped to avoid waiting on saturated
>>>> disks
>>>> during scrub.
>>>>
>>>> Any ideas?
>>>>
>>>> 2013-08-30 15:47:20.166149 mon.0 [INF] pgmap v9853931: 20672 pgs: 20665
>>>> active+clean, 7 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 5058KB/s wr, 217op/s
>>>> 2013-08-30 15:47:21.945948 mon.0 [INF] pgmap v9853932: 20672 pgs: 20665
>>>> active+clean, 7 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 5553KB/s wr, 229op/s
>>>> 2013-08-30 15:47:23.205843 mon.0 [INF] pgmap v9853933: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 6580KB/s wr, 246op/s
>>>> 2013-08-30 15:47:24.843308 mon.0 [INF] pgmap v9853934: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 3795KB/s wr, 224op/s
>>>> 2013-08-30 15:47:25.862722 mon.0 [INF] pgmap v9853935: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 1414B/s rd, 3799KB/s wr, 181op/s
>>>> 2013-08-30 15:47:26.887516 mon.0 [INF] pgmap v9853936: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 1541B/s rd, 8138KB/s wr, 160op/s
>>>> 2013-08-30 15:47:27.933629 mon.0 [INF] pgmap v9853937: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 14458KB/s wr, 304op/s
>>>> 2013-08-30 15:47:29.127847 mon.0 [INF] pgmap v9853938: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 15300KB/s wr, 345op/s
>>>> 2013-08-30 15:47:30.344837 mon.0 [INF] pgmap v9853939: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 13128KB/s wr, 218op/s
>>>> 2013-08-30 15:47:31.380089 mon.0 [INF] pgmap v9853940: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 0B/s rd, 13299KB/s wr, 241op/s
>>>> 2013-08-30 15:47:32.388303 mon.0 [INF] pgmap v9853941: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 4951B/s rd, 8147KB/s wr, 192op/s
>>>> 2013-08-30 15:47:33.858382 mon.0 [INF] pgmap v9853942: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64556 GB / 174 TB avail; 7029B/s rd, 3254KB/s wr, 190op/s
>>>> 2013-08-30 15:47:35.279691 mon.0 [INF] pgmap v9853943: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 1651B/s rd, 2476KB/s wr, 207op/s
>>>> 2013-08-30 15:47:36.309078 mon.0 [INF] pgmap v9853944: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 3788KB/s wr, 239op/s
>>>> 2013-08-30 15:47:38.120343 mon.0 [INF] pgmap v9853945: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 4671KB/s wr, 239op/s
>>>> 2013-08-30 15:47:39.546980 mon.0 [INF] pgmap v9853946: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 13487KB/s wr, 444op/s
>>>> 2013-08-30 15:47:40.561203 mon.0 [INF] pgmap v9853947: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 15265KB/s wr, 489op/s
>>>> 2013-08-30 15:47:41.794355 mon.0 [INF] pgmap v9853948: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 7157KB/s wr, 240op/s
>>>> 2013-08-30 15:47:44.661000 mon.0 [INF] pgmap v9853949: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 4543KB/s wr, 204op/s
>>>> 2013-08-30 15:47:45.672198 mon.0 [INF] pgmap v9853950: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 3537KB/s wr, 221op/s
>>>> 2013-08-30 15:47:47.202776 mon.0 [INF] pgmap v9853951: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 0B/s rd, 5127KB/s wr, 312op/s
>>>> 2013-08-30 15:47:50.656948 mon.0 [INF] pgmap v9853952: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 32835B/s rd, 4996KB/s wr, 246op/s
>>>> 2013-08-30 15:47:53.165529 mon.0 [INF] pgmap v9853953: 20672 pgs: 20664
>>>> active+clean, 8 active+clean+scrubbing+deep; 38136 GB data, 111 TB used,
>>>> 64555 GB / 174 TB avail; 33446B/s rd, 12064KB/s wr, 361op/s
>>>>
>>>>
>>>> --
>>>> Thanks,
>>>>
>>>> Mike Dawson
>>>> Co-Founder & Director of Cloud Architecture
>>>> Cloudapt LLC
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
