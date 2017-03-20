From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Testing fuse implementation.
Date: Mon, 20 Mar 2017 13:38:47 -0400
Message-ID: <CAJ4mKGaU_ERDXVY8x484dv5iThSTr8RsOFd4LRzkM6_7K=8fWg@mail.gmail.com>
References: <2a2aa01a-4511-1bc2-0575-051f626575ad@digiware.nl>
 <CAJ4mKGYPLYYTooHYY8KayXxCub1OtmBVXTdXgp+5MLxo7RkzMA@mail.gmail.com> <CAOtMX2iVwM1UcD-RcPDMYpH8UTUahkJ28kfsjdkRp9ZzCENpGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:33848 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756949AbdCTSHg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Mar 2017 14:07:36 -0400
Received: by mail-ot0-f181.google.com with SMTP id o24so137273129otb.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 11:07:26 -0700 (PDT)
In-Reply-To: <CAOtMX2iVwM1UcD-RcPDMYpH8UTUahkJ28kfsjdkRp9ZzCENpGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Somers <asomers@freebsd.org>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Mar 20, 2017 at 1:35 PM, Alan Somers <asomers@freebsd.org> wrote:
> On Mon, Mar 20, 2017 at 10:57 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Mon, Mar 20, 2017 at 12:52 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> Compiling ceph-fuse-fs on FreeBSD seemed like a few (1)  very tiny
>>> change, and I'll need to update the install-deps for some extra packages.
>>> But when I run the test-set there is not much that I see that gets
>>> tested specifically for the fuse implementation.
>>>
>>> So that is hidden somewhere else...
>>> Can somebody give me a pointer?
>>
>> There's not really anything in make check for it; we rely on the
>> libcephfs tests for smoking out problems there.
>>
>> In teuthology ceph-fuse gets all kinds of proper filesystem tests run
>> on it. Just pick whatever's convenient on BSD? (On Linux I'd recommend
>> the pjd filesystem test suite, but I don't know if that's
>> BSD-compatible or not.)
>> -Greg
>
> You mean this pjd filesystem test suite?  As a matter of fact, it was
> originally written for FreeBSD.
> https://github.com/pjd/pjdfstest

Yep, that's the one. D'oh.
-Greg
