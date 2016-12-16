From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Computation in the storage
Date: Fri, 16 Dec 2016 10:22:33 -0800
Message-ID: <CAB2gnbUEeS6AynJ0AjdpJ+MbiGSq_HUkBS-KdnXrke1wiJYsyA@mail.gmail.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de> <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
 <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com> <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
 <64D605E0-8851-4F60-B0AB-864CBDA7B3F7@Teradata.com> <208C08FF-0104-425C-B7AA-B0930A76F46E@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35634 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759045AbcLPSWf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 13:22:35 -0500
Received: by mail-oi0-f50.google.com with SMTP id b126so86262434oia.2
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 10:22:34 -0800 (PST)
In-Reply-To: <208C08FF-0104-425C-B7AA-B0930A76F46E@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Joao Eduardo Luis <joao@suse.de>, "nebil.benmabrouk@orange.com" <nebil.benmabrouk@orange.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Nitin,

The links on the blog are out of date. Lua support has been merged.
See https://github.com/ceph/ceph/tree/master/src/cls/lua

- Noah

On Fri, Dec 16, 2016 at 10:00 AM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
> Hi Noah,
>
> I looked at your blog [0] about implementing RADOS object classes using Lua scripts. The
> link [1] to the source code in ceph repository is missing. Seems like this support has been
> removed from upstream ceph, and it is not supported by the ceph releases as of now.
> Can you confirm?
>
>
> [0] http://noahdesu.github.io/2015/12/14/towards-rados-object-class-management.html
> [1] https://github.com/ceph/ceph/tree/cls-lua
>
> Thanks,
> Nitin
>
>
>> On Dec 5, 2016, at 3:08 PM, Kamble, Nitin A <Nitin.Kamble@Teradata.com> wrote:
>>
>>
>>> On Dec 4, 2016, at 3:02 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
>>>
>>> On Fri, Dec 2, 2016 at 3:04 PM, Kamble, Nitin A
>>> <Nitin.Kamble@teradata.com> wrote:
>>>>
>>>> Is anybody using real RADOS object classes on ceph clusters? Any of them on github?
>>>> I would like to look at some of the real world examples if it is there.
>>>> And more documentation of this feature would definitely help too.
>>>
>>> We use object classes [0] for a distributed shared log [1] on Ceph.
>>>
>>> [0]: https://github.com/noahdesu/ceph/blob/zlog/jewel/src/cls/zlog/cls_zlog.cc
>>> [1]: https://github.com/noahdesu/zlog
>
