From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Sat, 20 Apr 2013 00:33:27 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
 <516FF893.1030309@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
 <517159C3.5030100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:51450 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133Ab3DTAdf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 20:33:35 -0400
In-Reply-To: <517159C3.5030100@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> On 04/19/2013 06:09 AM, James Harper wrote:
> > I just tried a 3.8 series kernel and can now get 25mbytes/second using dd
> with a 4mb block size, instead of the 700kbytes/second I was getting with the
> debian 3.2 kernel.
> 
> That's.... unexpected.  Was this the kernel on the client, the OSDs, or
> both?

Kernel on the client. I can't easily change the kernel on the OSD's although if you think it will make a big difference I can arrange it.

> >
> > I'm still getting 120kbytes/second with a dd 4kb block size though... is that
> expected?
> 
> that's still quite a bit lower than I'd expect as well.  What were your
> fs mount options on the OSDs?

I didn't explicitly set any, so I guess these are the defaults:

xfs (rw,noatime,attr2,delaylog,inode64,noquota)

> Can you try some rados bench read/write
> tests on your pool?  Something like:
> 
> rados -p <pool> -b 4096 bench 300 write --no-cleanup -t 64

Ah. It's the --no-cleanup that explains why my pervious seq tests didn't work!

Total time run:         300.430516
Total writes made:      26726
Write size:             4096
Bandwidth (MB/sec):     0.347

Stddev Bandwidth:       0.322983
Max bandwidth (MB/sec): 1.34375
Min bandwidth (MB/sec): 0
Average Latency:        0.719337
Stddev Latency:         0.985265
Max latency:            7.2241
Min latency:            0.018218

But then it just hung and I had to hit ctrl-c

What is the unit of measure for latency and for write size?

> rados -p <pool> -b 4096 bench 300 seq -t 64

sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
read got -2
error during benchmark: -5
error 5: (5) Input/output error

not sure what that's about...

> 
> with 2 drives and 2x replication I wouldn't expect much without RBD
> cache, but 120kb/s is rather excessively bad. :)
> 

What is rbd cache? I've seen it mentioned but haven't found documentation for it anywhere...

My goal is 4 OSD's, each on separate machines, with 1 drive in each for a start, but I want to see performance of at least the same order of magnitude as the theoretical maximum on my hardware before I think about replacing my existing setup.

Thanks

James

