From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Redundancy when mount with multiple mon IP
Date: Mon, 26 Nov 2012 01:30:25 +0800
Message-ID: <CAJiejCT-BvsgnwB_HYp31DFqjwdaCWsWfhCSQOgrwLNfO37emA@mail.gmail.com>
References: <CAJiejCRq2wcRVivDpXDGcQ4t5r=3ZM8-ywVh0EiuPdS+nuDqRg@mail.gmail.com>
 <alpine.DEB.2.00.1211250826370.23552@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40889 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2KYRap (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 12:30:45 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so7488897iay.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 09:30:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211250826370.23552@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/11/26 Sage Weil <sage@inktank.com>:
> On Sun, 25 Nov 2012, Drunkard Zhang wrote:
>> I'm using ceph-0.51. I setup 3 monitors. then mount with 3 mon IP at
>> another host with either kernel mode or fuse, neither give me
>> redundancy.
>>
>> Here's commands I used at client (IP: 10.0.0.2) side;
>> mount -t ceph log3,log21,squid86-log12:/ /mnt/bc
>> ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
>>
>> When mounted, read/write is OK, then add a iptables rule at log3 to
>> REJECT/DROP packets from client 10.0.0.2, operation at client stuck
>> due to IO problem.
>>
>> Related stuck processes on client look like this:
>> log1 ~ # ps auwx |g bc
>> root      1325  0.0  0.0 120100  3536 pts/0    Sl   23:10   0:00
>> ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
>> root      1404  0.0  0.0  16192   700 pts/0    S    23:10   0:00 ls
>> --color=auto /mnt/bc
>
> Can you repeat teh test with '--debug-monc 20 --debug-ms 1 --log-file /tmp/foo'
> on the command line and attach the resulting log?
>
> Thanks!
> sage
>
Thanks for the hint, I think the problem found, I rejected the client
at mon.log3 which also acts as mds, and it's up and active, another
mds is up and standby. So the client cannot connect to mds server? Is
it possible to get more than one mds up and active simultaneously, and
let client know that?

2012-11-26 00:56:43.025440 7f1b1a4ae780 10 monclient(hunting):
build_initial_monmap
2012-11-26 00:56:43.037276 7f1b1a4ae780  1 -- :/0 messenger.start
2012-11-26 00:56:43.037439 7f1b1a4ae780 10 monclient(hunting): init
auth_supported none
2012-11-26 00:56:43.037627 7f1b1a4ae780 10 monclient(hunting): auth_supported 1
2012-11-26 00:56:43.037779 7f1b1a4ae780 10 monclient(hunting): renew_subs
2012-11-26 00:56:43.037782 7f1b1a4ae780 10 monclient(hunting): _reopen_session
2012-11-26 00:56:43.037880 7f1b1a4ae780 10 monclient(hunting):
_pick_new_mon picked mon.noname-a con 0x242c640 addr
10.205.118.21:6789/0
2012-11-26 00:56:43.037970 7f1b1a4ae780 10 monclient(hunting):
_send_mon_message to mon.noname-a at 10.205.118.21:6789/0
2012-11-26 00:56:43.037976 7f1b1a4ae780  1 -- :/12486 -->
10.205.118.21:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x2418000 con 0x242c640
2012-11-26 00:56:43.037989 7f1b1a4ae780 10 monclient(hunting): renew_subs
2012-11-26 00:56:43.038073 7f1b1a4ae780 10 monclient(hunting):
authenticate will time out at 2012-11-26 00:57:13.038071
2012-11-26 00:56:43.038914 7f1b1a4aa700  1 -- 10.205.119.1:0/12486
learned my addr 10.205.119.1:0/12486
2012-11-26 00:56:43.040421 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mon.0 10.205.118.21:6789/0 1 ==== mon_map v1 ==== 492+0+0 (1771770514
0 0) 0x2444000 con 0x242c640
2012-11-26 00:56:43.040462 7f1b15660700 10 monclient(hunting):
handle_monmap mon_map v1
2012-11-26 00:56:43.040486 7f1b15660700 10 monclient(hunting):  got
monmap 1, mon.noname-a is now rank -1
2012-11-26 00:56:43.040506 7f1b15660700 10 monclient(hunting): dump:
epoch 1
fsid 2b7817f5-6cc3-4813-af1d-2ea596e40060
last_changed 2012-11-24 21:15:43.039206
created 2012-11-24 21:15:43.039206
0: 10.205.118.21:6789/0 mon.log21
1: 10.205.119.2:6789/0 mon.log3
2: 150.164.100.218:6789/0 mon.squid86-log12

2012-11-26 00:56:43.040555 7f1b15660700  1 monclient(hunting): found mon.log21
2012-11-26 00:56:43.040565 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mon.0 10.205.118.21:6789/0 2 ==== auth_reply(proto 1 0 Success) v1
==== 24+0+0 (3280302652 0 0) 0x2418600 con 0x242c640
2012-11-26 00:56:43.040588 7f1b15660700 10 monclient: my global_id is 6567
2012-11-26 00:56:43.040597 7f1b15660700 10 monclient:
_send_mon_message to mon.log21 at 10.205.118.21:6789/0
2012-11-26 00:56:43.040600 7f1b15660700  1 -- 10.205.119.1:0/12486 -->
10.205.118.21:6789/0 -- mon_subscribe({osdmap=0}) v2 -- ?+0 0x2442000
con 0x242c640
2012-11-26 00:56:43.040619 7f1b15660700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:56:43.040628 7f1b1a4ae780  5 monclient: authenticate
success, global_id 6567
2012-11-26 00:56:43.043257 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mon.0 10.205.118.21:6789/0 3 ==== osd_map(457..457 src has 1..457) v3
==== 24079+0+0 (111679678 0 0) 0x2418400 con 0x242c640
2012-11-26 00:56:46.037806 7f1b14e5f700 10 monclient: tick
2012-11-26 00:56:46.037828 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:56:46.037832 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:56:46.037831; renew after: 0.000000) -- yes
2012-11-26 00:56:46.037852 7f1b14e5f700 10 monclient: renew_subs
2012-11-26 00:56:46.037859 7f1b14e5f700 10 monclient:
_send_mon_message to mon.log21 at 10.205.118.21:6789/0
2012-11-26 00:56:46.037886 7f1b14e5f700  1 -- 10.205.119.1:0/12486 -->
10.205.118.21:6789/0 -- mon_subscribe({mdsmap=0+,monmap=2+}) v2 -- ?+0
0x24421c0 con 0x242c640
2012-11-26 00:56:46.180696 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mon.0 10.205.118.21:6789/0 4 ==== mdsmap(e 17) v1 ==== 740+0+0
(3013025268 0 0) 0x2418800 con 0x242c640
2012-11-26 00:56:46.180800 7f1b1a4ae780  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_open) v1 -- ?+0
0x24421c0
2012-11-26 00:56:46.181189 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mon.0 10.205.118.21:6789/0 5 ==== mon_subscribe_ack(300s) v1 ====
20+0+0 (943222172 0 0) 0x242e1a0 con 0x242c640
2012-11-26 00:56:46.181203 7f1b15660700 10 monclient:
handle_subscribe_ack sent 2012-11-26 00:56:43.037990 renew after
2012-11-26 00:59:13.037990
2012-11-26 00:56:46.193020 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 1 ==== client_session(open) v1 ====
28+0+0 (2719320884 0 0) 0x24421c0 con 0x242c3c0
2012-11-26 00:56:46.193047 7f1b15660700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
1) v1 -- ?+0 0x2442380
2012-11-26 00:56:46.193100 7f1b1a4ae780  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_request(client.6567:1 getattr
pAsLsXsFs #1) v1 -- ?+0 0x245a000
2012-11-26 00:56:46.193720 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 2 ==== client_session(renewcaps seq 1) v1
==== 28+0+0 (2614397064 0 0) 0x2442380 con 0x242c3c0
2012-11-26 00:56:46.193786 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 3 ==== client_reply(???:1 = 0 Success) v1
==== 316+0+0 (2489180344 0 0) 0x24482c0 con 0x242c3c0
2012-11-26 00:56:47.041513 7f1b16662700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
2) v1 -- ?+0 0x2442540
2012-11-26 00:56:47.042256 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 4 ==== client_session(renewcaps seq 2) v1
==== 28+0+0 (1357429227 0 0) 0x2442540 con 0x242c3c0
2012-11-26 00:56:56.038149 7f1b14e5f700 10 monclient: tick
2012-11-26 00:56:56.038173 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:56:56.038176 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:56:56.038176; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:57:06.038413 7f1b14e5f700 10 monclient: tick
2012-11-26 00:57:06.038425 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:57:06.038450 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:57:06.038450; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:57:07.045087 7f1b16662700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
3) v1 -- ?+0 0x2442380
2012-11-26 00:57:07.045797 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 5 ==== client_session(renewcaps seq 3) v1
==== 28+0+0 (3936844645 0 0) 0x2442380 con 0x242c3c0
2012-11-26 00:57:12.088123 7f1b1a4ae780  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_request(client.6567:2 readdir
#1) v1 -- ?+0 0x245a500
2012-11-26 00:57:12.089168 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 6 ==== client_reply(???:2 = 0 Success) v1
==== 590+0+0 (1000940779 0 0) 0x2448840 con 0x242c3c0
2012-11-26 00:57:16.038723 7f1b14e5f700 10 monclient: tick
2012-11-26 00:57:16.038735 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:57:16.038738 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:57:16.038738; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:57:26.038943 7f1b14e5f700 10 monclient: tick
2012-11-26 00:57:26.038955 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:57:26.038958 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:57:26.038958; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:57:27.048330 7f1b16662700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
4) v1 -- ?+0 0x24421c0
2012-11-26 00:57:32.058612 7f1b1a4ae780  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_request(client.6567:3 readdir
#1000000029e) v1 -- ?+0 0x245a500
2012-11-26 00:57:36.039248 7f1b14e5f700 10 monclient: tick
2012-11-26 00:57:36.039261 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:57:36.039264 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:57:36.039264; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:57:46.039479 7f1b14e5f700 10 monclient: tick
2012-11-26 00:57:46.039507 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:57:46.039509 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:57:46.039509; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:57:47.052152 7f1b16662700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
5) v1 -- ?+0 0x24428c0
2012-11-26 00:57:56.039744 7f1b14e5f700 10 monclient: tick
2012-11-26 00:57:56.039772 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:57:56.039775 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:57:56.039775; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:58:06.039992 7f1b14e5f700 10 monclient: tick
2012-11-26 00:58:06.040015 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:58:06.040024 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:58:06.040023; renew after: 2012-11-26
00:59:13.037990) -- no
2012-11-26 00:58:07.056578 7f1b16662700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
6) v1 -- ?+0 0x2442700
2012-11-26 00:58:09.074064 7f1b15660700  1 -- 10.205.119.1:0/12486 <==
mds.0 10.205.119.2:6800/5023 7 ==== client_session(stale) v1 ====
28+0+0 (3259605419 0 0) 0x2442c40 con 0x242c3c0
2012-11-26 00:58:09.074105 7f1b15660700  1 -- 10.205.119.1:0/12486 -->
mds.0 10.205.119.2:6800/5023 -- client_session(request_renewcaps seq
7) v1 -- ?+0 0x2442380
2012-11-26 00:58:16.040228 7f1b14e5f700 10 monclient: tick
2012-11-26 00:58:16.040240 7f1b14e5f700 20 monclient:
_check_auth_rotating not needed by client.admin
2012-11-26 00:58:16.040242 7f1b14e5f700 10 monclient: renew subs?
(now: 2012-11-26 00:58:16.040242; renew after: 2012-11-26
00:59:13.037990) -- no
[Repeated sections snipped]
