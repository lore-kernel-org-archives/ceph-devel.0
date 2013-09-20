From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Object Write Latency
Date: Fri, 20 Sep 2013 08:11:29 -0500
Message-ID: <523C4981.9080406@inktank.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:53594 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab3ITNLe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 09:11:34 -0400
Received: by mail-vc0-f179.google.com with SMTP id ht10so248023vcb.24
        for <ceph-devel@vger.kernel.org>; Fri, 20 Sep 2013 06:11:34 -0700 (PDT)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/20/2013 07:27 AM, Andreas Joachim Peters wrote:
> Hi,

Hi Andreas!

>
> we made some benchmarks about object read/write latencies on the CERN ceph installation.
>
> The cluster has 44 nodes and ~1k disks, all on 10GE and the pool configuration has 3 copies.
> Client & Server is 0.67.
>
> The latencies we observe (using tiny objects ... 5 bytes) on the idle pool:
>
> write full object(sync) ~65-80ms
> append to object ~60-75ms
> set xattr object ~65-80ms
> lock object ~65-80ms
> stat object ~1ms
>
> We seem to saturate the pools writing ~ 20k objects/s (= internally 60k/s).

Out of curiosity, how much difference do you see with write latencies if 
you do the same thing to a pool with 1 copy?

>
> Is there an easy explanation for 80 ms (quasi without payload) and a possible tuning to reduce that?
> I measured (append few bytes +fsync) on such a disk around 33ms which explains probably part of the latency.

I've been wanting to really dig into object write latency in RADOS but 
just haven't had the time to devote to it yet.  I've been doing some 
simple rados bench tests to a 8-SSD test node and am topping out at 
about 8-9K write IOPS and 26K read IOPS (no replication) though with 
little tuning.  I suspect there are many areas in the code where we 
could improve things.

>
> Then I tried with the async API to see if there is a difference in the measurement between wait_for_complete or wait_for_safe ... shouldn't wait_for_complete be much shorter, but I get always comparable results ...

Hrm, I'm going to let Sage or someone else comment on this.
>
> Thanks, Andreas.--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

