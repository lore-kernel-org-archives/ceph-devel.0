From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 15:22:43 +0200
Message-ID: <4FEDAC23.1000705@profihost.ag>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com> <4FEDA777.1060309@profihost.ag> <4FEDA978.3050106@profihost.ag> <4FEDAA9B.4040101@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50998 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab2F2NWu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 09:22:50 -0400
In-Reply-To: <4FEDAA9B.4040101@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alexandre DERUMIER <aderumier@odiso.com>


iostat output via iostat -x -t 5 while 4k random writes


06/29/2012 03:20:55 PM
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           31,63    0,00   52,64    0,78    0,00   14,95

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
avgrq-sz avgqu-sz   await  svctm  %util
sdb               0,00   690,40    0,00 3143,60     0,00 33958,80 
10,80     2,68    0,85   0,08  24,08
sdc               0,00  1069,80    0,00 5151,60     0,00 54693,00 
10,62     8,31    1,61   0,06  29,68
sdd               0,00   581,00    0,00 2762,80     0,00 27809,00 
10,07     2,45    0,89   0,08  21,12
sde               0,00   820,00    0,00 4208,20     0,00 43457,40 
10,33     4,00    0,95   0,07  28,56
sda               0,00     0,00    0,00    0,40     0,00     9,60 
24,00     0,00    0,00   0,00   0,00

06/29/2012 03:21:00 PM
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           29,68    0,00   52,89    0,98    0,00   16,45

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
avgrq-sz avgqu-sz   await  svctm  %util
sdb               0,00  1046,60    0,00 5544,20     0,00 57938,00 
10,45     6,08    1,10   0,06  32,08
sdc               0,00   115,60    0,00 3483,60     0,00 29368,00 
8,43     3,45    0,99   0,06  21,36
sdd               0,00  1143,20    0,00 5991,00     0,00 62607,40 
10,45     6,03    1,01   0,06  35,20
sde               0,00  1070,00    0,00 5561,60     0,00 58207,20 
10,47     5,76    1,04   0,07  38,08
sda               0,00     0,00    0,00    0,00     0,00     0,00 
0,00     0,00    0,00   0,00   0,00

06/29/2012 03:21:05 PM
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           29,69    0,00   53,06    0,60    0,00   16,65

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
avgrq-sz avgqu-sz   await  svctm  %util
sdb               0,00   199,60    0,00 4484,40     0,00 41338,20 
9,22     1,96    0,44   0,07  30,56
sdc               0,00   766,60    0,00 3616,20     0,00 38829,00 
10,74     3,62    1,00   0,07  25,68
sdd               0,00   149,20    0,00 5066,60     0,00 45793,60 
9,04     4,48    0,89   0,06  28,48
sde               0,00   150,00    0,00 4328,80     0,00 36496,00 
8,43     2,96    0,68   0,07  32,40
sda               0,00     0,00    0,00    0,40     0,00    35,20 
88,00     0,00    0,00   0,00   0,00

06/29/2012 03:21:10 PM
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           29,11    0,00   46,58    0,50    0,00   23,81

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
avgrq-sz avgqu-sz   await  svctm  %util
sdb               0,00   881,20    0,00 3077,20     0,00 33382,80 
10,85     3,44    1,12   0,06  18,16
sdc               0,00   867,60    0,00 5098,40     0,00 52056,20 
10,21     5,65    1,11   0,05  24,32
sdd               0,00   864,40    0,00 2759,00     0,00 30321,60 
10,99     3,39    1,23   0,06  17,36
sde               0,00   846,20    0,00 3193,40     0,00 36795,60 
11,52     3,48    1,09   0,06  19,92
sda               0,00     0,00    0,00    1,40     0,00    11,20 
8,00     0,01    4,57   2,29   0,32


Am 29.06.2012 15:16, schrieb Stefan Priebe - Profihost AG:
> Big sorry. ceph was scrubbing during my last test. Didn't recognized this.
>
> When i redo the test i see writes between 20MB/s and 100Mb/s. That is
> OK. Sorry.
>
> Stefan
>
> Am 29.06.2012 15:11, schrieb Stefan Priebe - Profihost AG:
>> Another BIG hint.
>>
>> While doing random 4k I/O from one VM i archieve 14k I/Os. This is
>> around 54MB/s. But EACH ceph-osd machine is writing between 500MB/s and
>> 750MB/s. What do they write?!?!
>>
>> Just an idea?:
>> Do they completely rewrite EACH 4MB block for each 4k write?
>>
>> Stefan
>>
>> Am 29.06.2012 15:02, schrieb Stefan Priebe - Profihost AG:
>>> Am 29.06.2012 13:49, schrieb Mark Nelson:
>>>> I'll try to replicate your findings in house.  I've got some other
>>>> things I have to do today, but hopefully I can take a look next
>>>> week. If
>>>> I recall correctly, in the other thread you said that sequential writes
>>>> are using much less CPU time on your systems?
>>>
>>> Random 4k writes: 10% idle
>>> Seq 4k writes: !! 99,7% !! idle
>>> Seq 4M writes: 90% idle
>>>
>>>
>>>  >  Do you see better scaling in that case?
>>>
>>> 3 osd nodes:
>>> 1 VM:
>>> Rand 4k writes: 7000 iops
>>> Seq 4k writes: 19900 iops
>>>
>>> 2 VMs:
>>> Rand 4k writes: 6000 iops each
>>> Seq 4k writes: 4000 iops each VM 1
>>> Seq 4k writes: 18500 iops each VM 2
>>>
>>>
>>> 4 osd nodes:
>>> 1 VM:
>>> Rand 4k writes: 14400 iops
>>> Seq 4k writes: 19000 iops
>>>
>>> 2 VMs:
>>> Rand 4k writes: 7000 iops each
>>> Seq 4k writes: 18000 iops each
>>>
>>>
>>>
>>>> To figure out where CPU is being used, you could try various options:
>>>> oprofile, perf, valgrind, strace.  Each has it's own advantages.
>>>>
>>>> Here's how you can create a simple callgraph with perf:
>>>>
>>>> http://lwn.net/Articles/340010/
>>> 10s perf data output while doing random 4k writes:
>>> https://raw.github.com/gist/2c16136faebec381ae35/09e6de68a5461a198430a9ec19dfd5392f276706/gistfile1.txt
>>>
>>>
>>>
>>>
>>> Stefan
>>
>

