From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: Re: Small objects in erasure-coded pool
Date: Tue, 21 Nov 2017 15:59:54 +0300
Message-ID: <c8ac1659-6041-c549-cd2d-6c1be70ca1c6@synesis.ru>
References: <01518dce-fc15-0def-958a-c916564effd6@synesis.ru>
 <CAJ4mKGZwHLgFUWinvZSg-4EhOKsW1PiEv5anUmUGWD4kb=MAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:42011 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbdKUM76 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Nov 2017 07:59:58 -0500
Received: by mail-lf0-f42.google.com with SMTP id m1so13995761lfj.9
        for <ceph-devel@vger.kernel.org>; Tue, 21 Nov 2017 04:59:57 -0800 (PST)
In-Reply-To: <CAJ4mKGZwHLgFUWinvZSg-4EhOKsW1PiEv5anUmUGWD4kb=MAvA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


 > What is your EC config on the pool?
k=3 m=2, on ssds

 > What is the output you're using to
 > judge how much space they're taking up?
ceph df showed max_avail~=3T for data pool
after uploading 50M files each about 5k ceph was 100% full
So 3T/50M ~= 60k each file occupied, this is excepting ec-coded blocks.

Probably this is because of bluestore_min_alloc_size_ssd=16k
So the granularity of occupied space is 16k*3=48k.
Plus some space occupied by xargs (profile, etc.),
probably 4k for each ec-coded object, i.e. 4k*3=12k

So with bluestore_min_alloc_size_ssd=4k
I expect minimal raw space occupied by 5k file:
3+2 erasure-coding: 4k*5 + 4k*5 = 40k
3x replication: (8k + 4k)*3 = 36k

I plan to test this cases, but theoretically,
are this calculations correct?

Thanks
