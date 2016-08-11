From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD not coming back up again
Date: Thu, 11 Aug 2016 14:11:23 +0200
Message-ID: <a2b73b5d-36f3-c2cb-0060-12f4b9670b1f@digiware.nl>
References: <bdb93e87-8338-e485-a68d-f988d00f6785@digiware.nl>
 <453729567.2335.1470896803201@ox.pcextreme.nl>
 <5727f9c9-57e0-6256-dbd7-30b73c6feaec@digiware.nl>
 <1788022033.2389.1470915881301@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:20767 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbcHKMLc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 08:11:32 -0400
In-Reply-To: <1788022033.2389.1470915881301@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 11-8-2016 13:44, Wido den Hollander wrote:
> 
>> Op 11 augustus 2016 om 13:39 schreef Willem Jan Withagen <wjw@digiware.nl>:
>>
>>
>> On 11-8-2016 08:26, Wido den Hollander wrote:
>>>
>>>> Op 11 augustus 2016 om 2:40 schreef Willem Jan Withagen <wjw@digiware.nl>:
>>>>
>>>>
>>>> Hi
>>>>
>>>> During testing with cephtool-test-mon.sh
>>>>
>>>> 3 OSDs are started, and then the code executes:
>>>> ====
>>>>   ceph osd set noup
>>>>   ceph osd down 0
>>>>   ceph osd dump | grep 'osd.0 down'
>>>>   ceph osd unset noup
>>>> ====
>>>>
>>>> And in 1000 secs osd.0 is not coming back up.
>>>>
>>>> Below some details, but where should I start looking?
>>>>
>>> Can you use the admin socket to query osd.0?
>>>
>>> ceph daemon osd.0 status
>>>
>>> What does that tell you?
>>>
>>> Maybe try debug_osd = 20
>>
>> Hi Wido,
>>
>> Thanx for the help.
>>
>> Below is a full cycle in the osd.0.log which seems to be stuck at 178
>> But osd.1 has:
>> {
>>     "cluster_fsid": "4c57b34a-263a-41b0-a3b9-0e494ab840f5",
>>     "osd_fsid": "99296090-9d6f-44be-9fdc-9c1266f12325",
>>     "whoami": 1,
>>     "state": "active",
>>     "oldest_map": 1,
>>     "newest_map": 179,
>>     "num_pgs": 8
>> }
>> Which is also what the cluster thinks:
>>
>>     cluster 4c57b34a-263a-41b0-a3b9-0e494ab840f5
>>      health HEALTH_WARN
>>             8 pgs degraded
>>             8 pgs stuck unclean
>>             8 pgs undersized
>>      monmap e1: 3 mons at
>> {a=127.0.0.1:7202/0,b=127.0.0.1:7203/0,c=127.0.0.1:7204/0}
>>             election epoch 6, quorum 0,1,2 a,b,c
>>      osdmap e179: 3 osds: 2 up, 2 in; 8 remapped pgs
>>             flags sortbitwise,require_jewel_osds,require_kraken_osds
>>       pgmap v494: 8 pgs, 1 pools, 0 bytes data, 0 objects
>>             248 GB used, 188 GB / 437 GB avail
>>                    8 active+undersized+degraded
>>
>> So one way or another the down OSD does not receive the last pgmap?
>>
>> How does the pgmap update work?
>> The OSD asks the/any mon for the last pgmap?
>> The MONs are listening on 7202/7203/7204
>>
>> Now if I look in the sockets table I seed osd.1 and osd.2 connected to
>> each other each with 2 connections.
>> But osd.0 has sockets registered to osd.1 and osd.2.
>> But osd.1 and osd.2 do not have these sockets in their table.
>>
>> So could it be that OSD.0 has not correctly reset the links? Because i
>> understood that down/up will go thru a full disconnect?
>>
> 
> Could be, but the log line which is interesting:
> 
> 2016-08-11 12:06:16.473351 b69c480 10 osd.0 178 handle_osd_ping osd.2
> 127.0.0.1:6811/13222 says i am down in 178
> 
> It sees that he is down in map 178, but it should then present a 'marked me down incorrectly' and mark itself up.

