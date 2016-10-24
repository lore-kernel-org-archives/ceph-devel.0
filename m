From: kefu chai <tchaikov@gmail.com>
Subject: Re: Asking bug ceph 15113
Date: Tue, 25 Oct 2016 00:52:47 +0800
Message-ID: <CAJE9aOPiV6jsHPBOfkMeVgRTnSTGFY_Q8TxJvgdoqXjf+pqGpg@mail.gmail.com>
References: <CAJE9aOOXN8ED_6=sJ80VqU-=YxrQtPTr=NBBHQwdsBHXVx+2Dw@mail.gmail.com>
 <CAJ+86MP_7q-p63X6+6J7b7Xoiq-23RTjafo7Ux5QBwKxe1M2Cg@mail.gmail.com> <CAJE9aOOv1iRFaWuEn6K2y6fPEOKC3R+-+8Uq_bcwr+mgdUeL5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:38938 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757648AbcJXQwt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 12:52:49 -0400
Received: by mail-qk0-f181.google.com with SMTP id i34so3605947qkh.6
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 09:52:49 -0700 (PDT)
In-Reply-To: <CAJE9aOOv1iRFaWuEn6K2y6fPEOKC3R+-+8Uq_bcwr+mgdUeL5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: agung Laksono <agung.smarts@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

resending to mailing list. was rejected due to non plain-text mail.

On Fri, Oct 21, 2016 at 5:38 PM, kefu chai <tchaikov@gmail.com> wrote:
>
>
> On Monday, October 10, 2016, agung Laksono <agung.smarts@gmail.com> wrote:
>>
>> Thank you for the answer..
>>
>>
>> Could you tell me a bit about the peer.
>>
>> Does the peer means a client?
>
>
> it's very likely an osd.
>
>> when I run:
>> agung@ceph:~/project/infernalis/src$ ag --cpp ms_handle_reset
>>
>> the result shows so many places call ms_handle_reset.
>> But I am not sure which one that trigger Monitor:ms_handle_reset.
>
>
> it must be somewhere in messenger subsystem. you can set a breakpoint at
> ms_handle_reset() in gdb, and connectthe monitor with ceph cli, then kill
> it.
>
>>
>>
>>
>>
>> On Sat, Oct 8, 2016 at 10:52 AM, kefu chai <tchaikov@gmail.com> wrote:
>>>
>>> + ceph-devel
>>>
>>> On Thu, Sep 29, 2016 at 2:35 PM, agung Laksono <agung.smarts@gmail.com>
>>> wrote:
>>> >
>>> > I would like to ask you relate to ceph-15113. On the bug description,
>>> > the scenario to reproduce the bug is:
>>>
>>> this is not how the bug is reproduces, it's just my analysis of the
>>> root cause. IMO,
>>> it would be a tricky to reproduce this racing if possible.
>>>
>>> >
>>> > so the session was not removed, that's why the request was handled
>>> > after the
>>> > connection is reset. this is a race condition:
>>> >
>>> > ______________________ SafeTimer::timer_thread(), with mon_lock:
>>> > ______________________ elector: in win_election(), it
>>> > resend_routed_requests(), and collects the routed requests
>>> > msgr: in ms_handle_reset(), it reset the session
>>> > msgr: it waits for the lock
>>> > ______________________ elector: in win_election(), it handle_command(),
>>> > but
>>> > the session is reset, hence it panics.
>>> > msgr: remove session, and erase related requests from
>>> > Monitor::routed_requests.
>>> >
>>> >
>>> > I try to reproduce this bug on a cluster in my local machine and
>>> > find difficulty when reproducing ms_handle_reset.
>>> >
>>> > Does ms_handle_reset refer to Monitor::ms_handle_reset(Connection
>>> > *con)?
>>>
>>> yes.
>>>
>>> > How to trigger this function? On my study, I've put mon log when this
>>> > method
>>>
>>> when the peer resets the connection.
>>>
>>> > executed.
>>> > however, I saw that ms_handle_reset was called randomly. I mean this
>>> > function also be called
>>> > in several times when the system run.
>>> >
>>> >  Thank you in advance!
>>> >
>>> > --
>>> > Cheers,
>>> >
>>> > Agung Laksono
>>> >
>>>
>>>
>>>
>>> --
>>> Regards
>>> Kefu Chai
>>
>>
>>
>>
>> --
>> Cheers,
>>
>> Agung Laksono
>>
>
>
>
>
>
> --
> Regards
> Kefu Chai



-- 
Regards
Kefu Chai
