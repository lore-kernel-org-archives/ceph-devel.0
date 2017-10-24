From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: fun with seastar
Date: Mon, 23 Oct 2017 22:25:13 -0500
Message-ID: <268ffa36-bfc5-4fee-1c44-13e3050f6c9c@gmail.com>
References: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:46903 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdJXDZP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 23:25:15 -0400
Received: by mail-oi0-f42.google.com with SMTP id n82so34553572oig.3
        for <ceph-devel@vger.kernel.org>; Mon, 23 Oct 2017 20:25:15 -0700 (PDT)
In-Reply-To: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Casey!

On 10/23/2017 03:17 PM, Casey Bodley wrote:
> Hi folks,
>
> I mentioned in last week's perf call that I've been experimenting with
> the Seastar library [1] to see how well it can integrate with the ceph
> codebase. So far I've managed to add bufferlist conversions to/from the
> seastar buffer types, and build up a seastar messenger that can
> send/receive ceph Messages. The branch [2] includes a simple echo server
> unit test and a README with build instructions.
>
> This follows some prototype work a couple years ago by Adam Emerson and
> myself, dubbed Project Crimson [3], to evaluate Seastar as the basis for
> a low-latency OSD. Interesting parts of this project include a Cap'n
> Proto-based messenger and an async ObjectStore interface with Memstore
> implementation.

So after I saw your initial work on project crimson a month or two ago I 
went out and started working through the seastar tutorial.  I never 
really got past screwing around with it since I've been tied up in other 
stuff, but it seems like you must like seastar enough to be willing to 
sink some time into it.  Where are you planning on taking this next?

Mark

>
> -Casey
>
> [1] https://github.com/scylladb/seastar
> [2] https://github.com/cbodley/ceph/commits/wip-seastar-msg
> [3] https://github.com/cohortfsllc/crimson
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