6811 is a port of osd.2, so one way or another there is some
communication with osd.2. So that suggests that a socket has opened.
Wierd part is that osd.2 then actually closes it again. And the socket
in osd.0 goes into TIME_WAIT. I think with SO_REUSEADDR in the options,
so that port could fast reused.

Would this happen even though it is still behind on pgmaps?
Or does it have to be up first, and then start fetching new maps, and
get in line with the other OSDs?

I think you are refering to:
./src/osd/OSD.cc:6943:                 << " wrongly marked me down";

Going to dig into that area what is going there.

Thanx
--WjW


>> --WjW
>>
>> # sockstat | grep 13193
>> wjw      ceph-osd   13193 5  tcp4   *:6800                *:*
>> wjw      ceph-osd   13193 6  tcp4   *:6801                *:*
>> wjw      ceph-osd   13193 7  tcp4   *:6802                *:*
>> wjw      ceph-osd   13193 8  tcp4   *:6803                *:*
>> wjw      ceph-osd   13193 12 stream
>> /usr/srcs/Ceph/work/ceph/build/src/test/testdir/test-7202/out/osd.0.asok
>> wjw      ceph-osd   13193 22 tcp4   127.0.0.1:60710       127.0.0.1:7204
>> wjw      ceph-osd   13193 23 tcp4   127.0.0.1:30934       127.0.0.1:6808
>> wjw      ceph-osd   13193 33 tcp4   127.0.0.1:15437       127.0.0.1:6805
>> wjw      ceph-osd   13193 35 tcp4   127.0.0.1:15438       127.0.0.1:6807
>> wjw      ceph-osd   13193 46 tcp4   127.0.0.1:15439       127.0.0.1:6806
>> wjw      ceph-osd   13193 51 tcp4   127.0.0.1:15443       127.0.0.1:6809
>> wjw      ceph-osd   13193 55 tcp4   127.0.0.1:15450       127.0.0.1:6810
>> wjw      ceph-osd   13193 56 tcp4   127.0.0.1:15451       127.0.0.1:6811
>>
>> # sockstat | grep 13208
>> wjw      ceph-osd   13208 5  tcp4   *:6804                *:*
>> wjw      ceph-osd   13208 6  tcp4   *:6805                *:*
>> wjw      ceph-osd   13208 7  tcp4   *:6806                *:*
>> wjw      ceph-osd   13208 8  tcp4   *:6807                *:*
>> wjw      ceph-osd   13208 12 stream
>> /usr/srcs/Ceph/work/ceph/build/src/test/testdir/test-7202/out/osd.1.asok
>> wjw      ceph-osd   13208 23 tcp4   127.0.0.1:15433      127.0.0.1:7204
>> wjw      ceph-osd   13208 37 tcp4   127.0.0.1:45954      127.0.0.1:6808
>> wjw      ceph-osd   13208 38 tcp4   127.0.0.1:6807       127.0.0.1:15438
>> wjw      ceph-osd   13208 40 tcp4   127.0.0.1:6806        127.0.0.1:15439
>> wjw      ceph-osd   13208 42 tcp4   127.0.0.1:35939      127.0.0.1:6804
>> wjw      ceph-osd   13208 43 tcp4   127.0.0.1:6804       127.0.0.1:35939
>> wjw      ceph-osd   13208 48 tcp4   127.0.0.1:15453      127.0.0.1:6810
>> wjw      ceph-osd   13208 49 tcp4   127.0.0.1:6807       127.0.0.1:15444
>> wjw      ceph-osd   13208 50 tcp4   127.0.0.1:6806       127.0.0.1:15445
>> wjw      ceph-osd   13208 52 tcp4   127.0.0.1:15449      127.0.0.1:6809
>> wjw      ceph-osd   13208 53 tcp4   127.0.0.1:15452      127.0.0.1:6811
>>
>> 2016-08-11 12:06:14.567881 b0afa80 10 osd.0.objecter tick
>> 2016-08-11 12:06:14.756007 b2fcd00 20 osd.0 175 update_osd_stat
>> osd_stat(124 GB used, 96486 MB avail, 218 GB total, peers [1,2]/[] op
>> hist [])
>> 2016-08-11 12:06:14.756027 b2fcd00  5 osd.0 178 heartbeat: osd_stat(124
>> GB used, 96486 MB avail, 218 GB total, peers [1,2]/[] op hist [])
>> 2016-08-11 12:06:14.756045 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6806/13207 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:14.756036) v2 -- ?+0 0xb74e400 con 0xb4eb3a0
>> 2016-08-11 12:06:14.756109 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6807/13207 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:14.756036) v2 -- ?+0 0xb6f9e00 con 0xb4eb480
>> 2016-08-11 12:06:14.756170 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6810/13222 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:14.756036) v2 -- ?+0 0xb6faa00 con 0xb6c02a0
>> 2016-08-11 12:06:14.756203 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6811/13222 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:14.756036) v2 -- ?+0 0xb6fb000 con 0xb6c0380
>> 2016-08-11 12:06:14.756227 b2fcd00 25 osd.0 178 heartbeat_check osd.1
>> first_tx 2016-08-11 12:01:25.367701 last_tx 2016-08-11 12:06:14.756036
>> last_rx_back 2016-08-11 12:06:11.194593 last_rx_front 2016-08-11
>> 12:06:11.194593
>> 2016-08-11 12:06:14.756251 b2fcd00 25 osd.0 178 heartbeat_check osd.2
>> first_tx 2016-08-11 12:01:27.704062 last_tx 2016-08-11 12:06:14.756036
>> last_rx_back 2016-08-11 12:06:11.194593 last_rx_front 2016-08-11
>> 12:06:11.194593
>> 2016-08-11 12:06:14.756413 b54a480  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6806/13207 125 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (2065282926 0 0) 0xb5d5200 con 0xb4eb3a0
>> 2016-08-11 12:06:14.756456 b54a480 25 osd.0 178 handle_osd_ping got
>> reply from osd.1 first_tx 2016-08-11 12:01:25.367701 last_tx 2016-08-11
>> 12:06:14.756036 last_rx_back 2016-08-11 12:06:11.194593 -> 2016-08-11
>> 12:06:14.756036 last_rx_front 2016-08-11 12:06:11.194593
>> 2016-08-11 12:06:14.756500 b69c900  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6810/13222 124 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (2065282926 0 0) 0xb6a8800 con 0xb6c02a0
>> 2016-08-11 12:06:14.756539 b69c900 25 osd.0 178 handle_osd_ping got
>> reply from osd.2 first_tx 2016-08-11 12:01:27.704062 last_tx 2016-08-11
>> 12:06:14.756036 last_rx_back 2016-08-11 12:06:11.194593 -> 2016-08-11
>> 12:06:14.756036 last_rx_front 2016-08-11 12:06:11.194593
>> 2016-08-11 12:06:14.756548 b54a480  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6806/13207 126 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (936251703 0 0) 0xb5d5200 con 0xb4eb3a0
>> 2016-08-11 12:06:14.756579 b54a000  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6807/13207 125 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (2065282926 0 0) 0xb5d5400 con 0xb4eb480
>> 2016-08-11 12:06:14.756599 b54a480 10 osd.0 178 handle_osd_ping osd.1
>> 127.0.0.1:6806/13207 says i am down in 178
>> 2016-08-11 12:06:14.756659 b69c480  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6811/13222 124 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (2065282926 0 0) 0xb6ab200 con 0xb6c0380
>> 2016-08-11 12:06:14.756701 b54a000 25 osd.0 178 handle_osd_ping got
>> reply from osd.1 first_tx 2016-08-11 12:01:25.367701 last_tx 2016-08-11
>> 12:06:14.756036 last_rx_back 2016-08-11 12:06:14.756036 last_rx_front
>> 2016-08-11 12:06:11.194593 -> 2016-08-11 12:06:14.756036
>> 2016-08-11 12:06:14.756718 b69c900  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6810/13222 125 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (936251703 0 0) 0xb6a8800 con 0xb6c02a0
>> 2016-08-11 12:06:14.756752 b69c480 25 osd.0 178 handle_osd_ping got
>> reply from osd.2 first_tx 2016-08-11 12:01:27.704062 last_tx 2016-08-11
>> 12:06:14.756036 last_rx_back 2016-08-11 12:06:14.756036 last_rx_front
>> 2016-08-11 12:06:11.194593 -> 2016-08-11 12:06:14.756036
>> 2016-08-11 12:06:14.756786 b54a000  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6807/13207 126 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (936251703 0 0) 0xb5d5400 con 0xb4eb480
>> 2016-08-11 12:06:14.756810 b69c900 10 osd.0 178 handle_osd_ping osd.2
>> 127.0.0.1:6810/13222 says i am down in 178
>> 2016-08-11 12:06:14.756835 b69c480  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6811/13222 125 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:14.756036) v2 ==== 47+0+0 (936251703 0 0) 0xb6ab200 con 0xb6c0380
>> 2016-08-11 12:06:14.756859 b54a000 10 osd.0 178 handle_osd_ping osd.1
>> 127.0.0.1:6807/13207 says i am down in 178
>> 2016-08-11 12:06:14.756889 b69c480 10 osd.0 178 handle_osd_ping osd.2
>> 127.0.0.1:6811/13222 says i am down in 178
>> 2016-08-11 12:06:16.472456 b2fcd00 20 osd.0 175 update_osd_stat
>> osd_stat(124 GB used, 96486 MB avail, 218 GB total, peers [1,2]/[] op
>> hist [])
>> 2016-08-11 12:06:16.472484 b2fcd00  5 osd.0 178 heartbeat: osd_stat(124
>> GB used, 96486 MB avail, 218 GB total, peers [1,2]/[] op hist [])
>> 2016-08-11 12:06:16.472504 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6806/13207 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:16.472495) v2 -- ?+0 0xb6f8c00 con 0xb4eb3a0
>> 2016-08-11 12:06:16.472543 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6807/13207 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:16.472495) v2 -- ?+0 0xb6fb800 con 0xb4eb480
>> 2016-08-11 12:06:16.472569 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6810/13222 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:16.472495) v2 -- ?+0 0xb6fa200 con 0xb6c02a0
>> 2016-08-11 12:06:16.472649 b2fcd00  1 -- 127.0.0.1:0/13192 -->
>> 127.0.0.1:6811/13222 -- osd_ping(ping e175 stamp 2016-08-11
>> 12:06:16.472495) v2 -- ?+0 0xb6fac00 con 0xb6c0380
>> 2016-08-11 12:06:16.472700 b2fcd00 25 osd.0 178 heartbeat_check osd.1
>> first_tx 2016-08-11 12:01:25.367701 last_tx 2016-08-11 12:06:16.472495
>> last_rx_back 2016-08-11 12:06:14.756036 last_rx_front 2016-08-11
>> 12:06:14.756036
>> 2016-08-11 12:06:16.472735 b2fcd00 25 osd.0 178 heartbeat_check osd.2
>> first_tx 2016-08-11 12:01:27.704062 last_tx 2016-08-11 12:06:16.472495
>> last_rx_back 2016-08-11 12:06:14.756036 last_rx_front 2016-08-11
>> 12:06:14.756036
>> 2016-08-11 12:06:16.472852 b54a480  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6806/13207 127 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (2323295095 0 0) 0xb5d5200 con 0xb4eb3a0
>> 2016-08-11 12:06:16.472924 b54a480 25 osd.0 178 handle_osd_ping got
>> reply from osd.1 first_tx 2016-08-11 12:01:25.367701 last_tx 2016-08-11
>> 12:06:16.472495 last_rx_back 2016-08-11 12:06:14.756036 -> 2016-08-11
>> 12:06:16.472495 last_rx_front 2016-08-11 12:06:14.756036
>> 2016-08-11 12:06:16.472936 b54a000  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6807/13207 127 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (2323295095 0 0) 0xb5d5400 con 0xb4eb480
>> 2016-08-11 12:06:16.472987 b69c900  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6810/13222 126 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (2323295095 0 0) 0xb6a8800 con 0xb6c02a0
>> 2016-08-11 12:06:16.472995 b54a000 25 osd.0 178 handle_osd_ping got
>> reply from osd.1 first_tx 2016-08-11 12:01:25.367701 last_tx 2016-08-11
>> 12:06:16.472495 last_rx_back 2016-08-11 12:06:16.472495 last_rx_front
>> 2016-08-11 12:06:14.756036 -> 2016-08-11 12:06:16.472495
>> 2016-08-11 12:06:16.473030 b54a480  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6806/13207 128 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (3333229870 0 0) 0xb5d5200 con 0xb4eb3a0
>> 2016-08-11 12:06:16.473095 b54a000  1 -- 127.0.0.1:0/13192 <== osd.1
>> 127.0.0.1:6807/13207 128 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (3333229870 0 0) 0xb5d5400 con 0xb4eb480
>> 2016-08-11 12:06:16.473103 b69c900 25 osd.0 178 handle_osd_ping got
>> reply from osd.2 first_tx 2016-08-11 12:01:27.704062 last_tx 2016-08-11
>> 12:06:16.472495 last_rx_back 2016-08-11 12:06:14.756036 -> 2016-08-11
>> 12:06:16.472495 last_rx_front 2016-08-11 12:06:14.756036
>> 2016-08-11 12:06:16.473119 b69c480  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6811/13222 126 ==== osd_ping(ping_reply e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (2323295095 0 0) 0xb6ab200 con 0xb6c0380
>> 2016-08-11 12:06:16.473164 b69c480 25 osd.0 178 handle_osd_ping got
>> reply from osd.2 first_tx 2016-08-11 12:01:27.704062 last_tx 2016-08-11
>> 12:06:16.472495 last_rx_back 2016-08-11 12:06:16.472495 last_rx_front
>> 2016-08-11 12:06:14.756036 -> 2016-08-11 12:06:16.472495
>> 2016-08-11 12:06:16.473189 b69c900  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6810/13222 127 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (3333229870 0 0) 0xb6a8800 con 0xb6c02a0
>> 2016-08-11 12:06:16.473206 b54a000 10 osd.0 178 handle_osd_ping osd.1
>> 127.0.0.1:6807/13207 says i am down in 178
>> 2016-08-11 12:06:16.473240 b54a480 10 osd.0 178 handle_osd_ping osd.1
>> 127.0.0.1:6806/13207 says i am down in 178
>> 2016-08-11 12:06:16.473273 b69c900 10 osd.0 178 handle_osd_ping osd.2
>> 127.0.0.1:6810/13222 says i am down in 178
>> 2016-08-11 12:06:16.473286 b69c480  1 -- 127.0.0.1:0/13192 <== osd.2
>> 127.0.0.1:6811/13222 127 ==== osd_ping(you_died e178 stamp 2016-08-11
>> 12:06:16.472495) v2 ==== 47+0+0 (3333229870 0 0) 0xb6ab200 con 0xb6c0380
>> 2016-08-11 12:06:16.473351 b69c480 10 osd.0 178 handle_osd_ping osd.2
>> 127.0.0.1:6811/13222 says i am down in 178
>> 2016-08-11 12:06:17.050885 b2f8400 10 monclient: tick
>> 2016-08-11 12:06:17.050921 b2f8400 10 monclient: _check_auth_rotating
>> have uptodate secrets (they expire after 2016-08-11 12:05:47.050916)
>> 2016-08-11 12:06:18.020807 b267600 20
>> filestore(/usr/srcs/Ceph/work/ceph/build/src/test/testdir/test-7202/dev/osd0)
>> sync_entry woke after 5.173601
>> 2016-08-11 12:06:18.020836 b267600 10 journal commit_start
>> max_applied_seq 633, open_ops 0
>> 2016-08-11 12:06:18.020841 b267600 10 journal commit_start blocked, all
>> open_ops have completed
>> 2016-08-11 12:06:18.020845 b267600 10 journal commit_start nothing to do
>> 2016-08-11 12:06:18.020850 b267600 10 journal commit_start
>> 2016-08-11 12:06:18.020865 b267600 20
>> filestore(/usr/srcs/Ceph/work/ceph/build/src/test/testdir/test-7202/dev/osd0)
>> sync_entry waiting for max_interval 5.000000
>> 2016-08-11 12:06:19.582028 b0afa80 10 osd.0.objecter tick
>>

