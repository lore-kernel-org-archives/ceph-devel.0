From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: teuthology SELinux failures
Date: Thu, 1 Jun 2017 09:50:25 -0700
Message-ID: <CAMMFjmE8vy_h8uNtJW4bHVDa=MGMsX0C+ecTSXsFoFs=kSH1NQ@mail.gmail.com>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
 <1496331233.10067.1.camel@redhat.com> <CAKPXa=Ydy_KAoFaUrnMPWA51S_D3snjPPfAtGW5oE=omi41ENg@mail.gmail.com>
 <CALe9h7ch+6NHLEhC=YDAaY77ki-Xo-L0Eh5m9XsaGWRAsPETfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37899 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdFAQu1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 12:50:27 -0400
Received: by mail-wm0-f47.google.com with SMTP id n195so40166138wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 09:50:26 -0700 (PDT)
In-Reply-To: <CALe9h7ch+6NHLEhC=YDAaY77ki-Xo-L0Eh5m9XsaGWRAsPETfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Vasu Kulkarni <vakulkar@redhat.com>, Boris Ranto <branto@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

all k* suites run with -k testing in nightlies

On Thu, Jun 1, 2017 at 9:39 AM, John Spray <jspray@redhat.com> wrote:
> On Thu, Jun 1, 2017 at 5:15 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
>> I believe the nodes are pretty much messed up with various kernel
>> versions, ideally we should not be seeing this on distro kernel(as per
>> Boris's comment)
>> so probably we should just schedule kernel client tests on vps so that
>> the smithi's and mira's have only latest distro kernels for other
>> suites for correct testing.
>
> We do need to be able to run with "-k testing" for kcephfs, knfs and
> multimds suites (this has always been the case), and I don't think to
> move all those off of our main test nodes would be realistic.
>
> Folks can already use "-k distro" on their runs (I have use this on
> all my fs suite runs for a long time), it would probably make sense
> for teuthology to use that as the default so that people are not
> getting a random kernel.
>
> John
>
>> Also it would be nice to automatically reimage the nodes back to
>> distro once in a week.
>>
>> On Thu, Jun 1, 2017 at 8:33 AM, Boris Ranto <branto@redhat.com> wrote:
>>> I did not check all of the failed tests but those that I checked
>>> complained about dac_read_search. The dac_* family of capabilities
>>> complains that root is trying to access a file that the standard
>>> permissions does not allow him (root) to access (i.e. having 600 and
>>> ceph/ceph user/group).
>>>
>>> However, there is a lot of dac_* failures all throughout the system and
>>> the target contexts are different for these files (i.e. there would
>>> have to be a lot of files like that) so I am inclined to say that this
>>> is a kernel bug. Especially considering that this does not present in
>>> older/stock kernels where there already is a dac_override support.
>>>
>>> Anyway, it should be safe to ignore these (not our processes, not our
>>> files...)
>>>
>>> Regards,
>>> Boris
>>>
>>>
>>> On Wed, 2017-05-31 at 13:23 -0700, Yehuda Sadeh-Weinraub wrote:
>>>> We started seeing SELinux related failures in recent teuthology run,
>>>> e.g.:
>>>> http://pulpito.ceph.com/yehudasa-2017-05-30_14:55:10-rgw-wip-rgw-mdse
>>>> arch---basic-smithi/
>>>>
>>>> It seems that it's unrelated to the runs themselves, possibly postfix
>>>> that's running in the background is triggering these. Any idea what
>>>> we
>>>> should do there?
>>>>
>>>> Yehuda
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
