From: Almond <almond1778@gmail.com>
Subject: questions about monmap and command
Date: Wed, 1 Jun 2011 16:01:29 +0800
Message-ID: <BANLkTimoMQEKLRFOonKDvaBLYNMcfsSU+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42840 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929Ab1FAIB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 04:01:29 -0400
Received: by pwi15 with SMTP id 15so2433222pwi.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 01:01:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

I have 2 questions about monitor.
The test environment contains 3 mon(mona<--leader, monb and monc), 2
mds ,11 osd and ceph v0.26 .

(1)
I killed the cmon process on mona.
Both log and 'ceph mon stat' showed the latest mon's stat(mon.b@1 won
leader election with quorum 1,2).

Then I dump monmap to check, but it didn't record the latest mons' state.
Can someone tell me what the purpose of monmap is?

root@MON2:/mnt/ext4/monb/monmap# ceph mon getmap -o lmonmpa
2011-06-01 07:17:35.669787 mon <- [mon,getmap]
2011-06-01 07:17:35.670964 mon1 -> 'got latest monmap' (0)
2011-06-01 07:17:35.671058 7fa86a776720  wrote 465 byte payload to lmonmpa
root@MON2:/mnt/ext4/monb/monmap# monmaptool --print lmonmpa
monmaptool: monmap file lmonmpa
epoch 1
fsid 73277084-b580-e4f8-da6d-3179bd7a0f0b
last_changed 2011-05-11 11:16:28.730170
created 2011-05-11 11:16:28.730170
0: 192.168.200.181:6789/0 mon.a
1: 192.168.200.182:6789/0 mon.b
2: 192.168.200.183:6789/0 mon.c

(2)
root@MON2:/var/log/ceph# ceph mon stat
2011-06-01 07:21:39.228470 7f3aab8c4710 -- 192.168.200.182:0/14828 >>
192.168.200.181:6789/0 pipe(0x1a70d60 sd=5 pgs=0 cs=0 l=0).fault first
fault
2011-06-01 07:21:45.230389 mon <- [mon,stat]
2011-06-01 07:21:45.230988 mon1 -> 'e1: 3 mons at
{a=192.168.200.181:6789/0,b=192.168.200.182:6789/0,c=192.168.200.183:6789/0},
election epoch 24, quorum 1,2' (0)
                   ^^^^^
What does (0) in the last line mean?



Thanks!
