From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Small objects in erasure-coded pool
Date: Tue, 21 Nov 2017 12:37:16 -0800
Message-ID: <CAJ4mKGY9DM5x8K8_Cg5nJy8DJ5-+sJ8EieVo-2L4_==pvCf=nw@mail.gmail.com>
References: <01518dce-fc15-0def-958a-c916564effd6@synesis.ru>
 <CAJ4mKGZwHLgFUWinvZSg-4EhOKsW1PiEv5anUmUGWD4kb=MAvA@mail.gmail.com> <c8ac1659-6041-c549-cd2d-6c1be70ca1c6@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35561 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdKUUhR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Nov 2017 15:37:17 -0500
Received: by mail-it0-f50.google.com with SMTP id u132so3647947ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Nov 2017 12:37:17 -0800 (PST)
In-Reply-To: <c8ac1659-6041-c549-cd2d-6c1be70ca1c6@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 21, 2017 at 4:59 AM, Aleksei Gutikov
<aleksey.gutikov@synesis.ru> wrote:
>
>> What is your EC config on the pool?
> k=3 m=2, on ssds
>
>> What is the output you're using to
>> judge how much space they're taking up?
> ceph df showed max_avail~=3T for data pool
> after uploading 50M files each about 5k ceph was 100% full
> So 3T/50M ~= 60k each file occupied, this is excepting ec-coded blocks.
>
> Probably this is because of bluestore_min_alloc_size_ssd=16k
> So the granularity of occupied space is 16k*3=48k.
> Plus some space occupied by xargs (profile, etc.),
> probably 4k for each ec-coded object, i.e. 4k*3=12k
>
> So with bluestore_min_alloc_size_ssd=4k
> I expect minimal raw space occupied by 5k file:
> 3+2 erasure-coding: 4k*5 + 4k*5 = 40k
> 3x replication: (8k + 4k)*3 = 36k
>
> I plan to test this cases, but theoretically,
> are this calculations correct?

That seems about right to me. It's possible the empty data shard(s)
will only take up metadata space in rocksdb, but the EC blocks will
always have to exist. Those and the existing data blocks will all take
up a min alloc block.
