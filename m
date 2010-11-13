From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: How can I change max_mds on v0.23?
Date: Sun, 14 Nov 2010 00:57:20 +0900
Message-ID: <7F0CB039-816F-4252-9961-EF638EC40286@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39693 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab0KMP50 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Nov 2010 10:57:26 -0500
Received: by pzk28 with SMTP id 28so743962pzk.19
        for <ceph-devel@vger.kernel.org>; Sat, 13 Nov 2010 07:57:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi, 

I want to try out clustered MDS on v0.23. I followed the Wiki at <http://ceph.newdream.net/wiki/MDS_cluster_expansion> 
and tried to set max_mds to 2, but Ceph doesn't recognize the command. 

ceph@cepha3:~$ ceph mds set max_mds 2
2010-11-14 00:44:03.008148 mon <- [mds,set,max_mds,2]
2010-11-14 00:44:03.009006 mon0 -> 'unrecognized command' (-22)

Can anybody tell me what the right command is? 
I'm using Ceph v0.32 on Ubuntu 10.10 Server (Kernel 2.6.35).

Thanks, 
Tatsuya

--
Tatsuya Kawano (Mr.)
Tokyo, Japan

http://twitter.com/tatsuya6502

====================================================

ceph@cepha3:~$ uname -a
Linux cepha3 2.6.35-22-server #35-Ubuntu SMP Sat Oct 16 22:02:33 UTC 2010 x86_64 GNU/Linux

ceph@cepha3:~$ ceph -v
ceph version 0.23 (commit:5d1d8d0c4602be9819cc9f7aea562fccbb005a56)

ceph@cepha3:~$ ceph -s
2010-11-14 00:43:39.395309    pg v4229: 792 pgs: 792 active+clean; 1921 MB data, 4265 MB used, 57155 MB / 61420 MB avail
2010-11-14 00:43:39.402330   mds e143: 1/1/1 up {0=up:active}, 1 up:standby
2010-11-14 00:43:39.402419   osd e187: 3 osds: 3 up, 3 in -- 1 blacklisted MDSes
2010-11-14 00:43:39.402503   log 2010-11-14 00:25:22.984103 mds0 172.16.87.168:6800/2298 4 : [INF] closing stale session client5503 172.16.87.169:0/1980987884 after 2010-11-14 00:25:22.982491
2010-11-14 00:43:39.402638   mon e1: 3 mons at {0=172.16.87.168:6789/0,1=172.16.87.169:6789/0,2=172.16.87.167:6789/0}

ceph@cepha3:~$ ceph mds dump -o -
2010-11-14 00:43:48.330087 mon <- [mds,dump]
2010-11-14 00:43:48.331066 mon2 -> 'dumped mdsmap epoch 143' (0)
epoch 143

client_epoch 0
created 2010-10-31 22:21:38.794952
modified 2010-11-14 00:25:17.093509
tableserver 0
root 0
session_timeout 60
session_autoclose 300
last_failure 140
last_failure_osd_epoch187

compat	compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate objec}

max_mds	1
in	0
up	{0=5697}
failed	
stopped	
5697:	172.16.87.168:6800/2298 '0' mds0.41 up:active seq 21
5699:	172.16.87.169:6800/2364 '1' mds-1.0 up:standby seq 2

2010-11-14 00:43:48.331143 wrote 507 byte payload to -

ceph@cepha3:~$ ceph mds stat
2010-11-14 00:43:53.832243 mon <- [mds,stat]
2010-11-14 00:43:53.834192 mon0 -> 'e143: 1/1/1 up {0=up:active}, 1 up:standby' (0)

ceph@cepha3:~$ ceph mds set max_mds 2
2010-11-14 00:44:03.008148 mon <- [mds,set,max_mds,2]
2010-11-14 00:44:03.009006 mon0 -> 'unrecognized command' (-22)

====================================================



