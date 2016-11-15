From: Tianshan Qu <qutianshan@gmail.com>
Subject: Re: rgw/multisite: unlock failure problem
Date: Tue, 15 Nov 2016 16:30:59 +0800
Message-ID: <CAEv+sP4JY_7QrQdtix8gy4ZyRQ8LP3834ZCVY80xaQUdTFd-sg@mail.gmail.com>
References: <CAEv+sP6p9sdMt61yucxy10azo5jwQf-e765YbcHvDYQcXrfWPQ@mail.gmail.com>
 <CADRKj5Rp-EB=nnxne55t4d+PWV5Uqpxx7LoGp4FYnnmhj6_6Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33735 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941318AbcKOIbB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2016 03:31:01 -0500
Received: by mail-ua0-f171.google.com with SMTP id 20so82560015uak.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2016 00:31:00 -0800 (PST)
In-Reply-To: <CADRKj5Rp-EB=nnxne55t4d+PWV5Uqpxx7LoGp4FYnnmhj6_6Nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/17907

2016-11-15 5:26 GMT+08:00 Yehuda Sadeh-Weinraub <yehuda@redhat.com>:
> On Sun, Nov 13, 2016 at 10:40 PM, Tianshan Qu <qutianshan@gmail.com> wrote:
>> Hi:
>>
>> There is a problem with unlock multiste sync log.
>> The situation is set rgw_num_rados_handles > 1 and
>> rgw_num_async_rados_threads default 32. since multisite use async
>> thread pool, so lock and unlock operation may get different threads,
>> which may direct to different rados handles, and lock operation use
>> client.xxxx to identify owner, different rados handles means different
>> client, leads to unlock fail, and next lock will return locked, rgw
>> log will show many -16 error.
>> Is there a good way to solve this?
>
> Can you open a ceph tracker issue for that?
>
> Thanks,
> Yehuda
