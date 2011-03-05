From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: about cpu_profiler
Date: Fri, 4 Mar 2011 18:17:50 -0800
Message-ID: <AANLkTi=RWv809C7DU+4YxUVb3TYxsbD30h3BTNArC31h@mail.gmail.com>
References: <AANLkTimYykJpXQF3qUPYA7OF2jUf55WruXje1q0xJTet@mail.gmail.com>
	<00BB198CFBE347429653477BED3AA89B@gmail.com>
	<AANLkTinNO-U_E-Z76obnTJ+Ciz9VqWfBJr24J9-bBdGJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48586 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1CECRv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 21:17:51 -0500
Received: by fxm17 with SMTP id 17so2724766fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 18:17:50 -0800 (PST)
In-Reply-To: <AANLkTinNO-U_E-Z76obnTJ+Ciz9VqWfBJr24J9-bBdGJ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

I wrote a wiki page about using oprofile with Ceph. It's at:

http://ceph.newdream.net/wiki/Cpu_profiling

I guess we should give this a try next time we have a CPU load problem.

Apparently you can get really detailed with oprofile and measure
things like number of CPU pipeline stalls and cache line misses. I
didn't do any of that-- just used the simple counter.

Colin


On Fri, Mar 4, 2011 at 12:47 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> I'm testing out oprofile now. So far, it seems relatively painless,
> and it is a system-wide profiler. It seems to have some kernel hooks
> too...
>
> Colin
>
>
> On Fri, Mar 4, 2011 at 12:40 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>>
>> On Friday, March 4, 2011 at 12:08 PM, Colin McCabe wrote:
>>> tl;dr: cpu_profiler may randomly crash your program on x86_64.
>>> The problem "should" be resolved in the "future".
>>
>> From what I've read, it's unfortunately not out of date. However, it manifests itself as a crash so it's not the reason that we can't get debugging output, unless there's something I'm missing. :)
>> And even if it turns out to be very unstable on x86-64, the value of a good cpu profiler is high enough that we can set up x86 boxes or VMs...
>> -Greg
>>
>>
>>
>>
>
