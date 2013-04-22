From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor write performance
Date: Mon, 22 Apr 2013 06:34:09 -0500
Message-ID: <51752031.2060704@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au> <517159C3.5030100@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D73B75D@BITCOM1.int.sbss.com.au> <5173EF05.9000404@inktank.com> <6035A0D088A63A46850C3988ED045A4B4F362FEA@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65252 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3DVLeM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 07:34:12 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so7017138iec.28
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 04:34:12 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4F362FEA@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/22/2013 12:32 AM, James Harper wrote:
>>
>> On 04/19/2013 08:30 PM, James Harper wrote:
>>>>> rados -p <pool> -b 4096 bench 300 seq -t 64
>>>>
>>>> sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>>>>        0       0         0         0         0         0         -         0
>>>> read got -2
>>>> error during benchmark: -5
>>>> error 5: (5) Input/output error
>>>>
>>>> not sure what that's about...
>>>>
>>>
>>> Oops... I typo'd --no-cleanup. Now I get:
>>>
>>>      sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>>>        0       0         0         0         0         0         -         0
>>>    Total time run:        0.243709
>>> Total reads made:     1292
>>> Read size:            4096
>>> Bandwidth (MB/sec):    20.709
>>>
>>> Average Latency:       0.0118838
>>> Max latency:           0.031942
>>> Min latency:           0.001445
>>>
>>> So it finishes instantly without seeming to do much actual testing...
>>
>> My bad.  I forgot to tell you to do a sync/flush on the OSDs after the
>> write test.  All of those reads are probably coming from pagecache.  The
>> good news is that this is demonstrating that reading 4k objects from
>> pagecache isn't insanely bad on your setup (for larger sustained loads I
>> see 4k object reads from pagecache hit up to around 100MB/s with
>> multiple clients on my test nodes).
>>
>> On your OSD nodes try:
>>
>> sync
>> echo 3 > /proc/sys/vm/drop_caches
>>
>> right before you run the read test.
>>
>
> I tell it to test for 300 seconds and it tests for 0 seconds so I must be doing something else wrong.
>

It will try to read for up to 300 seconds, but if it runs out of data it 
stops.  Since you only wrote out something like 1300 4k objects, and you 
were reading at 20+MB/s, the test ran for under a second.

>> Whatever issue you are facing is probably down at the filestore level or
>> possible lower down yet.
>>
>> How do your drives benchmark with something like fio doing random 4k
>> writes?  Are your drives dedicated for ceph?  What filesystem?  Also
>> what is the journal device you are using?
>>
>
> Drives are dedicated for ceph. I originally put my journals on /, but that was ext3 and my throughput went down even further so the journal shares the osd disk for now.
>
> I upgraded to 0.60 and that seems to have made a big difference. If I kill off one of my OSD's I get around 20MB/second throughput in live testing (test restore of Xen Windows VM from USB backup), which is pretty much the limit of the USB disk. If I reactivate the second OSD throughput drops back to ~10MB/second which isn't as good but is much better than I was getting.
>

Ah, are these disks both connected through USB(2?)?

> Thanks
>
> James
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

