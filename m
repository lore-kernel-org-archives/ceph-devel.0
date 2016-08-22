From: Ning Yao <zay11022@gmail.com>
Subject: Re: why rbd journaling first write journal to journal pool and then
 write data
Date: Mon, 22 Aug 2016 18:37:52 +0800
Message-ID: <CALZt5jxa9FPnFD3KSEb3wy5gjWCJubj0m3Hn4rXvGCeyf4wm8w@mail.gmail.com>
References: <CAKZcxgdqLtdyLPF-dXczMu1hWjbtoF3i2iugDJH1ngtmqNLNNA@mail.gmail.com>
 <FCFF045F-961E-4FCF-973F-9D0DFB6469DC@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32882 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbcHVKhy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 06:37:54 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so80916837qkc.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 03:37:53 -0700 (PDT)
In-Reply-To: <FCFF045F-961E-4FCF-973F-9D0DFB6469DC@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <ricardo.dias@suse.com>
Cc: Jaze Lee <jazeltq@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, Ricardo

I got what you mean.

First of all, if we enable the rbd journaling, currently  write
latency will be doubled since it should wait for finish of the write
operation.

So If the issue is what you mentioned above. I think we have some
other ways to solve it. For example, we can snapshot the primary image
and run a whole image scan to find those objects which is different
from each other. And then delete the snapshot on the primary and
continue to replying journal again.  In this way, we can also maintain
the image consistency?
Regards
Ning Yao


2016-08-22 17:31 GMT+08:00 Ricardo Dias <ricardo.dias@suse.com>:
> Hi Jaze,
>
> If you write data first, and you have a failure after writing data and be=
fore writing to the journal, then you cannot recover that write operation a=
nd it will be lost.
>
> You can see the journal as a primary replica of data.
>
> Ricardo Dias
>
> Sent from my mobile phone
>
>> On 22 Aug 2016, at 09:46, Jaze Lee <jazeltq@gmail.com> wrote:
>>
>> Hi all:
>>   I found that rbd journaling first write journal and then write data.
>>   Why we not first write data and then write journal? Is there some
>> considerration
>>   for which is first ?
>>
>>   Thanks a lot.
>>
>> --
>> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
