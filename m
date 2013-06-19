From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: mon crash
Date: Wed, 19 Jun 2013 16:30:21 +0100
Message-ID: <51C1CE8D.408@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B5C2183F2@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:62937 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934022Ab3FSPaI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 11:30:08 -0400
Received: by mail-bk0-f53.google.com with SMTP id e11so2404759bkh.12
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 08:30:07 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B5C2183F2@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/19/2013 10:53 AM, James Harper wrote:
> Every time I start up one of my mons it crashes. Two others are running but there seems to be long delays (=several seconds) when doing mon status (maybe this is the behaviour when one mon is down?)
>
> The tail of /var/log/ceph/ceph-mon.4.log follows this email.
>
> Version is 0.61.3-1~bpo70+1 from http://ceph.com/debian-cuttlefish wheezy main
>
> This was happening in a previous version, and then even before that but I thought I'd fixed it by wiping the errant mon and recreating it.
>
> Anything else I can supply that might help?
>
> Thanks
>
> James
>
>       0> 2013-06-19 19:45:44.018695 7f472d995700 -1 mon/Monitor.cc: In function 'void Monitor::sync_timeout(entity_inst_t&)' thread 7f472d995700 time 2013-06-19 19:45:44.017928
> mon/Monitor.cc: 1101: FAILED assert(sync_state == SYNC_STATE_CHUNKS)
>
>   ceph version 0.61.3 (92b1e398576d55df8e5888dd1a9545ed3fd99532)
>   1: /usr/bin/ceph-mon() [0x4c8eca]
>   2: (Context::complete(int)+0xa) [0x4d70fa]
>   3: (SafeTimer::timer_thread()+0x1af) [0x64ad4f]
>   4: (SafeTimerThread::entry()+0xd) [0x64c3dd]
>   5: (()+0x6b50) [0x7f47c0c3ab50]
>   6: (clone()+0x6d) [0x7f47bf39ba7d]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.


Issues on sync_timeout() have been seen, I track them down for some 
time, find nothing of worth and logs usually don't help that much, and I 
eventually have to move on.

http://tracker.ceph.com/issues/4845

and

http://tracker.ceph.com/issues/5171

contain two iterations of what appears to be the same bug.  My guess is 
that there's a lingering Context not being cancelled somewhere.  Or it 
might be some other thing altogether.

James, do you happen to have a full log you can share with us?


   -Joao

-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
