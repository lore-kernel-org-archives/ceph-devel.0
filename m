From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Fri, 09 Nov 2012 11:09:36 +0100
Message-ID: <509CD660.6050306@profihost.ag>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag> <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net> <509BD38B.8090200@profihost.ag> <509BD87F.1010107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59214 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2KIKJr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 05:09:47 -0500
In-Reply-To: <509BD87F.1010107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Disabling the logging with:
  debug lockdep = 0/0
  debug context = 0/0
  debug crush = 0/0
  debug buffer = 0/0
  debug timer = 0/0
  debug journaler = 0/0
  debug osd = 0/0
  debug optracker = 0/0
  debug objclass = 0/0
  debug filestore = 0/0
  debug journal = 0/0
  debug ms = 0/0
  debug monc = 0/0
  debug tp = 0/0
  debug auth = 0/0
  debug finisher = 0/0
  debug heartbeatmap = 0/0
  debug perfcounter = 0/0
  debug asok = 0/0
  debug throttle = 0/0

reduced the CPU load about 50% ! So each OSD process now takes only one 
whole 3.6Ghz core instead of two.

Have you looked at my latest profile graph with disabled debug options?

Greets,
Stefan


Am 08.11.2012 17:06, schrieb Mark Nelson:
> On 11/08/2012 09:45 AM, Stefan Priebe - Profihost AG wrote:
>> Am 08.11.2012 16:01, schrieb Sage Weil:
>>> On Thu, 8 Nov 2012, Stefan Priebe - Profihost AG wrote:
>>>> Is there any way to find out why a ceph-osd process takes around 10
>>>> times more
>>>> load on rand 4k writes than on 4k reads?
>>>
>>> Something like perf or oprofile is probably your best bet.  perf can be
>>> tedious to deploy, depending on where your kernel is coming from.
>>> oprofile seems to be deprecated, although I've had good results with
>>> it in
>>> the past.
>>
>> I've recorded 10s with perf - it is now a 300MB perf.data file. Sadly
>> i've no idea what todo with it next.
>
> Pour yourself a stiff drink! (haha!)
>
> Try just doing a "perf report" in the directory where you've got the
> data file.  Here's a nice tutorial:
>
> https://perf.wiki.kernel.org/index.php/Tutorial
>
> Also, if you see missing symbols you might benefit by chowning the file
> to root and running perf report as root.  If you still see missing
> symbols, you may want to just give up and try sysprof.
>
>>
>>>   would love to see where the CPU is spending most of it's time.
>>> This is
>>> on current master?
>> Yes
>>
>>>  I expect there are still some low-hanging fruit that
>>> can bring CPU utilization down (or even boost iops).
>> Would be great to find them.
>>
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
