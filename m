From: Padmanabh Ratnakar <padmanabh.ratnakar@snapdeal.com>
Subject: Re: Assert in Pipe.cc in Hammer 0.94.7
Date: Tue, 24 Jan 2017 19:40:27 +0530
Message-ID: <CAC+4SSi7+os2cBeCTAidcqWFKygx4u+Qt4xMhBFcQj2H8OWs3w@mail.gmail.com>
References: <CAC+4SSg2EM_7sWvOrkUNCzZ9_tf5ew2MKqw30Db1c-LFEbNrLg@mail.gmail.com>
 <CAJ4mKGYrJL1JXwRDRQHg_iJPqsQN_ppRzLAVs0rt9PyLSRnnHw@mail.gmail.com> <CAC+4SSicN8GK+09Wf=fDyOeGSfeTjO35=ZnUP987YC3W=aW7Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33116 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAXOK2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2017 09:10:28 -0500
Received: by mail-yw0-f171.google.com with SMTP id u68so122125016ywg.0
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jan 2017 06:10:28 -0800 (PST)
In-Reply-To: <CAC+4SSicN8GK+09Wf=fDyOeGSfeTjO35=ZnUP987YC3W=aW7Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

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
>
> Please see if there is any issue in above code.

Hi Greg, kindly see if there is a bug here.
We are not able to reproduce the issue in our tests.

Thanks,
Padmanabh
