From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor write performance
Date: Mon, 22 Apr 2013 08:47:53 -0500
Message-ID: <51753F89.8000508@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au> <516FF893.1030309@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73695A@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386A4@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D7386F7@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B4D739E99@BITCOM1.int.sbss.com.au> <517159C3.5030100@inktank.com> <6035A0D088A63A46850C3988ED045A4B4D73B052@BITCOM1.int.sbss.com.au> <CAF6-1L4Yxqmq0yED+gA_Xgupzg6AvWi6mBD59-aXYgUj3foaTw@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B4F36261A@BITCOM1.int.sbss.com.au> <CAF6-1L5aindF_41=d6JKvut5cBzXx_1btGw-EteGmijoma616A@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B4F3636DC@BITCOM1.int.sbss.com.au> <51752156.9050004@inktank.com> <6035A0D088A63A46850C
 3988ED045A4B4F3637AD@BITCOM1.int.sbss.com.au> <51752695.9080205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51774 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3DVNrz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 09:47:55 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so3445104iec.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 06:47:55 -0700 (PDT)
In-Reply-To: <51752695.9080205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/22/2013 07:01 AM, Mark Nelson wrote:
> On 04/22/2013 06:48 AM, James Harper wrote:
>>>> My read speed is consistently around 40MB/second, and my write speed is
>>>> consistently around 22MB/second. I had expected better of read...
>>>
>>> You may want to try increasing your read_ahead_kb on the OSD data disks
>>> and see if that helps read speeds.
>>>
>>
>> Default appears to be 128 and I was getting 40MB/second
>> Increasing to 256 takes me up to 48MB/second
>> Increasing to 512 takes me up to 53Mb/second
>>
>> Any further increases don't do anything that I can measure
>>
>> Is increasing read_ahead_kb good for general performance, or just for
>> impressing people with benchmarks? If the kernel spent time reading
>> ahead woult it hurt random read/write performance?
>
> Potentially yes, but it depends on a lot of of factors.  I suspect that
> increasing it may be acceptable on modern drives, but you'll need to do
> some testing to see how it goes in practice.
>
> If anyone on the list knows how many sectors per track is typical for
> modern 1-3TB drives I'm dying to know. That would help us guess at how
> much data can be writen/read on average without imposing any head
> movement. :)
>

Aha, sorry to reply to my own mail.  I found some specifications for 
Hitachi drives at least:

http://www.hgst.com/tech/techlib.nsf/products/Ultrastar_7K4000

look at section 4.2 of the "Ultrastar 7K4000 OEM Specification" document.

It specifies 310ktpi, or 310,000 tracks/inch.

Via google I found that this drive is using 5 800GB platters, meaning 
there are 10 heads in this drive.  Using hitachi's specifications:

(7,814,037,168 sectors / (310,000 tracks / inch * 3.5 inches)) / 10 
heads * 512 bytes / sector = ~360KB/track head

So assuming my math is right, it looks like we can read up to around 
360KB of data before hitting a head switch.  Now unfortunately (or maybe 
fortunately!) this is just the average case.  Outer tracks will store 
more data than inner tracks, so depending on what portion of the disk 
you are doing the read from, you might introduce head switches more or 
less often.  It looks like even with a 256k or 512k read_ahead you 
probably won't introduce a next-cylinder seek that often, though from 
what I can find it's not going to be all that much more expensive vs a 
head switch (2-3ms vs 1-2ms).

Mark

>>
>> Thanks
>>
>> James
>>
>

