From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Sun, 4 Dec 2011 22:22:15 -0800
Message-ID: <5154145039466346698@unknownmsgid>
References: <4EDC0ECF.60805@cs.ucsc.edu> <4EDC1853.5080405@cs.ucsc.edu> <Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net>
Mime-Version: 1.0 (iPhone Mail 8J2)
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42664 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1LEGW1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 01:22:27 -0500
Received: by faar15 with SMTP id r15so140319faa.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Dec 2011 22:22:26 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sent from my iPhone

On Dec 4, 2011, at 20:48, Sage Weil <sage@newdream.net> wrote:

> On Sun, 4 Dec 2011, Noah Watkins wrote:
>> Yikes, I think this was actually the problem. nm
>>
>> # ulimit -n
>> 1024
>
> I'm a little surprised the fd count got that high with a fixed size
> cluster.  Were there lots of short-lived clients?

Not a lot. Maybe a hundred total over a few hours.


>
> It would be interested to see what `ls -al /proc/$pid/fd` looks like after
> the process has been running for a while...  there is probably a leak
> somewhere.

I checked this out after the problem became noticeable. There were
significantly less than 1024 file nos but still several hundred w no
active clients. I think this latest fix is masking things. I'll drop
the ulimit backdown and gather some more info.


>
> sage
>
>
>>
>> -----
>>
>> root@issdm-23:/var/log/ceph# grep -n  "Too many" full_conn_refused.log
>> 2417924:2011-12-04 14:52:15.289873 7f1406ecb700 -- 192.168.141.123:6800/1325
>> accepter no incoming connection?  sd = -1 errno 24 Too many open files
>> 2417925:2011-12-04 14:52:15.289923 7f1406ecb700 -- 192.168.141.123:6800/1325
>> accepter no incoming connection?  sd = -1 errno 24 Too many open files
>> 2417926:2011-12-04 14:52:15.289952 7f1406ecb700 -- 192.168.141.123:6800/1325
>> accepter no incoming connection?  sd = -1 errno 24 Too many open files
>> 2417927:2011-12-04 14:52:15.289970 7f1406ecb700 -- 192.168.141.123:6800/1325
>> accepter no incoming connection?  sd = -1 errno 24 Too many open files
>> 2417928:2011-12-04 14:52:15.290002 7f1406ecb700 -- 192.168.141.123:6800/1325
>> accepter no incoming connection?  sd = -1 errno 24 Too many open files
>>
>> On 12/04/2011 04:22 PM, Noah Watkins wrote:
>>> We are experiencing client connection problems that occur only after some
>>> period of heavy use. Prior to the 'connection refused' error in the client
>>> log the cluster behaves as normal. Restarting Ceph solves the problem but we
>>> are not able to finish long jobs.
>>>
>>> Logs attached. I have the full 1 GB MDS log if needed, and included only the
>>> portition of the log in which the client had problems plus about 5 seconds
>>> of context on either side of the test.
>>>
>>> Thanks,
>>> Noah
>>>
>>> Client
>>> ====
>>> ...
>>> 2011-12-04 16:07:58.154523 7f4458314700 -- 192.168.141.123:0/1009375 >>
>>> 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).connect
>>> 0
>>> 2011-12-04 16:07:58.154562 7f4458314700 -- 192.168.141.123:0/1009375 >>
>>> 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0
>>> l=0).connecting to 192.168.141.123:6800/1325
>>> 2011-12-04 16:07:58.154605 7f4458314700 -- 192.168.141.123:0/1009375 >>
>>> 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).connect
>>> error 192.168.141.123:6800/1325, 111: Connection refused
>>> 2011-12-04 16:07:58.154620 7f4458314700 -- 192.168.141.123:0/1009375 >>
>>> 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).fault
>>> 111: Connection refused
>>> 2011-12-04 16:07:58.154635 7f4458314700 -- 192.168.141.123:0/1009375 >>
>>> 192.168.141.123:6800/1325 pipe(0x7f445437d020 sd=55 pgs=0 cs=0 l=0).fault
>>> waiting 3.200000
>>>
>>> Full logs attached.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
