From: Haomai Wang <haomai@xsky.com>
Subject: Re: [ceph-users] Intel power tuning - 30% throughput performance increase
Date: Thu, 4 May 2017 08:58:10 +0800
Message-ID: <CACJqLyYLAo5n=Mq=nS85dVjr1aNZ0LuaQN7Rm4Du9T1L2qKkEA@mail.gmail.com>
References: <CA+z5Dsx1Fwkxxk=5N3u_Ox6m+VC_vW2oexWsF29ispcm+Hf8bA@mail.gmail.com>
 <CABZ+qqk-cN25u8vf-XWoTincF5M90_JjBGnedHvnfAcL8CUDwQ@mail.gmail.com>
 <CA+z5DswHcgddrbYnwDH7o+58sASO5jZA5ZK+-NQ60Rw+bPRKkA@mail.gmail.com>
 <CABZ+qq=+1SvbPhZOBCS0Be4Z=6LXsgck2AgK+o40BOU_BwDngQ@mail.gmail.com>
 <CA+z5DsydfEGGzmKT+mf7BqpkwsD5CwL0hNMTW2OXFPeJjDWSGQ@mail.gmail.com>
 <CABZ+qqmu2C4jdu50X2u38K9cb57c0=BdfKG0BhrjJfTQYOPcjg@mail.gmail.com>
 <CA+z5DszC6EmYSPpZsj3O0Neb-qMhfmUDjjXWpfkgukrqTyZa6A@mail.gmail.com> <CAF-wwdF-w_nBF5HN3nwMtaSxK2KM+EsdBES=HhoCa71PH8Obbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0126.outbound.protection.outlook.com ([104.47.126.126]:35688
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752375AbdEDA6S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 3 May 2017 20:58:18 -0400
Received: by mail-io0-f175.google.com with SMTP id k91so1402584ioi.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 17:58:15 -0700 (PDT)
In-Reply-To: <CAF-wwdF-w_nBF5HN3nwMtaSxK2KM+EsdBES=HhoCa71PH8Obbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

refer to https://github.com/ceph/ceph/pull/5013

On Thu, May 4, 2017 at 7:56 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> +ceph-devel to get input on whether we want/need to check the value of
> /dev/cpu_dma_latency (platform dependant) at startup and issue a
> warning, or whether documenting this would suffice?
>
> Any doc contribution would be welcomed.
>
> On Wed, May 3, 2017 at 7:18 PM, Blair Bethwaite
> <blair.bethwaite@gmail.com> wrote:
>> On 3 May 2017 at 19:07, Dan van der Ster <dan@vanderster.com> wrote:
>>> Whether cpu_dma_latency should be 0 or 1, I'm not sure yet. I assume
>>> your 30% boost was when going from throughput-performance to
>>> dma_latency=0, right? I'm trying to understand what is the incremental
>>> improvement from 1 to 0.
>>
>> Probably minimal given that represents a state transition latency
>> taking only 1us. Presumably the main issue is when the CPU can drop
>> into the lower states and the compounding impact of that over time. I
>> will do some simple characterisation of that over the next couple of
>> weeks and report back...
>>
>> --
>> Cheers,
>> ~Blairo
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> --
> Cheers,
> Brad
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
