From: Milosz Tanski <milosz@adfin.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 12 Dec 2014 10:43:05 -0500
Message-ID: <CANP1eJE8nhkzSH3F1M0RRS2f3D6zWGUVHKckTEj-bHVhKhq14A@mail.gmail.com>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
	<20141212091408.GN4150@thinkpad.thebehrens.net>
	<alpine.DEB.2.00.1412120644340.23559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50147 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbaLLPnH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 10:43:07 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so1812124lbi.30
        for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 07:43:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412120644340.23559@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Thorsten Behrens <tbehrens@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Dec 12, 2014 at 9:46 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 12 Dec 2014, Thorsten Behrens wrote:
>> Sage Weil wrote:
>> > Calculating the ln() function is a bit annoying because it is a floating
>> > point function and CRUSH is all fixed-point arithmetic (integer-based).
>> > The current draft implementation uses a 128 KB lookup table (2 bytes per
>> > entry for 16 bits of input precision).  It seems to be about 25% slower
>> > than the original straw code in my simple microbenchmark, but I'm not sure
>> > that's a number we should trust since it loops through a zillion inputs
>> > and will pull most of the lookup table into the processor caches.
>> >
>> > We could probably try a few others things:
>> >
>> [snip]
>>
>> My Hacker's Delight copy has a number of further variants (on
>> pp. 215), unfortunately only covering log_2 (which is trivially the
>> number of leading zeros in the binary representation) and log_10. But
>> since the logarithms are simply related by a multiplicative constant,
>> something clever might be doable here with a bit of thinking.
>
> Any log will definitely do; the next steps are to do a division and then
> take the max.  Simply counting 0's isn't precise enough, though.. we need
> a lot more precision than that.
>
> The table lookup is (I think) on the order of 50-100 cycles with a cold
> cache; that's what we need to beat!

I believe there are a few different options with respect to natural
log in 16bit fix point. First place to look I believe would be DSP/FFT
code for 16bit microprocessors (think atmel); folks have been able to
do real time fft on those chips for a long time. You might have to
translate some assembly code for 16 bit micro to C code but that's
easy enough.

A quick google search reveals a there's a portable C library for 16bit
fixpoint calculations called libfixmath at
https://code.google.com/p/libfixmath/ that has a natural log
implementation. The code is here:
https://code.google.com/p/libfixmath/source/browse/trunk/libfixmath/fix16_exp.c#61.
The documentation is here:
https://code.google.com/p/libfixmath/wiki/FunctionReference

There's more:
https://github.com/BurntBrunch/rockbox-fft/blob/master/apps/fixedpoint.c#L239

My knowledge is somewhat limited since last time I did this was years
ago, best to ask somebody with a EE degree who does DSP applications.


>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
