From: Padmanabh Ratnakar <padmanabh.ratnakar@snapdeal.com>
Subject: Re: Assert in Pipe.cc in Hammer 0.94.7
Date: Wed, 25 Jan 2017 21:42:32 +0530
Message-ID: <CAC+4SSj5aQJWUrxz-v=JSWzm4CqPu=kgUej2_Bs3zoqyJy0dZQ@mail.gmail.com>
References: <CAC+4SSg2EM_7sWvOrkUNCzZ9_tf5ew2MKqw30Db1c-LFEbNrLg@mail.gmail.com>
 <CAJ4mKGYrJL1JXwRDRQHg_iJPqsQN_ppRzLAVs0rt9PyLSRnnHw@mail.gmail.com>
 <CAC+4SSicN8GK+09Wf=fDyOeGSfeTjO35=ZnUP987YC3W=aW7Jw@mail.gmail.com> <CAJ4mKGY-vCXobE51rU_-VAbgvKhCKpX1bSNzXeuJD3TKwE5KNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:36003 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdAYQMd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2017 11:12:33 -0500
Received: by mail-yb0-f178.google.com with SMTP id 123so14019677ybe.3
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jan 2017 08:12:33 -0800 (PST)
In-Reply-To: <CAJ4mKGY-vCXobE51rU_-VAbgvKhCKpX1bSNzXeuJD3TKwE5KNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>     if (reply.tag == CEPH_MSGR_TAG_WAIT) {
>>       ldout(msgr->cct,3) << "connect got WAIT (connection race)" << dendl;
>>       state = STATE_WAIT;
>>       goto stop_locked;
>>     }
>
> You're skipping over the part where, immediately after taking the
> pipe_lock back, we check for this case (and similar ones):
>
>>    pipe_lock.Lock();
>>    if (state != STATE_CONNECTING) {
>>      ldout(msgr->cct,0) << "connect got RESETSESSION but no longer connecting" << dendl;
>>      goto stop_locked;
>>    }
>
> https://github.com/ceph/ceph/blob/v0.94.1.7/src/msg/simple/Pipe.cc#L1078
>
> :)
>
> Obviously there's an issue somewhere or you wouldn't have hit an
> assert, but I'm not sure where and I'm pretty sure if you ever see it
> again, it's something fixed in later source revisions (...which we may
> not have backported once hammer reached EoL).
> -Greg

Sorry my bad. I missed this somehow. :)
Thanks for clearing my doubt.

Thanks,
Padmanabh
