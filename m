From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Assert in Pipe.cc in Hammer 0.94.7
Date: Tue, 24 Jan 2017 10:51:39 -0800
Message-ID: <CAJ4mKGY-vCXobE51rU_-VAbgvKhCKpX1bSNzXeuJD3TKwE5KNw@mail.gmail.com>
References: <CAC+4SSg2EM_7sWvOrkUNCzZ9_tf5ew2MKqw30Db1c-LFEbNrLg@mail.gmail.com>
 <CAJ4mKGYrJL1JXwRDRQHg_iJPqsQN_ppRzLAVs0rt9PyLSRnnHw@mail.gmail.com> <CAC+4SSicN8GK+09Wf=fDyOeGSfeTjO35=ZnUP987YC3W=aW7Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38416 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdAXSvl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2017 13:51:41 -0500
Received: by mail-it0-f44.google.com with SMTP id c7so96350116itd.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jan 2017 10:51:40 -0800 (PST)
In-Reply-To: <CAC+4SSicN8GK+09Wf=fDyOeGSfeTjO35=ZnUP987YC3W=aW7Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Padmanabh Ratnakar <padmanabh.ratnakar@snapdeal.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 18, 2017 at 3:10 PM, Padmanabh Ratnakar
<padmanabh.ratnakar@snapdeal.com> wrote:
>>>
>>> Is this a known issue? I searched for it and could not find anyone hitting this.
>>
>> I don't think so.
>>
>>>
>>> Looking at the 0.94.7 code, looks like pipe_lock is released in line
>>> 886 in the beginning of connect() routine.
>>> It is again taken later. But there is update to state member variable
>>> without checking current state in code below.
>>
>> Where exactly?
>
> Sorry for late response.
>
> In function int Pipe::connect(), pipe_lock is released first.
>
> int Pipe::connect()
> {
>   bool got_bad_auth = false;
>
>   ldout(msgr->cct,10) << "connect " << connect_seq << dendl;
>   assert(pipe_lock.is_locked());
>
>   __u32 cseq = connect_seq;
>   __u32 gseq = msgr->get_global_seq();
>
>   // stop reader thread
>   join_reader();
>
>   pipe_lock.Unlock();
>
> .....
>
> some  tcp_read and do_sendmsg after this for protocol processing
> In between unlock and lock, pipe may be getting replaced due to network errors.
> and moved to STATE_CLOSED in accept routine while this pipe is waiting for lock
> below.
> ......
>
> pipe_lock.Lock();
>
> ....
> After this there is code like below which override Pipe state.
> There is a danger of overwriting STATE_CLOSED state?
>
>     if (reply.tag == CEPH_MSGR_TAG_WAIT) {
>       ldout(msgr->cct,3) << "connect got WAIT (connection race)" << dendl;
>       state = STATE_WAIT;
>       goto stop_locked;
>     }

You're skipping over the part where, immediately after taking the
pipe_lock back, we check for this case (and similar ones):

>    pipe_lock.Lock();
>    if (state != STATE_CONNECTING) {
>      ldout(msgr->cct,0) << "connect got RESETSESSION but no longer connecting" << dendl;
>      goto stop_locked;
>    }

https://github.com/ceph/ceph/blob/v0.94.1.7/src/msg/simple/Pipe.cc#L1078

:)

Obviously there's an issue somewhere or you wouldn't have hit an
assert, but I'm not sure where and I'm pretty sure if you ever see it
again, it's something fixed in later source revisions (...which we may
not have backported once hammer reached EoL).
-Greg


>
> Please see if there is any issue in above code.
>
>>
>>> If pipe is moved to STATE_CLOSED in the interval when lock was released,
>>> there is a chance that it can get overwritten when
>>> CEPH_MSGR_TAG_WAIT(STATE_WAIT) comes as reply or
>>> directly to STATE_OPEN in line 1172.
>>
>> I'm not following your referents here. The out_seq can get
>> overwritten? Something else?
>
> We got a different acked out_seq from other side than the messages
> present in this pipe's queue.
> This leads me to think there is some race not handled correctly.
>
>>
>>> I feel this may cause assert seen above but only if many other things
>>> also happen.
>>
>> We had some vaguely similar issues in the time after CEPH_MSGR_TAG_SEQ
>> was introduced, but I think it's been a while. You might have spotted
>> another rare one.
>> -Greg
>
> -Padmanabh
