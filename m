From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: Re: latency compare between 2t NVME SSD P3500 and bluestore
Date: Wed, 12 Jul 2017 20:45:47 +0800
Message-ID: <CAMwhyqX=ZNTpfK7t3+ajqJZ6D-YrcdkCeVCCy=oX5iDLMxjC-w@mail.gmail.com>
References: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
 <alpine.DEB.2.11.1707121158300.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35377 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdGLMpt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 08:45:49 -0400
Received: by mail-ua0-f169.google.com with SMTP id j53so13408069uaa.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 05:45:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707121158300.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, p.zhou@alibaba-inc.com

Hi Sage,

Yes, I totally understand bluestore did much more things than a raw
disk, but the current overhead is a little too big to our usage. I
will compare bluestore with XFS(also has metadata tracking,
allocation, and so on), and to see if XFS also has such impact.

I would like to give a flamegraph later, but from the perfcounter, we
could find most of time were spent in "kv_lat".

For FTL, yes, it is a good idea, after we get the flame graph, we
could discuss which part could be improved by FTL, firmware, even open
channel.





2017-07-12 20:02 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>> Hi Cephers,
>>
>> I did some experiment today to compare the latency between one
>> P3500(2T nvme SSD) and bluestore(fio + libfio_objectstore.so):
>>
>> For iodepth =3D 1, the random write latency of bluestore is 276.91us,
>> compare with 14.71 of SSD, big overhead.
>>
>> I also test iodepth =3D 16, Still, there is a big overhead.(143 us -> 64=
2 us)
>>
>> What is your opinion?
>
> There is a lot of work that bluestore is doing over the raw device as it
> is implementing all of the metadata tracking, checksumming, allocation,
> and so on.  There's definitely lots of room for improvement, but I'm
> not sure you can expect to see latencies in the 10s of us.  That said, it
> would be interesting to see an updated flamegraph to see where the time i=
s
> being spent and where we can slim this down.  On a new nvme it's possible
> we can do away with some of the complexity of, say, the allocator, since
> the FTL is performing a lot of the same work anyway.
>
> sage
