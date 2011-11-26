From: Maxim Mikheev <mikhmv@datintsol.com>
Subject: need help in a recovering ceph
Date: Sat, 26 Nov 2011 10:31:02 -0500
Message-ID: <4ED10636.6070705@biodatomics.com>
Reply-To: Maxim Mikheev <mikhmv@datintsol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47353 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab1KZPbG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Nov 2011 10:31:06 -0500
Received: by vcbfk14 with SMTP id fk14so2663931vcb.19
        for <ceph-devel@vger.kernel.org>; Sat, 26 Nov 2011 07:31:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Everyone,

My ceph instance was too slow and I tried to benchmark it with bonnie++. 
Benchmark finished with error message and Ceph died.
I cannot mount ceph on any computers:
root@s3-2core:~# mount -t ceph -o 
name=admin,secretfile=/etc/ceph/mycluster.secret   192.168.2.11:/ /root/mnt/
mount error 5 = Input/output error

I have 250Gb data in ceph, I can generate this data again but it will 
take around 2 weeks.

The question how can I reanimate ceph? I like the idea of ceph but 
unfortunately I am not alone in the project an we are close to give up 
on using it.
I just recently start to use it and don't know what kind of information 
I should submit. Here are what I know:

root@s2-8core:~# ceph health
2011-11-26 10:20:32.565809 mon <- [health]
2011-11-26 10:20:32.566140 mon.0 -> 'HEALTH_OK' (0)
---------------------------------------------------------------------------------------------------
  # ceph osd dump -o -
2011-11-26 10:04:46.922947 mon <- [osd,dump]
2011-11-26 10:04:46.935616 mon.0 -> 'dumped osdmap epoch 465' (0)
epoch 465
fsid c09c2197-3976-3779-d7b1-26700db70b68
created 2011-11-04 12:43:26.390483
modifed 2011-11-25 22:21:17.275421
flags full

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 192 
pgp_num 192 lpg_num 2 lpgp_num 2 last_change 5 owner 0 
crash_replay_interval 60
     removed_snaps [2~2]
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 
192 pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 192 
pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1 owner 0

max_osd 3
osd.0 up   in  weight 1 up_from 462 up_thru 462 down_at 303 
last_clean_interval [292,298) lost_at 461 192.168.2.10:6800/4059 
192.168.2.10:6801/4059 192.168.2.10:6802/4059
osd.1 up   in  weight 1 up_from 296 up_thru 462 down_at 295 
last_clean_interval [281,294) lost_at 199 192.168.2.11:6801/3363 
192.168.2.11:6805/3363 192.168.2.11:6806/3363
osd.2 up   in  weight 1 up_from 272 up_thru 462 down_at 268 
last_clean_interval [257,267) 192.168.2.12:6800/1097 
192.168.2.12:6801/1097 192.168.2.12:6802/1097


  wrote 1081 byte payload to -
----------------------------------------------------------------------------------------------------
root@s2-8core:~# cat /etc/ceph/ceph.conf
[global]
     auth supported = cephx
         keyring = /etc/ceph/mycluster.keyring
         max open files = 131072
         log file = /var/log/ceph/$name.log
         pid file = /var/run/ceph/$name.pid
[mon]
     keyring = /etc/ceph/$name.keyring
     mon data = /srv/mon.$id
     debug ms = 1
[mon.a]
     host = s2-8core
     mon addr = 192.168.2.11:6789
[mds]
     keyring = /etc/ceph/$name.keyring
[mds.a]
     host = s2-8core
[osd]
     keyring = /etc/ceph/$name.keyring
     osd data = /srv/osd.$id
     osd journal = /srv/osd.$id/journal
     osd journal size = 1000 ; journal size, in megabytes
[osd.0]
     host = s1-2core
[osd.1]
     host = s2-8core
[osd.2]
     host = s3-2core

Thank you in an advance,
    Max
