From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Profiling with Perf
Date: Wed, 12 Nov 2014 15:16:15 -0600
Message-ID: <5463CE1F.5060509@redhat.com>
References: <5462C456.8070601@redhat.com>	<5463C63B.2070502@redhat.com> <CANP1eJFi3AhK-7HYLm7n78=ygGK2d4_UXc2_EqOCc3tFUVvtOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58103 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaKLVQS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 16:16:18 -0500
Received: by mail-ie0-f171.google.com with SMTP id x19so14457613ier.16
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 13:16:18 -0800 (PST)
In-Reply-To: <CANP1eJFi3AhK-7HYLm7n78=ygGK2d4_UXc2_EqOCc3tFUVvtOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/12/2014 02:59 PM, Milosz Tanski wrote:
> On Wed, Nov 12, 2014 at 3:42 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
>> Hi, there was a question on the performance call today about how to use
>> dwarf symbols in perf.  Roughly:
>>
>> 1) Make sure during the kernel/perf compile that libunwind is used. This can
>> be tricky depending on how you build the kernel, but theoretically should
>> work.
>>
>> 2) invoke perf using something like:
>>
>> "perf record -g dwarf -F 100 -a"
>>
>> This tells perf to use dwarf symbols but limit the sampling rate.  perf can
>> generate a *lot* of data with dwarf symbols and default sampling.
>>
>> 3) Look at results in perf report as normal.
>>
>> 4) Profit!
>>
>> Theoretically if you have frame pointers enabled when you compile ceph you
>> should get good symbol resolution without dwarf but I've never gotten it to
>> work well.  Perf+Dwarf seems to give much better symbol resolution than
>> anything else I've tried with Ceph.  There's some new LBR functionality for
>> profiling on Haswell in perf that might work too, but I haven't tried it:
>>
>> https://lkml.org/lkml/2014/10/19/166
>
> Mark,
>
> I personally would strong recommend using perf without the dwarf as it
> seams writes very large trace files. It's not just file size, but it
> also takes a very long time to load up profile in the other tools
> (perf report). If you can help it rebuild the app with out the code
> (eg the gcc -fno-omit-frame-pointer flag). When I say space savings
> with call stack savings I mean like order of 2 magnitudes smaller
> profile file (eg. you can log much longer / complicated runs).

Do you have problems with large trace files when you limit the sampling 
frequency?  It hasn't been a problem for me when doing that.

>
> Additionally, it seams to better handle splitting of inline functions
> (where otherwise this would get folded into a large function). The
> omit behavior is default on x86_64, which is what I assume most people
> are building / testing on. There is a performance penalty for this as
> the compiler will be generating an extra instruction to update EBP...
> but for real world code this is less then 5% of a penalty.

To be honest even when compiling with fno-omit-frame-pointer I've had a 
ton of problems with symbol resolution.  It's been a while since I 
messed with this so perhaps things have improved since then.

>
> I spend a lot of time using perf and looking at it's traces (runtime,
> futex profiling, looking at bad branch points) every week. It took me
> a little while to figure this out... I hope it help you guys.

Other than compiling with fno-omit-frame-pointer, is there anything else 
you do to get good symbol resolution?  What platform are you using? 
This kind of information would be very valuable for the community if you 
can share. :)

>
> - Milosz
>
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

