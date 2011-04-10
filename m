From: Fyodor Ustinov <ufm@ufm.su>
Subject: Trouble
Date: Sun, 10 Apr 2011 03:08:19 +0300
Message-ID: <4DA0F4F3.1040408@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:37350 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714Ab1DJAI0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Apr 2011 20:08:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id D09E8600238
	for <ceph-devel@vger.kernel.org>; Sun, 10 Apr 2011 03:08:20 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbmEog2xQbNT for <ceph-devel@vger.kernel.org>;
	Sun, 10 Apr 2011 03:08:20 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 5C0EB600227
	for <ceph-devel@vger.kernel.org>; Sun, 10 Apr 2011 03:08:20 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Trouble.

stb1 - ceph client (xx.xx.xx.104)
4 osd servers (stc1 - stc4, xx.xx.xx.200 - xx.xx.xx.203).
1 mon+mds server (mds1 - xx.xx.xx.199).
ceph - 0.26

New, empty fs.

root@stc1:~# ceph osd dump -o -
2011-04-09 21:12:05.365830 mon <- [osd,dump]
2011-04-09 21:12:05.366348 mon0 -> 'dumped osdmap epoch 5' (0)
epoch 5
fsid bc6102b2-46a9-8bcf-6eed-a05a8de25a2e
created 2011-04-09 21:05:28.352664
modifed 2011-04-09 21:05:41.640899
flags

pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash 
rjenkins pg_num 256 pgp_num 256 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
pg_pool 1 'metadata' pg_pool(rep pg_size 2 crush_ruleset 1 object_hash 
rjenkins pg_num 256 pgp_num 256 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
pg_pool 2 'casdata' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash 
rjenkins pg_num 256 pgp_num 256 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
pg_pool 3 'rbd' pg_pool(rep pg_size 2 crush_ruleset 3 object_hash 
rjenkins pg_num 256 pgp_num 256 lpg_num 2 lpgp_num 2 last_change 1 owner 0)

max_osd 4
osd0 up   in  weight 1 up_from 2 up_thru 4 down_at 0 last_clean_interval 
0-0 xx.xx.xx.200:6800/9065 xx.xx.xx.200:6801/9065 xx.xx.xx.200:6802/9065
osd1 up   in  weight 1 up_from 3 up_thru 4 down_at 0 last_clean_interval 
0-0 xx.xx.xx.201:6800/9153 xx.xx.xx.201:6801/9153 xx.xx.xx.201:6802/9153
osd2 up   in  weight 1 up_from 4 up_thru 4 down_at 0 last_clean_interval 
0-0 xx.xx.xx.202:6800/9915 xx.xx.xx.202:6801/9915 xx.xx.xx.202:6802/9915
osd3 up   in  weight 1 up_from 4 up_thru 4 down_at 0 last_clean_interval 
0-0 xx.xx.xx.203:6800/3325 xx.xx.xx.203:6801/3325 xx.xx.xx.203:6802/3325


root@stc1:~# rados df
pool name                 KB      objects       clones     degraded      
unfound           rd        rd KB           wr        wr KB
casdata                    0            0            0            
0           0            0            0            0            0
data                       0            0            0            
0           0            0            0            0            0
metadata                  21           21            0            
0           0           12            0           48           22
rbd                        0            0            0            
0           0            0            0            0            0
   total used          844432           21
   total avail     3624515892
   total space     3768948976

2011-04-09 21:08:21.478776    pg v94: 1056 pgs: 1056 active+clean; 21 KB 
data, 824 MB used, 3456 GB / 3594 GB avail

root@stb1:~# mount -t ceph stm1:/ /mnt

root@stb1:~# df -h /mnt
Filesystem            Size  Used Avail Use% Mounted on
xx.xx.xx.199:/      3.6T  825M  3.4T   1% /mnt
root@stb1:~#

root@stb1:~# bonnie++ -d /mnt -u root -n 128:10:0:5 -m stb1-1
Using uid:0, gid:0.
Writing a byte at a time...done
Writing intelligently...done
Rewriting...done
Reading a byte at a time...done
Reading intelligently...done
start 'em...done...done...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version  1.96       ------Sequential Output------ --Sequential Input- 
--Random-
Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
stb1-1           8G  1150  97 102418   6 32516   2  2139  95 96899   4 
771.7  15
Latency              8881us    1842ms    4292ms   11700us     252ms   
47795us
Version  1.96       ------Sequential Create------ --------Random 
Create--------
stb1-1              -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
files:max            /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
          128:10:0/5   120   0 40511  22   109   0    94   0    93   
0    28   0
Latency             13858ms   27269us      300s   23428ms     965ms    
3740ms
1.96,1.96,stb1-1,1,1302367781,8G,,1150,97,102418,6,32516,2,2139,95,96899,4,771.7,15,128,10,,,5,120,0,40511,22,109,0,94,0,93,0,28,0,8881us,1842ms,4292ms,11700us,252ms,47795us,13858ms,27269us,300s,23428ms,965ms,3740ms

Messages in mds.log:

2011-04-09 21:09:12.355366 7fa114795700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0xea48b0 sd=10 pgs=0 cs=0 l=0).accept 
peer addr is really xx.xx.xx.104:0/2435973235 (socket is 77.120
.104.104:45340/0)
2011-04-09 21:46:29.219213 7fa115f9f700 log [INF] : closing stale 
session client4109 xx.xx.xx.104:0/2435973235 after 301.146714
2011-04-09 21:46:33.078161 7fa114795700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x517dcd0 sd=10 pgs=0 cs=0 l=0).accept 
peer addr is really xx.xx.xx.104:0/2435973235 (socket is 
xx.xx.xx.104:34911/0)
2011-04-09 21:46:33.083027 7fa114795700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x517dcd0 sd=10 pgs=0 cs=0 l=0).accept we 
reset (peer sent cseq 2), sending RESETSESSION
2011-04-09 21:46:33.151068 7fa114795700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x24b3e90 sd=10 pgs=0 cs=0 l=0).accept 
peer addr is really xx.xx.xx.104:0/2435973235 (socket is 
xx.xx.xx.104:34912/0)
2011-04-09 21:46:33.392349 7fa1170a2700 mds0.server  no longer in 
reconnect state, ignoring reconnect, sending close
2011-04-09 21:46:33.392481 7fa1170a2700 log [INF] : denied reconnect 
attempt (mds is up:active) from client4109 xx.xx.xx.104:0/2435973235 
after 2011-04-09 21:46:33.392330 (allowed interval 45)
2011-04-09 21:46:33.431556 7fa114795700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x24b3e90 sd=10 pgs=9 cs=1 l=0).fault 
initiating reconnect
2011-04-09 21:46:33.434201 7fa11417d700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x517dcd0 sd=11 pgs=0 cs=0 l=0).accept 
peer addr is really xx.xx.xx.104:0/2435973235 (socket is 
xx.xx.xx.104:34913/0)
2011-04-09 21:46:33.442067 7fa11417d700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x517dcd0 sd=11 pgs=0 cs=0 l=0).accept 
connect_seq 0 vs existing 2 state 3
2011-04-09 21:46:33.442109 7fa11417d700 -- xx.xx.xx.199:6800/20513 >> 
xx.xx.xx.104:0/2435973235 pipe(0x517dcd0 sd=11 pgs=0 cs=0 l=0).accept 
peer reset, then tried to connect to us, replacing
2011-04-09 21:46:33.448964 7fa1170a2700 mds0.1 ms_handle_remote_reset on 
xx.xx.xx.104:0/2435973235
2011-04-09 22:51:32.482137 7fa1170a2700 mds0.cache.dir(10000020009) 
mismatch between head items and fnode.fragstat! printing dentries

