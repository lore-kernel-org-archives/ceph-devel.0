From: kefu chai <tchaikov@gmail.com>
Subject: Re: unable to build Debian Stretch for 12.1.2
Date: Tue, 1 Aug 2017 21:35:54 +0800
Message-ID: <CAJE9aOP6Ro+WcCiBv=O45B=p60DszEF8KjW1sYxbx0QvDLmhXQ@mail.gmail.com>
References: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com>
 <CAF-wwdE4kBKzDjbRNiKwdZ9W9TV9sdd6TJiTZ-MorhKJyUpL3g@mail.gmail.com>
 <CAC-Np1xnvw9KtwdKcTLTsKdarWH25FAeoExWhzB0Ad+TuTHM4A@mail.gmail.com>
 <CAF-wwdFhpUowuBT7Rxfmw4wPQUWHnxF7ZKQ0hRMoPo79cY-hEQ@mail.gmail.com>
 <CAF-wwdHQ9Zcp58VBBGqFOTFGz5acsLxe5ZVXX9jTyc_uSSAzvw@mail.gmail.com>
 <68916451.345723.1501076601021.JavaMail.zimbra@oxygem.tv> <CALqRxCx2N6BswvPJXfcpDyPd9dNXhV7P3h-km0NbW7w7eQoiJg@mail.gmail.com>
 <CAC-Np1xuNEo+hX_wvLDN8rmQP_xK1DE7Yf66zzBe33Gz4c+7+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34901 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdHANfz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Aug 2017 09:35:55 -0400
Received: by mail-vk0-f65.google.com with SMTP id x10so743756vkd.2
        for <ceph-devel@vger.kernel.org>; Tue, 01 Aug 2017 06:35:55 -0700 (PDT)
In-Reply-To: <CAC-Np1xuNEo+hX_wvLDN8rmQP_xK1DE7Yf66zzBe33Gz4c+7+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Alexandre DERUMIER <aderumier@odiso.com>, Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 1, 2017 at 8:06 PM, Alfredo Deza <adeza@redhat.com> wrote:
> On Mon, Jul 31, 2017 at 6:20 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> On Wed, Jul 26, 2017 at 7:43 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
>>> Hi,
>>>
>>> It's building fine here on a real debian strech.
>>>
>>> git clone https://github.com/ceph/ceph
>>> git submodule update --force --init --recursive
>>> git checkout v12.1.1
>>
>> That looks like an older version, and Alfredo's seeing this crash in 12.1.2.
>>
>> Would you please try within pbuilder?
>
> Right, I was trying to build 12.1.2 (un-released) so that would
> effectively be the tip of the luminous branch (which at that time was
> the same as master iirc)
>
> And we couldn't replicate this without pbuilder running on a Xenial
> box, *and* it worked fine for 12.1.1

i just built 901f14aa7c62ae16072239202a1a9b8329ef3c84 fine in a
stretch docker env.

$ git describe
v12.1.1-870-g901f14aa7c

$ gcc --version
gcc (Debian 6.3.0-18) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

i will try with pbuilder later on.

>
>>
>> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
