From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Thu, 27 Sep 2012 12:47:57 -0700
Message-ID: <CAPYLRzhpGd4gjRrE2spzTnc5bSVaMB481Jn7bcR0V0aKcr-dBw@mail.gmail.com>
References: <50631E97.5050100@inktank.com>
	<201209262054.q8QKsfwx007341@ayesha.phys.virginia.edu>
	<CAPYLRziRQxAd_TZZER3XeRpBj+W1xgnYgxphaR+wkMX0C3GbXQ@mail.gmail.com>
	<201209271847.q8RIlUO6031265@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64213 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab2I0Tr5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 15:47:57 -0400
Received: by ieak13 with SMTP id k13so5472899iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 12:47:57 -0700 (PDT)
In-Reply-To: <201209271847.q8RIlUO6031265@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 27, 2012 at 11:47 AM, Bryan K. Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
>
> greg@inktank.com said:
>> >
>>         The rados benchmark was run on one of the OSD
>> machines.  Read and write results looked like this (the
>> objects size was just the default, which seems to be 4kB):
>> Actually, that's 4MB. ;)
>
>         Oops! My plea is that I was the victim of a
> man page bug:
>
>        bench seconds mode [ -b objsize ] [ -t threads ]
>               Benchmark  for  seconds.  The  mode  can  be  write or =
read. The
>               default object size is 4 KB, and the default number of =
simulated
>               threads (parallel writes) is 16.

Whoops! I'd fix it but it's obfuscated somewhat now, so:
http://tracker.newdream.net/issues/3230


>
>
>> Can you run # rados bench -p pbench 900 write -t 256
>> -b 4096 and see what that gets? It'll run 256 simultaneous 4KB write=
s. (You
>> can also vary the number of simultaneous writes and see if that impa=
cts it.)
>
>         Here's the new benchmark output:
>
>  Total time run:         900.880070
> Total writes made:      537187
> Write size:             4096
> Bandwidth (MB/sec):     2.329
>
> Stddev Bandwidth:       2.57691
> Max bandwidth (MB/sec): 12.6055
> Min bandwidth (MB/sec): 0
> Average Latency:        0.429315
> Stddev Latency:         0.891734
> Max latency:            19.7647
> Min latency:            0.016743

Hmm, that is significantly lower than I would have expected. Can you
check and see if you can get that number higher by increasing (or
decreasing) the number of in-flight ops? (-t param)

Given your size distribution, it could just be that your RAID arrays
aren't giving you the small random write throughput you expect.


>> However, my suspicion is that you're limited by metadata throughput =
here. How
>> large are your files? There might be some MDS or client tunables we =
can
>> adjust, but rsync's workload is a known weak spot for CephFS. -Greg
>
>         The file size is generally small.  Here's the distribution:
>
> http://ayesha.phys.virginia.edu/~bryan/filesize.png
>
> The mean is about 2.5 MB.

So that chart is measuring in KB? Anyway, it might be metadata =97 you
could see what the CPU usage on the MDS server looks like while
running the rsync.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
