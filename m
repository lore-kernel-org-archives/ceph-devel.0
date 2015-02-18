From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore performance
 comparison
Date: Wed, 18 Feb 2015 09:44:57 -0600
Message-ID: <54E4B379.3000205@redhat.com>
References: <54E37C3D.5030702@redhat.com> <413428.1082.1424272098009.JavaMail.andrei@tuchka>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52118 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbbBRPpX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Feb 2015 10:45:23 -0500
In-Reply-To: <413428.1082.1424272098009.JavaMail.andrei@tuchka>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrei Mikhailovsky <andrei@arhont.com>
Cc: ceph-users@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi Andrei,

On 02/18/2015 09:08 AM, Andrei Mikhailovsky wrote:
>
> Mark, many thanks for your effort and ceph performance tests. This puts
> things in perspective.
>
> Looking at the results, I was a bit concerned that the IOPs performance
> in niether releases come even marginally close to the capabilities of
> the underlying ssd device. Even the fastest PCI ssds have only managed
> to achieve about the 1/6th IOPs of the raw device.

Perspective is definitely good!  Any time you are dealing with latency 
sensitive workloads, there are a lot of bottlenecks that can limit your 
performance.  There's a world of difference between streaming data to a 
raw SSD as fast as possible and writing data out to a distributed 
storage system that is calculating data placement, invoking the TCP 
stack, doing CRC checks, journaling writes, invoking the VM layer to 
cache data in case it's hot (which in this case it's not).

>
> I guess there is a great deal more optimisations to be done in the
> upcoming LTS releases to make the IOPs rate close to the raw device
> performance.

There is definitely still room for improvement!  It's important to 
remember though that there is always going to be a trade off between 
flexibility, data integrity, and performance.  If low latency is your 
number one need before anything else, you are probably best off 
eliminating as much software as possible between you and the device 
(except possibly if you can make clever use of caching).  While Ceph 
itself is some times the bottleneck, in many cases we've found that 
bottlenecks in the software that surrounds Ceph are just as big 
obstacles (filesystem, VM layer, TCP stack, leveldb, etc).  If you need 
a distributed storage system that can universally maintain native SSD 
levels of performance, the entire stack has to be highly tuned.

>
> I have done some testing in the past and noticed that despite the server
> having a lot of unused resources (about 40-50% server idle and about
> 60-70% ssd idle) the ceph would not perform well when used with ssds. I
> was testing with Firefly + auth and my IOPs rate was around the 3K mark.
> Something is holding ceph back from performing well with ssds (((

Out of curiosity, did you try the same tests directly on the SSD?

>
> Andrei
>
> ------------------------------------------------------------------------
>
>     *From: *"Mark Nelson" <mnelson@redhat.com>
>     *To: *"ceph-devel" <ceph-devel@vger.kernel.org>
>     *Cc: *ceph-users@lists.ceph.com
>     *Sent: *Tuesday, 17 February, 2015 5:37:01 PM
>     *Subject: *[ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore
>     performance        comparison
>
>     Hi All,
>
>     I wrote up a short document describing some tests I ran recently to
>     look
>     at how SSD backed OSD performance has changed across our LTS releases.
>     This is just looking at RADOS performance and not RBD or RGW.  It also
>     doesn't offer any real explanations regarding the results.  It's just a
>     first high level step toward understanding some of the behaviors folks
>     on the mailing list have reported over the last couple of releases.  I
>     hope you find it useful.
>
>     Mark
>
>     _______________________________________________
>     ceph-users mailing list
>     ceph-users@lists.ceph.com
>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
