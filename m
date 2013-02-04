From: femi anjorin <femi.anjorin@gmail.com>
Subject: Re: CEPH HEALTH NOT OK ceph version 0.56.2.!!!
Date: Mon, 4 Feb 2013 14:35:42 +0100
Message-ID: <CAPhYxPwiHp5fGCB2MQL1vtZCJk2KxhLR_MMRFBikBkMXFoVNAw@mail.gmail.com>
References: <CAPhYxPy=HqwYgZ9RfW0a9-LtDB2nTMOB33Hc6KhGcJ+zYfEmxA@mail.gmail.com>
	<510FB7C5.6020106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:43375 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3BDNfn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 08:35:43 -0500
Received: by mail-qe0-f43.google.com with SMTP id 3so2279047qeb.16
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 05:35:42 -0800 (PST)
In-Reply-To: <510FB7C5.6020106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

Here is Ceph Health Detail ....Thanks..

[root@testserver025 ~]#  ceph health detail
2013-02-04 14:33:24.874184 7f1200b65760  1 -- :/0 messenger.start
2013-02-04 14:33:24.875052 7f1200b65760  1 -- :/23252 -->
172.16.0.25:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
0x2f6eaf0 con 0x2f6e750
2013-02-04 14:33:24.875246 7f1200b63700  1 -- 172.16.0.25:0/23252
learned my addr 172.16.0.25:0/23252
2013-02-04 14:33:24.875698 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 1 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7f11e4000b10 con 0x2f6e750
2013-02-04 14:33:24.875841 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 2 ==== auth_reply(proto 2 0 Success) v1 ====
33+0+0 (1199826957 0 0) 0x7f11e4000eb0 con 0x2f6e750
2013-02-04 14:33:24.875999 7f11f3fff700  1 -- 172.16.0.25:0/23252 -->
172.16.0.25:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
0x7f11e8001620 con 0x2f6e750
2013-02-04 14:33:24.876311 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 3 ==== auth_reply(proto 2 0 Success) v1 ====
206+0+0 (3730672809 0 0) 0x7f11e4000eb0 con 0x2f6e750
2013-02-04 14:33:24.876396 7f11f3fff700  1 -- 172.16.0.25:0/23252 -->
172.16.0.25:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0
0x7f11e8003720 con 0x2f6e750
2013-02-04 14:33:24.876820 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 4 ==== auth_reply(proto 2 0 Success) v1 ====
409+0+0 (2125528276 0 0) 0x7f11e4000eb0 con 0x2f6e750
2013-02-04 14:33:24.876883 7f11f3fff700  1 -- 172.16.0.25:0/23252 -->
172.16.0.25:6789/0 -- mon_subscribe({monmap=0+}) v2 -- ?+0 0x2f6adb0
con 0x2f6e750
2013-02-04 14:33:24.876925 7f1200b65760  1 -- 172.16.0.25:0/23252 -->
172.16.0.25:6789/0 -- mon_command(health detail v 0) v1 -- ?+0
0x2f6eaf0 con 0x2f6e750
2013-02-04 14:33:24.878463 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 5 ==== mon_map v1 ==== 473+0+0 (1506918310 0
0) 0x7f11e40010e0 con 0x2f6e750
2013-02-04 14:33:24.878514 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
(3271567554 0 0) 0x7f11e40012c0 con 0x2f6e750
2013-02-04 14:33:24.878547 7f11f3fff700  1 -- 172.16.0.25:0/23252 <==
mon.0 172.16.0.25:6789/0 7 ==== mon_command_ack([health,detail]=0
HEALTH_OK v0) v1 ==== 59+0+0 (1951710637 0 0) 0x7f11e40010e0 con
0x2f6e750
HEALTH_OK
2013-02-04 14:33:24.878592 7f1200b65760  1 -- 172.16.0.25:0/23252 mark_down_all
2013-02-04 14:33:24.878914 7f1200b65760  1 -- 172.16.0.25:0/23252
shutdown complete.








On Mon, Feb 4, 2013 at 2:29 PM, Joao Eduardo Luis <joao.luis@inktank.com> wrote:
> On 02/04/2013 12:21 PM, femi anjorin wrote:
>>
>> The mon is ok
>> The mds is ok
>> The osds were properly mount by mkcephfs -mkfs
>>
>> But "ceph health" wont respond  ok !!!
>
>
> 'ceph health detail' should provide further insight to what's happening.
>
>   -Joao
>
