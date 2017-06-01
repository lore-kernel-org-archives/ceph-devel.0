From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: teuthology SELinux failures
Date: Thu, 1 Jun 2017 09:15:58 -0700
Message-ID: <CAKPXa=Ydy_KAoFaUrnMPWA51S_D3snjPPfAtGW5oE=omi41ENg@mail.gmail.com>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
 <1496331233.10067.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33635 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdFAQQE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 12:16:04 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so31399567pfh.0
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jun 2017 09:16:04 -0700 (PDT)
In-Reply-To: <1496331233.10067.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Ranto <branto@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I believe the nodes are pretty much messed up with various kernel
versions, ideally we should not be seeing this on distro kernel(as per
Boris's comment)
so probably we should just schedule kernel client tests on vps so that
the smithi's and mira's have only latest distro kernels for other
suites for correct testing.

Also it would be nice to automatically reimage the nodes back to
distro once in a week.

On Thu, Jun 1, 2017 at 8:33 AM, Boris Ranto <branto@redhat.com> wrote:
> I did not check all of the failed tests but those that I checked
> complained about dac_read_search. The dac_* family of capabilities
> complains that root is trying to access a file that the standard
> permissions does not allow him (root) to access (i.e. having 600 and
> ceph/ceph user/group).
>
> However, there is a lot of dac_* failures all throughout the system and
> the target contexts are different for these files (i.e. there would
> have to be a lot of files like that) so I am inclined to say that this
> is a kernel bug. Especially considering that this does not present in
> older/stock kernels where there already is a dac_override support.
>
> Anyway, it should be safe to ignore these (not our processes, not our
> files...)
>
> Regards,
> Boris
>
>
> On Wed, 2017-05-31 at 13:23 -0700, Yehuda Sadeh-Weinraub wrote:
>> We started seeing SELinux related failures in recent teuthology run,
>> e.g.:
>> http://pulpito.ceph.com/yehudasa-2017-05-30_14:55:10-rgw-wip-rgw-mdse
>> arch---basic-smithi/
>>
>> It seems that it's unrelated to the runs themselves, possibly postfix
>> that's running in the background is triggering these. Any idea what
>> we
>> should do there?
>>
>> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
