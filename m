From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: syslog problems
Date: Thu, 16 Jun 2011 10:58:22 -0700
Message-ID: <1E99DBBC-4C4D-4976-807A-9868DAC081C3@dreamhost.com>
References: <4DF8C122.5050506@gmail.com>	 <1308149436.2611.17.camel@wido-laptop.pcextreme.nl>	 <4DF8CA41.3020905@drwholdings.com> <1308165811.2805.2.camel@wido-laptop.pcextreme.nl> <4DF908C2.8000700@drwholdings.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50939 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab1FPR60 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2011 13:58:26 -0400
In-Reply-To: <4DF908C2.8000700@drwholdings.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <slang@drwholdings.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Sam,
Are you able to reproduce the OOM on the monitor?

If yes and you've got a new enough version of the code you should be able to enable heap profiling on your monitors by issuing:
ceph mon tell \* heap start_profiler
at which point the monitor memory allocator will keep track of all new memory allocations and periodically dump them out to files named something like "mon.a.0001.heap". With those files and the binary we should be able to figure out where the memory leak is coming from.

Thanks!
-Greg

On Jun 15, 2011, at 12:32 PM, Sam Lang wrote:

> On 06/15/2011 02:23 PM, Wido den Hollander wrote:
>> Hi,
>> 
>> On Wed, 2011-06-15 at 10:05 -0500, Sam Lang wrote:
>>> On 06/15/2011 09:50 AM, Wido den Hollander wrote:
>>>> Hi,
>>>> 
>>>> On Wed, 2011-06-15 at 09:26 -0500, Sam Lang wrote:
>>>>> In my ceph setup, I had logs being written to the default location
>>>>> (/var/log/ceph/) and eventually would get monitor or osd crashes because
>>>>> the disk would fill up with logs.  So I started writing the logs to
>>>>> syslog, and now the local disk doesn't fill up, but I still get similar
>>>>> errors to those of before.  For example:
>>>> How did you configure your syslogging? I'm using syslog as well with my
>>>> OSD's and that is working fine.
>>>> 
>>>> [global]
>>>>      auth supported = cephx
>>>>      debug ms = 0
>>>>      debug auth = 0
>>>>      debug rados = 0
>>>>      ms bind ipv6 = true
>>>>      keyring = /etc/ceph/keyring.bin
>>>>      log to syslog = true
>>>>      clog to syslog = true
>>>>      log file =
>>>>      log dir =
>>> Hi Wido,  I had just enabled the syslog setting from the default config:
>>> 
>>>          ; set log file
>>>          ; log file = /data/cephdata/$name.log
>>>          log_to_syslog = true        ; uncomment this line to log to syslog
>> Ah, you haven't disabled "log file", this makes the monitor log to
>> syslog AND to file.
> 
> Ah I see.  To disable the log file I need the 'log file =' line you
> used.  That explains the write_bl_ss failure, but not the OOM one.
> -sam
> 
>> That's why you're still seeing the crash you described.
>> 
>> Wido
>> 
>>>>> Also, I've seen a monitor process get killed by the OOM killer (see
>>>>> below).  Are these known issues?  In practice, do folks just disable all
>>>>> logging right now and hope for the best?
>>>> Now that is interesting! See: http://tracker.newdream.net/issues/1152
>>>> 
>>>> I've got the same issue, my MON keeps eating memory until the OOM-killer
>>>> kills it. I'm using syslog as well with high debugging set on the
>>>> monitor.
>>> I hadn't seen the OOM errors with the monitor until I started logging to
>>> syslog.  Can't say for certain if that's the cause though.
>>> 
>>>> Btw, what syslogging daemon are you using? I'm using rsyslogd, had to
>>>> switch to TCP though, since with high debugging turned on, UDP would
>>>> loose messages.
>>> I'm using rsyslogd, but with just the default config, so the messages
>>> are being written to /var/log/syslog
>>> -sam
>>> 
>>>> root@atom0:~# cat /etc/rsyslog.d/30-ceph.conf
>>>> # Sent all message to the remote syslog machine, then discard them to
>>>> prevent local logging
>>>> # Use TCP (@@) for transmission to prevent packet loss
>>>> :rawmsg,contains,"osd." @@noisy.ceph.widodh.nl
>>>> &   ~
>>>> :rawmsg,contains,"mon." @@noisy.ceph.widodh.nl
>>>> &   ~
>>>> :rawmsg,contains,"mds." @@noisy.ceph.widodh.nl
>>>> &   ~
>>>> root@atom0:~#
>>>> 
>>>> Wido
>>>> 
>>>>> Thanks,
>>>>> -sam
>>>>> 
>>>>> OOM killer messages:
>>>>> 
>>>>> [364540.080818] Node 0 DMA free:7992kB min:348kB low:432kB high:520kB
>>>>> active_anon:3632kB inactive
>>>>> _anon:3744kB active_file:0kB inactive_file:0kB unevictable:0kB
>>>>> isolated(anon):0kB isolated(file):
>>>>> 0kB present:15664kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB
>>>>> shmem:0kB slab_reclaimable:56k
>>>>> B slab_unreclaimable:384kB kernel_stack:64kB pagetables:16kB
>>>>> unstable:0kB bounce:0kB writeback_tm
>>>>> p:0kB pages_scanned:0 all_unreclaimable? yes
>>>>> [364540.080831] lowmem_reserve[]: 0 1963 1963 1963
>>>>> [364540.080837] Node 0 DMA32 free:44672kB min:44704kB low:55880kB
>>>>> high:67056kB active_anon:138704
>>>>> 4kB inactive_anon:462364kB active_file:520kB inactive_file:2780kB
>>>>> unevictable:0kB isolated(anon):
>>>>> 0kB isolated(file):0kB present:2010592kB mlocked:0kB dirty:4kB
>>>>> writeback:8kB mapped:396kB shmem:5
>>>>> 920kB slab_reclaimable:7928kB slab_unreclaimable:18600kB
>>>>> kernel_stack:7560kB pagetables:11992kB u
>>>>> nstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:2860
>>>>> all_unreclaimable? yes
>>>>> [364540.080850] lowmem_reserve[]: 0 0 0 0
>>>>> [364540.080856] Node 0 DMA: 14*4kB 14*8kB 7*16kB 3*32kB 3*64kB 2*128kB
>>>>> 4*256kB 4*512kB 2*1024kB 1
>>>>> *2048kB 0*4096kB = 7992kB
>>>>> [364540.080869] Node 0 DMA32: 9632*4kB 0*8kB 0*16kB 0*32kB 0*64kB
>>>>> 0*128kB 0*256kB 0*512kB 0*1024k
>>>>> B 1*2048kB 1*4096kB = 44672kB
>>>>> [364540.080882] 4870 total pagecache pages
>>>>> [364540.080884] 2596 pages in swap cache
>>>>> [364540.080887] Swap cache stats: add 501808, delete 499212, find 6734/8216
>>>>> [364540.080889] Free swap  = 0kB
>>>>> [364540.080891] Total swap = 1953040kB
>>>>> [364540.087324] 513696 pages RAM
>>>>> [364540.087327] 10085 pages reserved
>>>>> [364540.087329] 1907 pages shared
>>>>> [364540.087330] 487503 pages non-shared
>>>>> ...
>>>>> [364540.087475] [ 5998]     0  5975   851179   444043   0
>>>>> 0             0 cmon
>>>>> [364540.087480] [ 6188]     0  6188    49938      145   1
>>>>> 0             0 cmds
>>>>> [364540.087484] [ 6396]     0  6396   150647     1359   1
>>>>> 0             0 cosd
>>>>> [364540.087489] [ 6485]     0  6485   176420     7324   0
>>>>> 0             0 cosd
>>>>> [364540.087494] [ 7076]     0  7076   168333     1561   1
>>>>> 0             0 cosd
>>>>> [364540.087499] [ 7660]     0  7660   167456     1571   1
>>>>> 0             0 cosd
>>>>> [364540.087503] [ 7747]     0  7747   149214     1497   0
>>>>> 0             0 cosd
>>>>> [364540.087515] Out of memory: Kill process 5998 (cmon) score 776 or
>>>>> sacrifice child
>>>>> [364540.087570] Killed process 5998 (cmon) total-vm:3404716kB,
>>>>> anon-rss:1776172kB, file-rss:0kB
>>>>> 
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> This e-mail and any attachments may contain information that is confidential and proprietary and otherwise protected from disclosure. If you are not the intended recipient of this e-mail, do not read, duplicate or redistribute it by any means. Please immediately delete it and any attachments and notify the sender that you have received it in error. Unintended recipients are prohibited from taking action on the basis of information in this e-mail or any attachments. The DRW Companies make no representations that this e-mail or any attachments are free of computer viruses or other defects.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> This e-mail and any attachments may contain information that is confidential and proprietary and otherwise protected from disclosure. If you are not the intended recipient of this e-mail, do not read, duplicate or redistribute it by any means. Please immediately delete it and any attachments and notify the sender that you have received it in error. Unintended recipients are prohibited from taking action on the basis of information in this e-mail or any attachments. The DRW Companies make no representations that this e-mail or any attachments are free of computer viruses or other defects.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

