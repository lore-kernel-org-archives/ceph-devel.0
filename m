From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor write performance
Date: Sun, 21 Apr 2013 08:52:05 -0500
Message-ID: <5173EF05.9000404@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au> <517159C3.5030100@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D73B75D@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48071 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3DUNwK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 09:52:10 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6165525iea.18
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 06:52:09 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4D73B75D@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/19/2013 08:30 PM, James Harper wrote:
>>> rados -p <pool> -b 4096 bench 300 seq -t 64
>>
>> sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>>       0       0         0         0         0         0         -         0
>> read got -2
>> error during benchmark: -5
>> error 5: (5) Input/output error
>>
>> not sure what that's about...
>>
>
> Oops... I typo'd --no-cleanup. Now I get:
>
>     sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>       0       0         0         0         0         0         -         0
>   Total time run:        0.243709
> Total reads made:     1292
> Read size:            4096
> Bandwidth (MB/sec):    20.709
>
> Average Latency:       0.0118838
> Max latency:           0.031942
> Min latency:           0.001445
>
> So it finishes instantly without seeming to do much actual testing...

My bad.  I forgot to tell you to do a sync/flush on the OSDs after the 
write test.  All of those reads are probably coming from pagecache.  The 
good news is that this is demonstrating that reading 4k objects from 
pagecache isn't insanely bad on your setup (for larger sustained loads I 
see 4k object reads from pagecache hit up to around 100MB/s with 
multiple clients on my test nodes).

On your OSD nodes try:

sync
echo 3 > /proc/sys/vm/drop_caches

right before you run the read test.

Whatever issue you are facing is probably down at the filestore level or 
possible lower down yet.

How do your drives benchmark with something like fio doing random 4k 
writes?  Are your drives dedicated for ceph?  What filesystem?  Also 
what is the journal device you are using?

Mark

>
> James
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

