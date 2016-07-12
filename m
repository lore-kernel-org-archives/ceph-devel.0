From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD volumes for bare-metal hosts
Date: Tue, 12 Jul 2016 10:00:38 +0200
Message-ID: <CAOi1vP8Kv+m4Yza5P7iyjBG+SpcV82koai1HJpui+ULy5Op9qA@mail.gmail.com>
References: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
 <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com> <5784A047.20200@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37800 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcGLIAk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 04:00:40 -0400
Received: by mail-wm0-f45.google.com with SMTP id i5so14047777wmg.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 01:00:40 -0700 (PDT)
In-Reply-To: <5784A047.20200@easystack.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>

On Tue, Jul 12, 2016 at 9:46 AM, Dongsheng Yang
<dongsheng.yang@easystack.cn> wrote:
>
>
> On 07/06/2016 07:41 AM, Ilya Dryomov wrote:
>>
>> On Wed, Jul 6, 2016 at 12:16 AM, Radoslaw Zarzynski
>> <rzarzynski@mirantis.com> wrote:
>>>
>>> Hello Guys,
>>>
>>> I wonder about a method for providing bare-metal hosts with an access
>>> to RBD volumes.
>>>
>>> The most obvious solution is krbd. Unfortunately, it has a substantial
>>> feature gap in comparison to librbd [1][2]. exclusive-lock seems to be
>>> the basic dependency that should be satisfied to even start thinking
>>> about the rest. Is someone working on this feature? What are the plans
>>> in general?
>>
>> The code for exclusive-lock, object-map and fast-diff is pretty much
>> ready.
>
>
> Hi Ilya,
>     Sounds great! But where can I read these code, I did not find it
> in https://github.com/ceph/ceph-client. could you give a reference
> for it. thanx a lot.

It's not a final version - there are some bugs and sharp edges in
there.  But if you just want to take look:

    https://github.com/fullerdj/ceph-client/commits/wip-djf-osdc

Thanks,

                Ilya
