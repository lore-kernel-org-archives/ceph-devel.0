From: kefu chai <tchaikov@gmail.com>
Subject: Re: rocksdb breakage on master?
Date: Fri, 28 Oct 2016 19:06:42 +0800
Message-ID: <CAJE9aOPgE8ojx4X0YnEBFy2pcUe0bjSKXCi8=0=14t_ydHwX9w@mail.gmail.com>
References: <CALe9h7e27rDp7V9CCWdyQrAvDZ67kJbQVS5fYV0zdt9B4Lj0MA@mail.gmail.com>
 <CAJE9aOPoK3G6gF1AAojCFq3mMXZ7j2awypw4fHp+72wcJznKAg@mail.gmail.com> <CAJE9aONTbGWqctP06jaJifbzY=ngWaNTvRtQqOBxDQoQZUfA9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:32833 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbcJ1LGo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2016 07:06:44 -0400
Received: by mail-qk0-f176.google.com with SMTP id v138so26630872qka.0
        for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2016 04:06:43 -0700 (PDT)
In-Reply-To: <CAJE9aONTbGWqctP06jaJifbzY=ngWaNTvRtQqOBxDQoQZUfA9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Bassam Tabbara <bassamtabbara@hotmail.com>, Kefu Chai <kchai@redhat.com>

https://github.com/ceph/ceph/pull/11677

On Fri, Oct 28, 2016 at 6:55 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Fri, Oct 28, 2016 at 4:43 PM, kefu chai <tchaikov@gmail.com> wrote:
>> On Fri, Oct 28, 2016 at 1:37 AM, John Spray <jspray@redhat.com> wrote:
>>> I had a totally failing test branch based on recent master:
>>> http://pulpito.ceph.com/jspray-2016-10-27_14:08:19-fs-wip-jcsp-testing-20161026-distro-basic-mira
>>>
>>> With OSD coredumps and failures like this:
>>>> Command failed on mira110 with status 132: 'sudo MALLOC_CHECK_=3 adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage ceph-osd --cluster ceph --mkfs --mkkey -i 0 --monmap /home/ubuntu/cephtest/ceph.monmap'
>>>
>>> So I tried reverting these two guys:
>>> 418bfd7bb5ec1dcec2b011e9df118c33ce38d398 cmake: use external project for rocksdb
>>> 5bbcf8547c45eb962507d26649cab2c1dec20dc6 pickup new rocksdb with
>>> support for linux cmake
>>> ( from PR https://github.com/ceph/ceph/pull/11385)
>>>
>>> ...and my current run seems to be passing.
>>
>> John and all, sorry for the inconvenience. i am looking at it.
>
> it's the march=native option in the cmake script used by rocksdb. and
> the building machine has the avx instruction set, while the test node
> does not. i am preparing a fix now.
>
>>
>>
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Regards
>> Kefu Chai
>
>
>
> --
> Regards
> Kefu Chai



-- 
Regards
Kefu Chai
