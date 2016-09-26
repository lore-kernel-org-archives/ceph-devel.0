From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Rust Librbd bindings
Date: Tue, 27 Sep 2016 09:09:13 +1000
Message-ID: <CAF-wwdH=6NU5uk2Cq_f5hrwbog7oLvBwgDCn-34qaJuTWGT58Q@mail.gmail.com>
References: <57E46476.5000901@canonical.com> <CAF-wwdGHMah1UWDrURCU9whhm_d7o+DsGim4HUQWZVTrd2-Xmg@mail.gmail.com>
 <57E53589.7090102@canonical.com> <CALqRxCwOvn5Sq+J8Wsf4QR8jJQ7_=fOYQ-4S3jsiwmfJrgYr_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35784 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754795AbcIZXJP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 19:09:15 -0400
Received: by mail-lf0-f54.google.com with SMTP id l131so164009026lfl.2
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 16:09:14 -0700 (PDT)
In-Reply-To: <CALqRxCwOvn5Sq+J8Wsf4QR8jJQ7_=fOYQ-4S3jsiwmfJrgYr_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: chris holcombe <chris.holcombe@canonical.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 27, 2016 at 4:25 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> Can we just move it instead of forking? It'll be less confusing for users :)
>
> https://github.com/cholcombe973/librbd-sys/settings, click the "Transfer" button

And is LibRBD-Sys the actual name? Could we make it something more
rust-specific at least?

>
> - Ken
>
> On Fri, Sep 23, 2016 at 8:00 AM, chris holcombe
> <chris.holcombe@canonical.com> wrote:
>> Any ceph dev's with permissions willing to fork it?
>>
>> On 09/22/2016 07:04 PM, Brad Hubbard wrote:
>>> On Fri, Sep 23, 2016 at 9:08 AM, chris holcombe
>>> <chris.holcombe@canonical.com> wrote:
>>>> Hey Ceph Devs,
>>>>
>>>> Now that the precedent is set I'd like to offer my librbd bindings up to
>>>> be included on the main github.com/ceph page.  My repo lives at:
>>>> https://github.com/cholcombe973/librbd-sys.  I'd be happy to add more
>>>> docs to it and expand on the README.md if there's interest in having
>>>> this included.
>>>
>>> This just requires someone with permissions to fork it into the ceph space.
>>>
>>>>
>>>> Thanks,
>>>> Chris
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
