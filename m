From: John Spray <jspray@redhat.com>
Subject: Re: teuthology SELinux failures
Date: Tue, 6 Jun 2017 14:26:29 +0100
Message-ID: <CALe9h7fpmcZ6BwEA8=gZAa-MGNm8COotvdPMrokLk0Ah__RDnA@mail.gmail.com>
References: <CADRKj5QHS+qeB3jLJf4y9LVtoZ9pZSxiswO=64eTgGQm6ScdJA@mail.gmail.com>
 <CALe9h7fuiqMFTsEPaLa1uSpBnVj2L8M=dacAVy0ZMiAE+Uzs9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33464 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdFFN0v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 09:26:51 -0400
Received: by mail-wr0-f170.google.com with SMTP id v104so54216166wrb.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 06:26:51 -0700 (PDT)
In-Reply-To: <CALe9h7fuiqMFTsEPaLa1uSpBnVj2L8M=dacAVy0ZMiAE+Uzs9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>, Ilya Dryomov <idryomov@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Adding Ilya and Zheng -- do you guys happen to know what might have
changed in the current testing kernel to start seeing all these
selinux issues?  I'm still seeing it in my latest runs.

Here's a recent example:
http://qa-proxy.ceph.com/teuthology/jspray-2017-06-05_15:00:03-multimds-wip-jcsp-testing-20170604-testing-basic-smithi/1260536/teuthology.log

John

On Wed, May 31, 2017 at 10:12 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, May 31, 2017 at 9:23 PM, Yehuda Sadeh-Weinraub
> <yehuda@redhat.com> wrote:
>> We started seeing SELinux related failures in recent teuthology run, e.g.:
>> http://pulpito.ceph.com/yehudasa-2017-05-30_14:55:10-rgw-wip-rgw-mdsearch---basic-smithi/
>>
>> It seems that it's unrelated to the runs themselves, possibly postfix
>> that's running in the background is triggering these. Any idea what we
>> should do there?
>
> My assumption had been that the new failures were from a kernel
> change, because I had two runs overnight, one with "-k distro" and one
> with "-k testing", and it was only the testing one that had the masses
> of selinux failure.
>
> Possibly these rgw jobs did not have a -k flag and therefore ended up
> with the testing kernel that had been installed with previous jobs.
>
> I have no insight about the nature of the selinux breakage itself though!
>
> John
>
>>
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
