From: Fred Ar <ar.fred@yahoo.com>
Subject: phantom MDS, blacklisted OSDs?
Date: Thu, 20 May 2010 08:45:06 -0700 (PDT)
Message-ID: <879378.31395.qm@web114302.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from n4.bullet.mail.gq1.yahoo.com ([67.195.9.84]:22176 "HELO
	n4.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752146Ab0ETPpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 May 2010 11:45:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

today I noticed some strange things on my 3 machines with each 1 hard disk, 1 osd, 1 mds, 1 mon. They are named r1-9, r1-10, r1-11.

In the output of "ceph mds dump" (full output below), in see some phantom mds:
7101: 192.168.20.11:6800/885 'r1-11' mds0.20 up:active seq 17
7103: 192.168.20.10:6800/883 'r1-10' mds1.1 up:creating seq 177
7106: 192.168.20.9:6800/1000 'r1-9' mds2.1 up:creating seq 411
4900: 192.168.20.10:6800/3839 'r1-10' mds-1.0 up:standby seq 2 laggy 
since 
10.05.19 21:31:15.767477
4997: 192.168.20.9:6800/5582 'r1-9' mds-1.0 up:standby seq 2 laggy since 
10.05.19 21:30:40.740993
6199: 192.168.20.11:6800/7362 'r1-11' mds-1.0 up:standby seq 2 laggy 
since 
10.05.19 23:02:58.674823
6401: 192.168.20.11:6800/8077 'r1-11' mds-1.0 up:standby seq 2 laggy 
since 
10.05.19 23:04:03.133329
6499: 192.168.20.11:6800/9613 'r1-11' mds-1.0 up:standby seq 2 laggy 
since 
10.05.19 23:11:06.451788
6599: 192.168.20.11:6800/9072 'r1-11' mds-1.0 up:standby seq 2 laggy 
since 
10.05.19 23:10:51.414007

why do r1-9 and r1-10 appear twice, and why does r1-11 appear 5 times? Is it a problem, how to fix it ?

I also had a 2 blacklisted OSDs (out of 3). Could it be because I restarted them many times in a row? How to clear the blacklisted status by hand (if I don't want to wait the delay)?

Thanks, Fred

full output of ceph mds dump:
epoch 80

client_epoch 0
created 10.05.18 15:54:19.197481
modified 10.05.20 12:22:42.325069
tableserver 0
root 0
session_timeout 60
session_autoclose 300

compat compat={},rocompat={},incompat={1=base v0.20}

max_mds 3
in <0,1,2>
up <{0=7101,1=7103,2=7106}>
failed <>
stopped <>
7101: 192.168.20.11:6800/885 'r1-11' mds0.20 up:active seq 17
7103: 192.168.20.10:6800/883 'r1-10' mds1.1 up:creating seq 177
7106: 192.168.20.9:6800/1000 'r1-9' mds2.1 up:creating seq 411
4900: 192.168.20.10:6800/3839 'r1-10' mds-1.0 up:standby seq 2 laggy since 
10.05.19 21:31:15.767477
4997: 192.168.20.9:6800/5582 'r1-9' mds-1.0 up:standby seq 2 laggy since 
10.05.19 21:30:40.740993
6199: 192.168.20.11:6800/7362 'r1-11' mds-1.0 up:standby seq 2 laggy since 
10.05.19 23:02:58.674823
6401: 192.168.20.11:6800/8077 'r1-11' mds-1.0 up:standby seq 2 laggy since 
10.05.19 23:04:03.133329
6499: 192.168.20.11:6800/9613 'r1-11' mds-1.0 up:standby seq 2 laggy since 
10.05.19 23:11:06.451788
6599: 192.168.20.11:6800/9072 'r1-11' mds-1.0 up:standby seq 2 laggy since 
10.05.19 23:10:51.414007


      

