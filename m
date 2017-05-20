From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: [ceph-users] Intel power tuning - 30% throughput performance increase
Date: Sat, 20 May 2017 10:14:29 +1000
Message-ID: <CAF-wwdGF0-vNEfh+R_dq2qArup4PumXha3Judr79n85x4K7Jmg@mail.gmail.com>
References: <CA+z5Dsx1Fwkxxk=5N3u_Ox6m+VC_vW2oexWsF29ispcm+Hf8bA@mail.gmail.com>
 <CABZ+qqk-cN25u8vf-XWoTincF5M90_JjBGnedHvnfAcL8CUDwQ@mail.gmail.com>
 <CA+z5DswHcgddrbYnwDH7o+58sASO5jZA5ZK+-NQ60Rw+bPRKkA@mail.gmail.com>
 <CABZ+qq=+1SvbPhZOBCS0Be4Z=6LXsgck2AgK+o40BOU_BwDngQ@mail.gmail.com>
 <CA+z5DsydfEGGzmKT+mf7BqpkwsD5CwL0hNMTW2OXFPeJjDWSGQ@mail.gmail.com>
 <CABZ+qqmu2C4jdu50X2u38K9cb57c0=BdfKG0BhrjJfTQYOPcjg@mail.gmail.com>
 <CA+z5DszC6EmYSPpZsj3O0Neb-qMhfmUDjjXWpfkgukrqTyZa6A@mail.gmail.com>
 <CAF-wwdF-w_nBF5HN3nwMtaSxK2KM+EsdBES=HhoCa71PH8Obbg@mail.gmail.com>
 <CACJqLyYLAo5n=Mq=nS85dVjr1aNZ0LuaQN7Rm4Du9T1L2qKkEA@mail.gmail.com>
 <CAF-wwdEF7ReHz+wjZBTcdJ=Xh3UQ8dGEjJtxhosPXra4xm2t9A@mail.gmail.com>
 <CAEYCsV+5-0euXPHAHsrko9DUeA4H3krNSZyZU1Kioyw9Dg4w7w@mail.gmail.com> <CALJWc2tv8wRWYciRfMsGFV5wZk2eko5dNRdWm=A5jHOCVV1XGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38614 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdETAOb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 20:14:31 -0400
Received: by mail-it0-f45.google.com with SMTP id e65so55282939ita.1
        for <ceph-devel@vger.kernel.org>; Fri, 19 May 2017 17:14:30 -0700 (PDT)
In-Reply-To: <CALJWc2tv8wRWYciRfMsGFV5wZk2eko5dNRdWm=A5jHOCVV1XGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiaoguang fan <fanxiaoguang008@gmail.com>
Cc: Xiaoxi Chen <superdebuger@gmail.com>, Haomai Wang <haomai@xsky.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

It just came to my attention that Intel has advised Red Hat never to
lock in C0 as it may affect the life expectancy of server components
such as fans and the CPUs themselves.

FYI, YMMV.

On Fri, May 19, 2017 at 5:53 PM, xiaoguang fan
<fanxiaoguang008@gmail.com> wrote:
> I have done a test about close c-stat , but performance didn't increase
>
>
>
> 2017-05-19 15:23 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
>>
>> would be better to document it first on "Known system-wise tuning
>> knobs" in the doc?
>>
>>
>> 2017-05-05 8:28 GMT+08:00 Brad Hubbard <bhubbard@redhat.com>:
>> > On Thu, May 4, 2017 at 10:58 AM, Haomai Wang <haomai@xsky.com> wrote:
>> >> refer to https://github.com/ceph/ceph/pull/5013
>> >
>> > How about we issue a warning about possible performance implications
>> > if we detect this is not set to 1 *or* 0 at startup?
>> >
>> >>
>> >> On Thu, May 4, 2017 at 7:56 AM, Brad Hubbard <bhubbard@redhat.com>
>> >> wrote:
>> >>> +ceph-devel to get input on whether we want/need to check the value of
>> >>> /dev/cpu_dma_latency (platform dependant) at startup and issue a
>> >>> warning, or whether documenting this would suffice?
>> >>>
>> >>> Any doc contribution would be welcomed.
>> >>>
>> >>> On Wed, May 3, 2017 at 7:18 PM, Blair Bethwaite
>> >>> <blair.bethwaite@gmail.com> wrote:
>> >>>> On 3 May 2017 at 19:07, Dan van der Ster <dan@vanderster.com> wrote:
>> >>>>> Whether cpu_dma_latency should be 0 or 1, I'm not sure yet. I assume
>> >>>>> your 30% boost was when going from throughput-performance to
>> >>>>> dma_latency=0, right? I'm trying to understand what is the
>> >>>>> incremental
>> >>>>> improvement from 1 to 0.
>> >>>>
>> >>>> Probably minimal given that represents a state transition latency
>> >>>> taking only 1us. Presumably the main issue is when the CPU can drop
>> >>>> into the lower states and the compounding impact of that over time. I
>> >>>> will do some simple characterisation of that over the next couple of
>> >>>> weeks and report back...
>> >>>>
>> >>>> --
>> >>>> Cheers,
>> >>>> ~Blairo
>> >>>> _______________________________________________
>> >>>> ceph-users mailing list
>> >>>> ceph-users@lists.ceph.com
>> >>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >>>
>> >>>
>> >>>
>> >>> --
>> >>> Cheers,
>> >>> Brad
>> >>> _______________________________________________
>> >>> ceph-users mailing list
>> >>> ceph-users@lists.ceph.com
>> >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>> >
>> >
>> > --
>> > Cheers,
>> > Brad
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



-- 
Cheers,
Brad
