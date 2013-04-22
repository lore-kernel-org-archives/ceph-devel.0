From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: poor write performance
Date: Mon, 22 Apr 2013 11:34:10 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>
	<516FF893.1030309@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au>
	<517159C3.5030100@inktank.com>
	<6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au>
	<CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au>
 <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:60437 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3DVLe3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 07:34:29 -0400
In-Reply-To: <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Hi,
> 
> > Correct, but that's the theoretical maximum I was referring to. If I calculate
> that I should be able to get 50MB/second then 30MB/second is acceptable
> but 500KB/second is not :)
> 
> I have written a small benchmark for RBD :
> 
> https://gist.github.com/smunaut/5433222
> 
> It uses the librbd API directly without kernel client and queue
> requests long in advance and this should give an "upper" bound to what
> you can get at best.
> It reads and writes the whole image, so I usually just create a 1 or 2
> G image for testing.
> 
> Using two OSDs on two distinct recent 7200rpm drives (with journal on
> the same disk as data), I get :
> 
> Read: 89.52 Mb/s (2147483648 bytes in 22877 ms)
> Write: 10.62 Mb/s (2147483648 bytes in 192874 ms)
> 

I like your benchmark tool!

How many replicas? With two OSD's with xfs on ~3yo 1TB disks with two replicas I get:

# ./a.out admin xen test
Read: 111.99 Mb/s (1073741824 bytes in 9144 ms)
Write: 29.68 Mb/s (1073741824 bytes in 34507 ms)

Which means I forgot to drop caches on the OSD's so I'm seeing the limit on my public network (single gigabit interface). After dropping caches I consistently get:

# ./a.out admin xen test
Read: 39.98 Mb/s (1073741824 bytes in 25614 ms)
Write: 23.11 Mb/s (1073741824 bytes in 44316 ms)

Journal is on the same disk. Network is... confusing :) but is basically public on a single gigabit and cluster on a bonded pair of gigabit links. The whole network thing is shared with my existing drbd cluster so performance may vary over time.

My read speed is consistently around 40MB/second, and my write speed is consistently around 22MB/second. I had expected better of read...

While running, iostat on each osd reports a read rate of around 20MB/second (1/2 total on each) during read test and a rate of 40-60MB/second (~2x total on each) during write test, which is pretty much exactly right.

iperf on the cluster network (pair of gigabits bonded) gives me about 1.97Gbits/second. iperf between osd and client is around 0.94Gbits/second.

changing the scheduler on the harddisk doesn't seem to make any difference, even when I set it to cfq which normally really sucks.

What ceph version are you using and what filesystem?

Thanks

James

