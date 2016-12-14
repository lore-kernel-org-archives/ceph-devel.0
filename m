From: Dong Wu <archer.wudong@gmail.com>
Subject: Re: How to release Hammer osd RAM when compiled with jemalloc
Date: Wed, 14 Dec 2016 09:39:47 +0800
Message-ID: <CAAL-TMdqQiLExSB+tTrGvnOiMxNgSZmM6KYEPyYCHJDouWfM4g@mail.gmail.com>
References: <CAAL-TMcjJi7dQrOHiBUwQCgJ5R2cWDeLBB3XzKAogvaAR7yUxg@mail.gmail.com>
 <alpine.DEB.2.11.1612131238260.32565@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32780 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbcLNBjs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 20:39:48 -0500
Received: by mail-qk0-f181.google.com with SMTP id x190so5181739qkb.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 17:39:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612131238260.32565@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Thanks for your response.

2016-12-13 20:40 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Tue, 13 Dec 2016, Dong Wu wrote:
>> Hi, all
>>    I have a cluster with nearly 1000 osds, and each osd already
>> occupied 2.5G physical memory on average, which cause each host 90%
>> memory useage. when use tcmalloc, we can use "ceph tell osd.* release"
>> to release unused memory, but in my cluster, ceph is build with
>> jemalloc, so can't use "ceph tell osd.* release", is there any methods
>> to release some memory?
>
> We explicitly call into tcmalloc to release memory with that command, but
> unless you've patched something in yourself there is no integration with
> jemalloc's release API.

Are there any methods to know detail memory usage of OSD, if we have a
memory allocator recording detail memory usage, will this be helpful?
Is it on the schedule?

>
>> another question:
>> can I decrease the following config value which used for cached osdmap
>>  to lower osd's memory?
>>
>> "mon_min_osdmap_epochs": "500"
>> "osd_map_max_advance": "200",
>> "osd_map_cache_size": "500",
>> "osd_map_message_max": "100",
>> "osd_map_share_max_epochs": "100"
>
> Yeah.  You should be fine with 500, 50, 100, 50, 50.

>
> sage

Thanks.
Regards.