And many-many messages like:

2011-04-09 22:51:32.482192 7fa1170a2700 mds0.cache.dir(10000020009) 
[dentry #1/Bonnie.11304/00000/0000000000d9 [2,head] auth (dversion lock) 
v=27380 inode=0x7fa0f4a72fa0 | inodepin 0x7fa0ef246cf0]
2011-04-09 22:51:32.482208 7fa1170a2700 mds0.cache.dir(10000020009) 
[dentry #1/Bonnie.11304/00000/0000000008 [2,head] auth (dversion lock) 
pv=0 v=125745 inode=0x7fa0d02939e0 | inodepin 0x7fa0cb76c418]
2011-04-09 22:51:32.482223 7fa1170a2700 mds0.cache.dir(10000020009) 
[dentry #1/Bonnie.11304/00000/000000000e [2,head] auth (dversion lock) 
pv=0 v=108861 inode=0x7fa0d2776fc0 | inodepin 0x7fa0cbf5dae8]
2011-04-09 22:51:32.482236 7fa1170a2700 mds0.cache.dir(10000020009) 
[dentry #1/Bonnie.11304/00000/0000000028 [2,head] auth (dversion lock) 
v=33172 inode=0x7fa0f4bf0020 | inodepin 0x7fa0fcea2c60]
2011-04-09 22:51:32.482250 7fa1170a2700 mds0.cache.dir(10000020009) 
[dentry #1/Bonnie.11304/00000/0000000039 [2,head] auth (dversion lock) 
pv=0 v=117571 inode=0x7fa0cf2783d0 | inodepin 0x7fa0cb3f4600]
---

root@stb1:~# ls -al /mnt
total 4
drwxr-xr-x  1 root root    0 2011-04-10 00:04 .
drwxr-xr-x 23 root root 4096 2011-04-07 02:02 ..
root@stb1:~# df -h /mnt
Filesystem            Size  Used Avail Use% Mounted on
xx.xx.xx.199:/      3.6T  1.8G  3.4T   1% /mnt

root@stc1:~# rados df
pool name                 KB      objects       clones     degraded      
unfound           rd        rd KB           wr        wr KB
casdata                    0            0            0            
0           0            0            0            0            0
data                   32005        32005            0            
0           0        88297     14912171       451822     17025197
metadata              146855           63            0            
0           0         4468     37326846       213199      2451206
rbd                        0            0            0            
0           0            0            0            0            0
   total used         1798788        32068
   total avail     3623561536
   total space     3768948976
root@stc1:~#

--------------------

Configuration:

ceph.conf:
[global]
         max open files = 131072

[mon]
         mon data = /mfs/data/mon$id
[mon0]
         host = stm1
         mon addr = xx.xx.xx.199:6789
[mds]
         keyring = /mfs/data/keyring.$name
[mds1]
         host = stm1
         mds addr = xx.xx.xx.199
[osd]
         osd data = /mfs
         osd journal = /journal/journal
         osd journal size = 500
         journal dio = false
[osd0]
         host = stc1
[osd1]
         host = stc2
[osd2]
         host = stc3
[osd3]
         host = stc4



WBR,
    Fyodor.
