From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: couldn't use rbd
Date: Thu, 02 Feb 2012 17:26:51 -0800
Message-ID: <4F2B37DB.4070506@dreamhost.com>
References: <CAM2zNoOyURtLAzh=DNcPjazj1RpgEY7WeJ_-QVjOWzbTp+qSUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38496 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab2BCB0v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 20:26:51 -0500
In-Reply-To: <CAM2zNoOyURtLAzh=DNcPjazj1RpgEY7WeJ_-QVjOWzbTp+qSUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Masuko Tomoya <tomoya.masuko@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/02/2012 01:49 AM, Masuko Tomoya wrote:
> Hi, all.
>
> When I execute "rbd" command, it is not success.
>
> root@ceph01:~# rbd list
> (no response)
>
> /var/log/ceph/mon.0.log
> -----
> 2012-02-02 17:58:19.801762 7ff4bbfb1710 -- 10.68.119.191:6789/0<==
> client.? 10.68.119.191:0/1002580 1 ==== auth(proto 0 30 bytes) v1 ====
> 56+0+0 (625540289 0 0) 0x1619a00 con 0x1615a00
> 2012-02-02 17:58:19.801919 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
> 0x1619c00 con 0x1615a00
> 2012-02-02 17:58:19.802505 7ff4bbfb1710 -- 10.68.119.191:6789/0<==
> client.? 10.68.119.191:0/1002580 2 ==== auth(proto 2 32 bytes) v1 ====
> 58+0+0 (346146289 0 0) 0x161fc00 con 0x1615a00
> 2012-02-02 17:58:19.802673 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
> 0x1619a00 con 0x1615a00
> 2012-02-02 17:58:19.803473 7ff4bbfb1710 -- 10.68.119.191:6789/0<==
> client.? 10.68.119.191:0/1002580 3 ==== auth(proto 2 165 bytes) v1
> ==== 191+0+0 (3737796417 0 0) 0x1619600 con 0x1615a00
> 2012-02-02 17:58:19.803745 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> 10.68.119.191:0/1002580 -- auth_reply(proto 2 0 Success) v1 -- ?+0
> 0x161fc00 con 0x1615a00
> 2012-02-02 17:58:19.804425 7ff4bbfb1710 -- 10.68.119.191:6789/0<==
> client.? 10.68.119.191:0/1002580 4 ==== mon_subscribe({monmap=0+}) v2
> ==== 23+0+0 (1620593354 0 0) 0x1617380 con 0x1615a00
> 2012-02-02 17:58:19.804488 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1635700 con 0x1615a00
> 2012-02-02 17:58:19.804517 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> client.? 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 -- ?+0
> 0x163d780
> 2012-02-02 17:58:19.804550 7ff4bbfb1710 -- 10.68.119.191:6789/0<==
> client.4112 10.68.119.191:0/1002580 5 ====
> mon_subscribe({monmap=0+,osdmap=0}) v2 ==== 42+0+0 (982583713 0 0)
> 0x1617a80 con 0x1615a00
> 2012-02-02 17:58:19.804578 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617380 con 0x1615a00
> 2012-02-02 17:58:19.804656 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v1 --
> ?+0 0x1619600
> 2012-02-02 17:58:19.804744 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 --
> ?+0 0x163d900
> 2012-02-02 17:58:19.804778 7ff4bbfb1710 -- 10.68.119.191:6789/0<==
> client.4112 10.68.119.191:0/1002580 6 ====
> mon_subscribe({monmap=0+,osdmap=0}) v2 ==== 42+0+0 (982583713 0 0)
> 0x16178c0 con 0x1615a00
> 2012-02-02 17:58:19.804811 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> 10.68.119.191:0/1002580 -- mon_map v1 -- ?+0 0x1617a80 con 0x1615a00
> 2012-02-02 17:58:19.804855 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> client.? 10.68.119.191:0/1002580 -- osd_map(3..3 src has 1..3) v1 --
> ?+0 0x1619400
> 2012-02-02 17:58:19.804884 7ff4bbfb1710 -- 10.68.119.191:6789/0 -->
> client.4112 10.68.119.191:0/1002580 -- mon_subscribe_ack(300s) v1 --
> ?+0 0x161d300
> -----

No problems there.

>
> BTW, I could execute "rados lspools".
>
> root@ceph01:~# rados lspools
> data
> metadata
> rbd

This might mean the rbd image list object can't be read for some
reason, or the rbd tool is doing something weird that the rados tool
isn't. Can you share the output of 'ceph -s' and
'rbd ls --log-to-stderr --debug-ms 1 --debug-objecter 20 --debug-monc 20 
--debug-auth 20'?

You can run 'rados lspools' with those options as well and compare.

> I would like to use rbd volume and attach it as virtual device for VM
> guest on KVM.
>
> Could you advice to me ?
>
>
> My environment is below.
>
> *ceph cluster is configured on single server.
> *server is ubuntu 10.10 maverick.
> *ceph, librados2 and librbd1 packages are installed.
>   (version: 0.38-1maverick)
> *apparmor is disable.

apparmor shouldn't matter if you have libvirt 0.9.9 or newer.

> *root@ceph01:/# ls -l /etc/ceph
> total 16
> -rw-r--r-- 1 root root 340 2012-02-02 17:28 ceph.conf
> -rw------- 1 root root  92 2012-02-02 17:28 client.admin.keyring
> -rw------- 1 root root  85 2012-02-02 17:28 mds.0.keyring
> -rw------- 1 root root  85 2012-02-02 17:28 osd.0.keyring
> */var/lib/ceph/tmp is exists.
> root@ceph01:/var/log# ls -l /var/lib/ceph/
> total 4
> drwxrwxrwx 2 root root 4096 2011-11-11 09:28 tmp
>
> */etc/ceph/ceph.conf
> [global]
>          auth supported = cephx
>          keyring = /etc/ceph/$name.keyring
> [mon]
>          mon data = /data/data/mon$id
>          debug ms = 1
> [mon.0]
>          host = ceph01
>          mon addr = 10.68.119.191:6789
> [mds]
>
> [mds.0]
>          host = ceph01
> [osd]
>          osd data = /data/osd$id
>          osd journal = /data/osd$id/journal
>          osd journal size = 512
>          osd class tmp = /var/lib/ceph/tmp
> [osd.0]
>          host = ceph01
>          btrfs devs = /dev/sdb1
>
>
> Waiting for your reply,
>
> Tomoya.


