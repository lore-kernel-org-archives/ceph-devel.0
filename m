From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: =?UTF-8?Q?Re:_[ceph/ceph]_librados:_Fix_a_potential_risk_of_buffer:?=
 =?UTF-8?Q?:list::claim=5fprepend=28list&_b=e2=80=a6_=28#17661=29?=
Date: Mon, 18 Sep 2017 10:05:01 +0200
Message-ID: <e08cd364-a997-b282-a164-c4e79d00a98f@corp.ovh.com>
References: <CAF3FU86j+f16H+KOK7bRfjbfBjpDcPfVKg-2es0egFjy6VoB0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo302.mail-out.ovh.net ([137.74.110.74]:42164 "EHLO
        1.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbdIRIXk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 04:23:40 -0400
Received: from EX3.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo302.mail-out.ovh.net (Postfix) with ESMTPS id 846A61F6BD
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 10:05:43 +0200 (CEST)
In-Reply-To: <CAF3FU86j+f16H+KOK7bRfjbfBjpDcPfVKg-2es0egFjy6VoB0Q@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 17-09-18 09:47 AM, 关云飞 wrote:
> hello kefu chai,
> 
> These two days I carefully considered the pr 17661 and looked the code
> about bufferlist and I still think the steps of 1-3 is needed.
>   Although the ptr::_off can guarantee bufferlist to be
> copied/read/decode/write_file rightly, this will lead a bufferlist not
> clean and
> will waste memory like the picture in annex.
> 
> Of course, it's also possible that i am not thinking about it, do you
> have any suggestions?

In your diagram, you show the case where allocated memory blocks are 
underutilized, wasting memory. If I understand you (and code from your PR) 
correctly, you want to move data from the middle of allocated blocks to 
front of them to reclaim memory - but the way you propose isn't any good 
really, you allocate new block of memory (and accompanying bufferptr), copy 
data from existing block to newly allocated one, then destroy old - this is 
very expensive CPU-wise, way more expensive than leaving these bytes wasted. 
Most of the time it wouldn't matter anyway, as most of bufferlists have 
limited lifetime and would get destroyed soon.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
