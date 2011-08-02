From: Fyodor Ustinov <ufm@ufm.su>
Subject: Strange.
Date: Tue, 02 Aug 2011 11:19:46 +0300
Message-ID: <4E37B322.6040301@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:39571 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab1HBITu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Aug 2011 04:19:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 1A197600248
	for <ceph-devel@vger.kernel.org>; Tue,  2 Aug 2011 11:19:48 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRxYUjN61OGh for <ceph-devel@vger.kernel.org>;
	Tue,  2 Aug 2011 11:19:48 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id EB519600247
	for <ceph-devel@vger.kernel.org>; Tue,  2 Aug 2011 11:19:47 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I'm not sure that makes sense with errors on ext4 complain about errors 
in ceph.fs, but maybe it will be interesting:

root@stb1:/mnt/dcvolia/amanda# rm -rf *
rm: cannot remove `state/servers/index/butan.dcv/_': Directory not empty
rm: cannot remove `state/servers/index/iprit.dcv/_': Directory not empty
rm: cannot remove `state/servers/index/mail.naperehresti.info/_usr': 
Directory not empty
rm: cannot remove `state/servers/index/ns4.dc.volia.com/_': Directory 
not empty
rm: cannot remove `state/servers/index/ticket.dcv/_': Directory not empty
rm: cannot remove `state/servers/index/tmg.net.ua/_': Directory not empty
rm: cannot remove `state/servers/index/zoman.dcv/_': Directory not empty

and got in mds:


2011-08-02 11:04:52.046169    pg v540175: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:46.433515 mds0 
10.5.51.230:6801/23145 10 : [ERR] unmatched fragstat size on single 
dirfrag 609, inode has f(v3 m2011-08-02 11:04:46.433412 2=2+0), dirfrag 
has f(v3 m2011-08-02 11:04:46.433412 1=1+0)
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:46.433555 mds0 
10.5.51.230:6801/23145 11 : [ERR] unmatched rstat rbytes on single 
dirfrag 609, inode has n(v7 rc2011-08-02 11:04:46.433412 b43119 2=2+0), 
dirfrag has n(v7 rc2011-08-02 11:04:46.433412 b40923 1=1+0)
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:52.225521 mds0 
10.5.51.230:6801/23145 12 : [ERR] rfiles underflow -1 on [inode 
10000000444 [...2,head] /dcvolia/amanda/state/servers/index/butan.dcv/ 
auth v4244 pv4303 ap=1+0 f(v7 m2011-06-09 03:27:48.159602 1=0+1) n(v79 
rc2011-07-18 00:10:13.483555 b748540 39=37+2) (inest lock->sync w=1 
dirty) (iversion lock) caps={4525=pAsLsXsFs/-@0,5107=pAsLsXs/p@4} | 
dirtyscattered lock dirfrag caps authpin 0xbac78c0]
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:52.225868 mds0 
10.5.51.230:6801/23145 13 : [ERR] rfiles underflow -1 on [inode 
10000000446 [...2,head] /dcvolia/amanda/state/servers/index/iprit.dcv/ 
auth v4246 pv4305 ap=1+0 f(v7 m2011-06-09 03:27:48.170333 1=0+1) n(v85 
rc2011-07-18 00:10:41.619778 b727904 39=37+2) (inest lock->sync w=1 
dirty) (iversion lock) caps={4525=pAsLsXsFs/-@0,5107=pAsLsXs/p@4} | 
dirtyscattered lock dirfrag caps authpin 0xbac9a40]
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:52.226004 mds0 
10.5.51.230:6801/23145 14 : [ERR] rfiles underflow -1 on [inode 
1000000042f [...2,head] 
/dcvolia/amanda/state/servers/index/mail.naperehresti.info/ auth v4286 
pv4307 ap=1+0 f(v7 m2011-08-02 11:04:46.712436 1=0+1) n(v297 
rc2011-08-02 11:04:46.712436 1=-1+2) (inest lock->sync w=1 dirty) 
(iversion lock) caps={4525=pAsLsXs/-@1,5107=pAsLsXs/p@10} | 
dirtyscattered lock dirfrag caps dirty authpin 0xbaca2a0]
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:52.226170 mds0 
10.5.51.230:6801/23145 15 : [ERR] rfiles underflow -1 on [inode 
10000000358 [...2,head] 
/dcvolia/amanda/state/servers/index/ns4.dc.volia.com/ auth v4238 pv4309 
ap=1+0 f(v5 m2011-06-20 00:05:09.195242 1=0+1) n(v77 rc2011-07-18 
00:06:13.112554 b2354733 28=26+2) (inest lock->sync w=1 dirty) (iversion 
lock) caps={4525=pAsLsXsFs/-@0,5107=pAsLsXs/p@4} | dirtyscattered lock 
dirfrag caps authpin 0xbacab00]
2011-08-02 11:04:52.408819   log 2011-08-02 11:04:52.226307 mds0 
10.5.51.230:6801/23145 16 : [ERR] rfiles underflow -1 on [inode 
10000000438 [...2,head] /dcvolia/amanda/state/servers/index/ticket.dcv/ 
auth v4148 pv4311 ap=1+0 f(v8 m2011-06-09 03:27:48.035056 1=0+1) n(v104 
rc2011-07-16 00:18:38.420661 b2372408 38=36+2) (inest lock->sync w=1 
dirty) (iversion lock) caps={4525=pAsLsXsFs/-@0,5107=pAsLsXs/p@4} | 
dirtyscattered lock dirfrag caps authpin 0xbacb360]
2011-08-02 11:04:53.050029    pg v540176: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:04:57.046842    pg v540177: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:04:58.050471    pg v540178: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:04:59.053677    pg v540179: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:05:00.298567    pg v540180: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:05:02.408930   log 2011-08-02 11:04:57.225360 mds0 
10.5.51.230:6801/23145 17 : [ERR] rfiles underflow -1 on [inode 
1000000042d [...2,head] /dcvolia/amanda/state/servers/index/tmg.net.ua/ 
auth v4200 pv4319 ap=1+0 f(v7 m2011-06-09 03:27:47.988225 1=0+1) n(v121 
rc2011-07-17 00:05:13.012245 b7548498 38=36+2) (inest lock->sync w=1 
dirty) (iversion lock) caps={4525=pAsLsXsFs/-@0,5107=pAsLsXs/p@4} | 
dirtyscattered lock dirfrag caps authpin 0xbacbbc0]
2011-08-02 11:05:02.408930   log 2011-08-02 11:04:57.225726 mds0 
10.5.51.230:6801/23145 18 : [ERR] rfiles underflow -1 on [inode 
1000000043e [...2,head] /dcvolia/amanda/state/servers/index/zoman.dcv/ 
auth v4240 pv4321 ap=1+0 f(v7 m2011-06-09 03:27:48.130542 1=0+1) n(v82 
rc2011-07-18 00:07:40.208712 b721925 39=37+2) (inest lock->sync w=1 
dirty) (iversion lock) caps={4525=pAsLsXsFs/-@0,5107=pAsLsXs/p@4} | 
dirtyscattered lock dirfrag caps authpin 0xbacdd40]
2011-08-02 11:05:05.299638    pg v540181: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:05:10.303368    pg v540182: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:05:15.302671    pg v540183: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:05:18.423366    pg v540184: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:05:20.303675    pg v540185: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:06:02.994535    pg v540186: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail
2011-08-02 11:06:57.057322    pg v540187: 2376 pgs: 2376 active+clean; 
8432 GB data, 16884 GB used, 30847 GB / 49027 GB avail

root@stb1:/mnt/dcvolia/amanda# ls -al state/servers/index/butan.dcv/_/
total 0
drwxr-xr-x 1 1002 disk 0 2011-08-02 11:04 .
drwxr-xr-x 1 1002 disk 0 2011-06-09 03:27 ..
root@stb1:/mnt/dcvolia/amanda#

root@stb1:/mnt/dcvolia/amanda# cd ..
root@stb1:/mnt/dcvolia# ls -alh
total 0
drwxr-xr-x 1 root root 7.3T 2011-07-09 14:50 .
drwxrwxrwx 1 root root 7.3T 2011-08-02 11:04 ..
drwxr-xr-x 1 1002 disk  16E 2011-08-02 11:05 amanda
drwxr-xr-x 1  107  115 222G 2011-08-02 01:32 bacula
drwxrwxrwx 1 root root    0 2011-06-18 18:22 hvds
drwxrwxrwx 1 root root 7.1T 2011-08-02 08:25 noc
root@stb1:/mnt/dcvolia#

I think it is time to make fsck.ceph

WBR,
     Fyodor.

