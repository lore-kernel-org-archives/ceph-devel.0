From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Kraken cephfs test results
Date: Fri, 13 Jan 2017 10:11:22 -0500
Message-ID: <CA+aFP1AWGfRyv-RQu3f+pu7NfxpbNWzgsDEw_9KyZ0HJhUJssA@mail.gmail.com>
References: <CALe9h7d5D=XQ_pRwZEEjY83TRY0ZzUkZX_DZ_D6mzp1L6xN_Qg@mail.gmail.com>
 <alpine.DEB.2.11.1701131453120.1911@piezo.novalocal>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33682 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdAMPL0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2017 10:11:26 -0500
Received: by mail-lf0-f51.google.com with SMTP id k86so39885888lfi.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2017 07:11:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1701131453120.1911@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

RBD still sees random failures -- I haven't been able to track it down
but I don't think it's coming from librbd nor the rbd CLI directly. I
am assuming it's just some thread race during shut down.

On Fri, Jan 13, 2017 at 9:53 AM, Sage Weil <sweil@redhat.com> wrote:
> Thanks, John!
>
> Sam, Jason, Matt, where are we at with the other subsystems?
>
> Thanks!
> sage
>
>
> On Tue, 10 Jan 2017, John Spray wrote:
>
>> Sage,
>>
>> Here are the notes on the failures on the latest cephfs tests on
>> kraken.  The tldr is that there's nothing blocking in here, but I'm
>> writing it out in full so that we can refer to this list to make sure
>> everything's backported to get the runs green.
>>
>> Cheers,
>> John
>>
>> samba:
>> * command failed with status 223 is PID file issue (pending backport)
>> http://tracker.ceph.com/issues/18309
>> * other samba failures are missing xenial packages.
>>
>> fs:
>> * test_session_reject failure is an issue with the injection path the
>> test uses (PR open) https://github.com/ceph/ceph/pull/12757
>> * test_evict_client failure is the pidfile issue (pending backport)
>> http://tracker.ceph.com/issues/18309
>> * snaptest-snap-rm-cmp.sh failure is new issue (apparently
>> intermittent), PR open https://github.com/ceph/ceph/pull/12859
>>
>> kcephfs:
>> * failures in TestClientRecovery, probably just issues with the newly
>> deployed kclient versions of the python tests (PR open)
>> http://tracker.ceph.com/issues/18396
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
