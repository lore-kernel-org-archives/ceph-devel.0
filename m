From: Ning Yao <zay11022@gmail.com>
Subject: Re: cls_rbd copyup and write
Date: Wed, 28 Jun 2017 12:09:24 +0800
Message-ID: <CALZt5jwW2kdR8WnXfkrj7SLTvNFkX5KxgOygFOB4y7f8FdTAng@mail.gmail.com>
References: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
 <alpine.DEB.2.11.1706271339330.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36942 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdF1EJZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 00:09:25 -0400
Received: by mail-it0-f51.google.com with SMTP id m84so27007040ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 21:09:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706271339330.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2017-06-27 21:42 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Tue, 27 Jun 2017, Ning Yao wrote:
>> Hi, all
>>
>> currently I find that when do copy on write for a clone image. librbd
>> call the cls copyup function to write the data, reading from its
>> parent, to the child.
>>
>> However, there is a issue here:  if an object in the parent image -->
>> [0, 8192] with data and [8192, end] without data, then after COW
>> operation, it will filling the whole object [0, end] to the children
>> object with [8192, end] all zeros. This phenomenon also occurs in
>> flatten images.
>
> Note that BlueStore (luminous) doesn't have this issue: the clone is an
> O(1) metadata operation and subsequent writes are basically copy-no-write.
Do we say the same things? the osd-side clone ops only occurs for rbd
snapshot. what I said is rbd clone, which is the layering feature in
red-client side.


>> Actually, we already have sparse_read to just read data without holes.
>> However, copyup function does not support to write serveral fragments
>> such as {[0, 8192], [16384,20480]}.
>>
>> So it that possible to direct send OSDOp {[cow write], [cow write],
>> [user write]} instead of  OSDOp {[copyup], [user write]} ?
>
> It seems like the better fix for FileStore is to make the copyup operation
> do a sparse_read and write only the allocated ranges.  I think the only
> issue there is that the two mechanisms for making sparse_read actually
> sparse are fiemap and seek_hole_data, both of which are disabled by
> default because they rely on newish or buggy-in-the-past kernel APIs and
> we want to avoid hard to diagnose breakage.  They should be enabled with
> caution.
>
> sage
