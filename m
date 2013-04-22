From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor write performance
Date: Mon, 22 Apr 2013 06:39:02 -0500
Message-ID: <51752156.9050004@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au> <517159C3.5030100@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au> <CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au> <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:52049 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab3DVLjK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 07:39:10 -0400
Received: by mail-ia0-f180.google.com with SMTP id t29so2109944iag.11
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 04:39:10 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/22/2013 06:34 AM, James Harper wrote:
>> Hi,
>>
>>> Correct, but that's the theoretical maximum I was referring to. If I calculate
>> that I should be able to get 50MB/second then 30MB/second is acceptable
>> but 500KB/second is not :)
>>
>> I have written a small benchmark for RBD :
>>
>> https://gist.github.com/smunaut/5433222
>>
>> It uses the librbd API directly without kernel client and queue
>> requests long in advance and this should give an "upper" bound to what
>> you can get at best.
>> It reads and writes the whole image, so I usually just create a 1 or 2
>> G image for testing.
>>
>> Using two OSDs on two distinct recent 7200rpm drives (with journal on
>> the same disk as data), I get :
>>
>> Read: 89.52 Mb/s (2147483648 bytes in 22877 ms)
>> Write: 10.62 Mb/s (2147483648 bytes in 192874 ms)
>>
>
> I like your benchmark tool!
>
> How many replicas? With two OSD's with xfs on ~3yo 1TB disks with two replicas I get:
>
> # ./a.out admin xen test
> Read: 111.99 Mb/s (1073741824 bytes in 9144 ms)
> Write: 29.68 Mb/s (1073741824 bytes in 34507 ms)
>
> Which means I forgot to drop caches on the OSD's so I'm seeing the limit on my public network (single gigabit interface). After dropping caches I consistently get:
>
> # ./a.out admin xen test
> Read: 39.98 Mb/s (1073741824 bytes in 25614 ms)
> Write: 23.11 Mb/s (1073741824 bytes in 44316 ms)
>
> Journal is on the same disk. Network is... confusing :) but is basically public on a single gigabit and cluster on a bonded pair of gigabit links. The whole network thing is shared with my existing drbd cluster so performance may vary over time.
>
> My read speed is consistently around 40MB/second, and my write speed is consistently around 22MB/second. I had expected better of read...

You may want to try increasing your read_ahead_kb on the OSD data disks 
and see if that helps read speeds.

>
> While running, iostat on each osd reports a read rate of around 20MB/second (1/2 total on each) during read test and a rate of 40-60MB/second (~2x total on each) during write test, which is pretty much exactly right.
>
> iperf on the cluster network (pair of gigabits bonded) gives me about 1.97Gbits/second. iperf between osd and client is around 0.94Gbits/second.
>
> changing the scheduler on the harddisk doesn't seem to make any difference, even when I set it to cfq which normally really sucks.
>
> What ceph version are you using and what filesystem?
>
> Thanks
>
> James
>

