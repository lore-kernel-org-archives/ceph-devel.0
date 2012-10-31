From: Sam Lang <sam.lang@inktank.com>
Subject: Re: active MDS and disk write cache
Date: Wed, 31 Oct 2012 15:01:30 -0500
Message-ID: <5091839A.9060305@inktank.com>
References: <50915991.3030906@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53846 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab2JaUBe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 16:01:34 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1202633pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 13:01:33 -0700 (PDT)
In-Reply-To: <50915991.3030906@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/31/2012 12:02 PM, Matt Weil wrote:
> I have a system with a bunch or ram that I want to remain the active MDS
> but still have a backup.
>
> This config doesn't seem to be working.  I can make linuscs92 the active
> by stopping and starting the mds on linuscs95. It would be nice for
> linuscs92 to be the active from the start.
>
> [mds.linuscs95]
>      host = linuscs95
>      mds standby replay = true
>      mds standby for name = linuscs92

Hi Matt,

Can you post your ceph config?  Once you startup your ceph cluster, you 
see that linuscs92 is the standby and linuscs95 is the active?  How are 
you starting your cluster?

>
> Also about disk write cache.
>
> If the Data center, servers and storage units are backed by redundant
> power sources, Batteries and a generator.  Is the concern for data loss
> less?

Yes, if you have that setup you can enable the disk cache and be 
reasonably assured that a power failure of a single component won't 
cause a loss of data.

>
> Any one turn disk write cache on and see a great improvement?

This is dependent on your hardware.  If you have raid controllers with 
battery backed cache, enabling/disabling the disk caches probably won't 
make much of a difference to performance.  Rather than speculate though, 
I would encourage you to benchmark it using Jens Axboe's fio benchmark:

cat > write.fio -<<EOF
[randwrite]
rw=randw
size=128m
direct=1
[write]
rw=write
size=1024m
direct=1
EOF

# enable cache
hdparm -W 1 /dev/sdX

# test with cache
fio write.fio

# disable cache
hdparm -W 0 /dev/sdX

# test without cache
fio write.fio

compare the output of the two fio benchmarks.  Don't forget to return 
the disk cache to its previously enabled/disabled state!

-sam

>
> Thanks
>
> Matt
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

