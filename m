From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [BUG] ceph-mon crashes
Date: Mon, 12 Nov 2012 14:58:57 +0000
Message-ID: <50A10EB1.4040802@inktank.com>
References: <50A01DCB.9010001@profihost.ag> <50A024B2.3080502@inktank.com> <50A02542.1000602@profihost.ag> <50A03412.1030206@inktank.com> <21B8A3CE-BC02-44AF-ABB5-45C9C74F9380@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59881 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab2KLO7J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 09:59:09 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so4706124lbo.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 06:59:08 -0800 (PST)
In-Reply-To: <21B8A3CE-BC02-44AF-ABB5-45C9C74F9380@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,


Any chance you can get me a larger chunk of the log from the monitor
that was the leader by the time you issued those commands until the
point the monitor crashed (from the excerpt you provided, that should be
mon.b)?


  -Joao
On 11/12/2012 06:21 AM, Stefan Priebe - Profihost AG wrote:
> 
> Am 12.11.2012 um 00:26 schrieb Joao Eduardo Luis <joao.luis@inktank.com>:
> 
>> On 11/11/2012 10:22 PM, Stefan Priebe wrote:
>>> I wanted to remove osd.51 to 54. And executed the following commands:
>>> ceph osd 51 out
>>> ceph osd 52 out
>>> ceph osd 53 out
>>> ceph osd 54 out
>>>
>>> Greets,
>>> Stefan
>>
>> Were those osds shutdown/killed before issuing the out commands?
> No
> 
> 
>>
>> And I'm assuming all the commands completed successfully with a 'marked
>> out osd.X'. Is this correct?
> Yes
> 
> Stefan
> 
> 
>>
>>  -Joao
>>
>>
>>> Am 11.11.2012 23:20, schrieb Joao Eduardo Luis:
>>>> Hi Stefan,
>>>>
>>>> Any chance you can get us the output of `ceph osd dump | grep 'osd.53'`?
>>>>
>>>> Also, do you have any idea what happened to osd.53?
>>>>
>>>>   -Joao
>>>>
>>>> On 11/11/2012 09:51 PM, Stefan Priebe wrote:
>>>>> Hello list,
>>>>>
>>>>> i've now seen the following ceph-mon crash several times:
>>>>>    -22> 2012-11-11 22:45:10.941641 7f5d49168700  1
>>>>> mon.b@1(leader).paxos(pgmap active c 11425..11925) is_readable
>>>>> now=2012-11-11 22:45:10.941643 lease_expire=2012-11-11 22:45:15.313577
>>>>> has v1017 lc 11925
>>>>>    -21> 2012-11-11 22:45:11.017199 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== mon.2 10.255.0.102:6789/0 123 ==== paxos(logm
>>>>> lease_ack lc 14415 fc 13913 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (1926207536
>>>>> 0 0) 0x58fe840 con 0x2c38c60
>>>>>    -20> 2012-11-11 22:45:11.084775 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== mon.2 10.255.0.102:6789/0 124 ==== paxos(mdsmap
>>>>> lease_ack lc 1 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (2037515134 0 0)
>>>>> 0x4e59080 con 0x2c38c60
>>>>>    -19> 2012-11-11 22:45:11.084812 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== mon.2 10.255.0.102:6789/0 125 ==== paxos(monmap
>>>>> lease_ack lc 1 fc 1 pn 0 opn 0 gv {}) v2 ==== 88+0+0 (3822314369 0 0)
>>>>> 0x4e58580 con 0x2c38c60
>>>>>    -18> 2012-11-11 22:45:11.230970 7f5d48065700  2 --
>>>>> 10.255.0.101:6789/0 >> 10.255.0.100:6789/0 pipe(0x2cc9b40 sd=17 :6789
>>>>> pgs=16 cs=2 l=0).connect error 10.255.0.100:6789/0, 111: Connection
>>>>> refused
>>>>>    -17> 2012-11-11 22:45:11.231004 7f5d48065700  2 --
>>>>> 10.255.0.101:6789/0 >> 10.255.0.100:6789/0 pipe(0x2cc9b40 sd=17 :6789
>>>>> pgs=16 cs=2 l=0).fault 111: Connection refused
>>>>>    -16> 2012-11-11 22:45:11.238427 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== osd.33 10.255.0.102:6806/3537 1315 ====
>>>>> pg_stats(478 pgs tid 185 v 1017) v1 ==== 158856+0+0 (1263639313 0 0)
>>>>> 0x2ca5b40 con 0x2ca4dc0
>>>>>    -15> 2012-11-11 22:45:11.238451 7f5d49168700  1
>>>>> mon.b@1(leader).paxos(pgmap active c 11425..11925) is_readable
>>>>> now=2012-11-11 22:45:11.238452 lease_expire=2012-11-11 22:45:15.313577
>>>>> has v1017 lc 11925
>>>>>    -14> 2012-11-11 22:45:11.287036 7f5d49969700  5
>>>>> mon.b@1(leader).paxos(pgmap active c 11425..11925) propose_new_value
>>>>> 11926 311714 bytes, gv 28550
>>>>>    -13> 2012-11-11 22:45:11.296084 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== osd.41 10.255.0.103:6800/3324 1086 ====
>>>>> pg_stats(440 pgs tid 185 v 1017) v1 ==== 146276+0+0 (1903337195 0 0)
>>>>> 0x39bad80 con 0x2ca4c60
>>>>>    -12> 2012-11-11 22:45:11.350697 7f5d49969700  1 --
>>>>> 10.255.0.101:6789/0 --> mon.2 10.255.0.102:6789/0 -- paxos(pgmap begin
>>>>> lc 11925 fc 0 pn 3501 opn 0 gv {11926=28550}) v2 -- ?+0 0x4e60b00
>>>>>    -11> 2012-11-11 22:45:11.350790 7f5d49168700  1
>>>>> mon.b@1(leader).paxos(pgmap updating c 11425..11925) is_readable
>>>>> now=2012-11-11 22:45:11.350793 lease_expire=2012-11-11 22:45:15.313577
>>>>> has v1017 lc 11925
>>>>>    -10> 2012-11-11 22:45:11.435570 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== mon.2 10.255.0.102:6789/0 126 ==== paxos(pgmap
>>>>> accept lc 11925 fc 0 pn 3501 opn 0 gv {}) v2 ==== 88+0+0 (3719346061 0
>>>>> 0) 0x4e60b00 con 0x2c38c60
>>>>>     -9> 2012-11-11 22:45:11.476091 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 --> mon.2 10.255.0.102:6789/0 -- paxos(pgmap commit
>>>>> lc 11926 fc 0 pn 3501 opn 0 gv {11926=28550}) v2 -- ?+0 0x4e58580
>>>>>     -8> 2012-11-11 22:45:11.476125 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 --> mon.2 10.255.0.102:6789/0 -- paxos(pgmap lease
>>>>> lc 11926 fc 11425 pn 0 opn 0 gv {}) v2 -- ?+0 0x4e59080
>>>>>     -7> 2012-11-11 22:45:11.593945 7f5d49168700  0 log [INF] : pgmap
>>>>> v11926: 7032 pgs: 5977 active+clean, 62 active+remapped+wait_backfill,
>>>>> 586 active+degraded+wait_backfill, 32 active+remapped+backfilling, 18
>>>>> active+degraded+backfilling, 343 active+degraded+remapped+wait_backfill,
>>>>> 2 remapped+peering, 12 active+degraded+remapped+backfilling; 61211 MB
>>>>> data, 61662 MB used, 4185 GB / 4245 GB avail; 5419/31221 degraded
>>>>> (17.357%)
>>>>>     -6> 2012-11-11 22:45:11.593954 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 --> mon.1 10.255.0.101:6789/0 -- log(1 entries) v1
>>>>> -- ?+0 0x40c7200
>>>>>     -5> 2012-11-11 22:45:11.593969 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 --> 10.255.0.103:6803/3461 -- pg_stats_ack(460 pgs
>>>>> tid 185) v1 -- ?+0 0x3ab5a80 con 0x3bd5420
>>>>>     -4> 2012-11-11 22:45:11.594050 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 --> 10.255.0.102:6806/3537 -- pg_stats_ack(478 pgs
>>>>> tid 185) v1 -- ?+0 0x4f0b8c0 con 0x2ca4dc0
>>>>>     -3> 2012-11-11 22:45:11.594359 7f5d49168700  1
>>>>> mon.b@1(leader).paxos(pgmap active c 11426..11926) is_readable
>>>>> now=2012-11-11 22:45:11.594363 lease_expire=2012-11-11 22:45:16.476123
>>>>> has v1017 lc 11926
>>>>>     -2> 2012-11-11 22:45:11.594736 7f5d49168700  1 --
>>>>> 10.255.0.101:6789/0 <== mon.1 10.255.0.101:6789/0 0 ==== log(1 entries)
>>>>> v1 ==== 0+0+0 (0 0 0) 0x40c7200 con 0x2c382c0
>>>>>     -1> 2012-11-11 22:45:11.595139 7f5d49969700  1 mon.b@1(leader).osd
>>>>> e1017  we have enough reports/reporters to mark osd.53 down
>>>>>      0> 2012-11-11 22:45:11.595601 7f5d49969700 -1 ./osd/OSDMap.h: In
>>>>> function 'entity_inst_t OSDMap::get_inst(int) const' thread 7f5d49969700
>>>>> time 2012-11-11 22:45:11.595149
>>>>> ./osd/OSDMap.h: 345: FAILED assert(is_up(osd))
>>>>>
>>>>>  ceph version 0.53-758-g26e5f2d
>>>>> (26e5f2d63f569b955bb07b50aa8f930ed9450bc4)
>>>>>  1: (OSDMonitor::check_failure(utime_t, int, failure_info_t&)+0xc09)
>>>>> [0x4b14e9]
>>>>>  2: (OSDMonitor::check_failures(utime_t)+0x3a) [0x4b16ca]
>>>>>  3: (OSDMonitor::tick()+0xab) [0x4b213b]
>>>>>  4: (Monitor::tick()+0x6d) [0x477fcd]
>>>>>  5: (SafeTimer::timer_thread()+0x453) [0x58f203]
>>>>>  6: (SafeTimerThread::entry()+0xd) [0x5913dd]
>>>>>  7: (()+0x68ca) [0x7f5d4dbce8ca]
>>>>>  8: (clone()+0x6d) [0x7f5d4c456bfd]
>>>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>>>> needed to interpret this.
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

