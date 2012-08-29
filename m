From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: mon crash on debian wheezy
Date: Wed, 29 Aug 2012 09:56:35 +0800
Message-ID: <503D76D3.9050004@gmail.com>
References: <5037376F.4080201@gmail.com> <alpine.DEB.2.00.1208240927490.29719@cobra.newdream.net> <503CDACA.6040303@gmail.com> <CAPYLRzgoRf11m6NampLc=p2uNA2VZ_4qwRK-2TOwZCutiYg1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63685 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2H2B4Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 21:56:25 -0400
Received: by pbbrr13 with SMTP id rr13so252980pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 18:56:25 -0700 (PDT)
In-Reply-To: <CAPYLRzgoRf11m6NampLc=p2uNA2VZ_4qwRK-2TOwZCutiYg1Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/29/2012 12:21 AM, Gregory Farnum wrote:
> On Tue, Aug 28, 2012 at 7:50 AM, Xiaopong Tran <xiaopong.tran@gmail.com> wrote:
>> On 08/25/2012 12:28 AM, Sage Weil wrote:
>>>
>>> On Fri, 24 Aug 2012, Xiaopong Tran wrote:
>>>>
>>>> Hello,
>>>>
>>>> I've been running the 0.48argonaut on production for over a month
>>>> without any issue. and today, I suddenly lost one mon. Taking a look
>>>> into the syslog file, I see the following trace log. I just couldn't
>>>> see what's wrong from the trace log. However, this event created
>>>> a gigantic core file. Here's the size of the core file:
>>>>
>>>> -rw------- 1 root root 16085647360 Aug 24 14:53 core
>>>>
>>>> This happened while we were migrating data from our old storage
>>>> to the ceph. We are running about 20 processes, migrating data
>>>> into ceph, while there are about 30 more application processes
>>>> reading from and writing new data to it.
>>>>
>>>> The following is from syslog:
>>>
>>>
>>> We've seen these backtraces before too, but haven't figured out what
>>> causes them.  (See, for example, http://tracker.newdream.net/issues/2026.)
>>>
>>> Was there anything in the mon's log file?  In most cases, a crash results
>>> in a stack trace of ceph-mon in the mon log file.
>>>
>>> Glad to hear everything recovered nicely afterwards.  :)
>>>
>>> Thanks!
>>> sage
>>>
>>
>> Ah well, I got two crashes in less than 3 days. I browsed thru the
>> mon log files, and the ceph log files, and there is nothing suspicious,
>> no trace dump or anything.
>>
>> One question I don't get is, after mon has crashed, it's not running
>> anymore, who is creating that empty mon log? The same question goes
>> for osd. I had two osd down today, and I also see empty osd log files.
>>
>> And how does the crash end up generating such a huge core file?
>>
>> If there's any information I can provide, I'd be happy to do so.
>
> Can you extract the backtrace from the core dump?
>

Will try to do that, it's a big one though :)

Thanks

Xiaopong


