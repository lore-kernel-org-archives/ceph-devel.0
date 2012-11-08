From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Thu, 08 Nov 2012 15:58:29 -0600
Message-ID: <509C2B05.2070200@inktank.com>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag> <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net> <509BD38B.8090200@profihost.ag> <509BD87F.1010107@inktank.com> <509C23A7.9010109@profihost.ag> <509C2939.5000201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:50251 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab2KHV6Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 16:58:24 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so2291060iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 13:58:23 -0800 (PST)
In-Reply-To: <509C2939.5000201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/08/2012 03:50 PM, Josh Durgin wrote:
> On 11/08/2012 01:27 PM, Stefan Priebe wrote:
>> Am 08.11.2012 17:06, schrieb Mark Nelson:
>>> On 11/08/2012 09:45 AM, Stefan Priebe - Profihost AG wrote:
>>>> Am 08.11.2012 16:01, schrieb Sage Weil:
>>>>> On Thu, 8 Nov 2012, Stefan Priebe - Profihost AG wrote:
>>>>>> Is there any way to find out why a ceph-osd process takes around 10
>>>>>> times more
>>>>>> load on rand 4k writes than on 4k reads?
>>>>>
>>>>> Something like perf or oprofile is probably your best bet.  perf
>>>>> can be
>>>>> tedious to deploy, depending on where your kernel is coming from.
>>>>> oprofile seems to be deprecated, although I've had good results with
>>>>> it in
>>>>> the past.
>>>>
>>>> I've recorded 10s with perf - it is now a 300MB perf.data file. Sadly
>>>> i've no idea what todo with it next.
>>>
>>> Pour yourself a stiff drink! (haha!)
>>>
>>> Try just doing a "perf report" in the directory where you've got the
>>> data file.  Here's a nice tutorial:
>>>
>>> https://perf.wiki.kernel.org/index.php/Tutorial
>>>
>>> Also, if you see missing symbols you might benefit by chowning the file
>>> to root and running perf report as root.  If you still see missing
>>> symbols, you may want to just give up and try sysprof.
>>
>> I've now used google perftools / google CPU profiler. It was the only
>> tool who worked out of the box ;-)
>>
>> Attached is a PDF with a profiled ceph-osd process while 4k random write.
>
> It looks like a not insignificant portion of time is spent in the
> logging infrastructure. Could you add this to the osds' configuration
> to prevent any debug log gathering (it's logged/gathered):
>
> debug lockdep = 0/0
> debug context = 0/0
> debug crush = 0/0
> debug buffer = 0/0
> debug timer = 0/0
> debug journaler = 0/0
> debug osd = 0/0
> debug optracker = 0/0
> debug objclass = 0/0
> debug filestore = 0/0
> debug journal = 0/0
> debug ms = 0/0
> debug monc = 0/0
> debug tp = 0/0
> debug auth = 0/0
> debug finisher = 0/0
> debug heartbeatmap = 0/0
> debug perfcounter = 0/0
> debug asok = 0/0
> debug throttle = 0/0
>
> Josh

Also, I'm not sure what version you are running, but you may want to try 
testing master and see if that helps.  Sam has done some work on our 
threading and locking code that might help.
