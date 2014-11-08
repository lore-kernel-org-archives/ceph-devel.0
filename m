From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: KeyValueStore: Some bug fixing in KeyValueStore prevent osd
 runtime crash #2875
Date: Sat, 8 Nov 2014 13:19:09 +0100
Message-ID: <CACJqLyaL4COg6CvkNF1jm_uZSrN96mP7SmvkO0FaZRZEN_r9vQ@mail.gmail.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B30119DCC8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54010 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbaKHMTK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Nov 2014 07:19:10 -0500
Received: by mail-wi0-f170.google.com with SMTP id r20so6455959wiv.5
        for <ceph-devel@vger.kernel.org>; Sat, 08 Nov 2014 04:19:09 -0800 (PST)
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B30119DCC8@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Chendi,

It seemed that you find two bugs for KeyValueStore:

1. Potential race conflict with strip_header->buffers:

strip_header is owner by a thread who want to access header.  Now
KeyValueStore in order to avoid lock bottleneck, only use
Sequencer-level(much like PG)  to solve concurrent ops. But all write
ops will cause "meta" collection updating. It seemed that I make a
mistake for commit:126
line(https://github.com/yuyuyu101/ceph/commit/bb49547d0fa3f65aabb3b20a96fb8dabd8dc81c0).

Original, "meta" collection will disable cache avoiding concurrent
modify, I forget why I delete this line. So I think we still need to
add this line:

if (cid != coll_t()) {

2. OOM for KeyValueStore

strip_header->buffers is necessary for KeyValueStore which is used by
following ops in the same transaction. Because a write op may need
read the newest data which may affected by last write op in the same
transaction.

As for OOM, I think the root cause is the mistake commit above too.
Because "meta" collection will be updated each transaction and
StripObjectHeader::buffers will be always kept in memory because of
the strategy of cache. So this object's buffers will keep in
increasing all the time. So I think if we avoid cache "meta"
collection's object will just be fine. Although we don't observe OOM
for previous release except this mistake commit, I prefer to add codes
to discard "buffers" each submit transaction time to avoid potential
unpredicted memory growing.

Do you have a more clear impl about it? I'm just thinking a better way
to solve the performance bottleneck for "meta" collections.


On Fri, Nov 7, 2014 at 4:17 AM, Xue, Chendi <chendi.xue@intel.com> wrote:
> Hi, all
>
> There is a small bug fixing in KeyValueStore to prevent osd crash
>
> When run random write 4k test on rbd with KeyValueStore backend, random osd crashes, and ceph-osd.log shows a segmentation fault which caused by multi threads updating the strip_header->buffers, so add mutex here
>
> Another problem is after running pretty long time, osd being killed by os due to OOM, which is also caused by there is no eviction mechanism in strip_header->buffers, so add a option in config_opts.h to turn strip_header->buffers off by default
>
> I saw slight performance drop when turn off the strip_header->buffers in a short time test( for I can't run a long time test due to osd will crash ), so does the strip_header->buffers necessary? If so, can I add a random cache mechanism on that?
>
> ===========================
> KeyValueStore:
> Add mutex when update strip_header->buffers to avoid segmentation fault
> Add option in config_opts.h to turn on/off strip_header->buffers to prevent OOM
>
> The pull request : https://github.com/ceph/ceph/pull/2875#issue-48042745
>
>
>
> Best Regards,
> -Chendi
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
