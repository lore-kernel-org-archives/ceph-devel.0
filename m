From: kefu chai <tchaikov@gmail.com>
Subject: Re: Asking bug ceph 15113
Date: Sat, 8 Oct 2016 11:52:14 +0800
Message-ID: <CAJE9aOOXN8ED_6=sJ80VqU-=YxrQtPTr=NBBHQwdsBHXVx+2Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33177 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754701AbcJHDwQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Oct 2016 23:52:16 -0400
Received: by mail-qk0-f175.google.com with SMTP id n189so58963613qke.0
        for <ceph-devel@vger.kernel.org>; Fri, 07 Oct 2016 20:52:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: agung Laksono <agung.smarts@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

+ ceph-devel

On Thu, Sep 29, 2016 at 2:35 PM, agung Laksono <agung.smarts@gmail.com> wrote:
>
> I would like to ask you relate to ceph-15113. On the bug description,
> the scenario to reproduce the bug is:

this is not how the bug is reproduces, it's just my analysis of the
root cause. IMO,
it would be a tricky to reproduce this racing if possible.

>
> so the session was not removed, that's why the request was handled after the
> connection is reset. this is a race condition:
>
> ______________________ SafeTimer::timer_thread(), with mon_lock:
> ______________________ elector: in win_election(), it
> resend_routed_requests(), and collects the routed requests
> msgr: in ms_handle_reset(), it reset the session
> msgr: it waits for the lock
> ______________________ elector: in win_election(), it handle_command(), but
> the session is reset, hence it panics.
> msgr: remove session, and erase related requests from
> Monitor::routed_requests.
>
>
> I try to reproduce this bug on a cluster in my local machine and
> find difficulty when reproducing ms_handle_reset.
>
> Does ms_handle_reset refer to Monitor::ms_handle_reset(Connection *con)?

yes.

> How to trigger this function? On my study, I've put mon log when this method

when the peer resets the connection.

> executed.
> however, I saw that ms_handle_reset was called randomly. I mean this
> function also be called
> in several times when the system run.
>
>  Thank you in advance!
>
> --
> Cheers,
>
> Agung Laksono
>



-- 
Regards
Kefu Chai
