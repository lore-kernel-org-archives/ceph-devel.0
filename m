From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: ceph-client-standalone bug update ,make,WARNING: "task_dirty_inc"
 ,ubuntu10.10 Linux-2.6.35-22-generic
Date: Thu, 28 Oct 2010 17:55:34 +0800
Message-ID: <1288259734.2621.23.camel@osd1>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	 <Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	 <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	 <Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:22106 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750705Ab0J1KAy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 06:00:54 -0400
In-Reply-To: <Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@newdream.net, gregf@hq.newdream.net

Hi ,all 

At Ubuntu 10.10 x86_64 , kernel : Linux-2.6.35-22-generic ,

I git Lastest ceph-client-standalone source codes from
git://ceph.newdream.net/ceph-client-standalone.git

it make fail, get the warning messages: "account_page_dirtied" 

=================== Logs ========================

jeff@cephserver:~/work/ceph-client-standalone$ make 

 ...................................

CC [M]  /home/jeff/work/ceph-client-standalone/ceph_hash.o
  CC [M]  /home/jeff/work/ceph-client-standalone/ceph_frag.o
  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING:
"account_page_dirtied" [/home/jeff/work/ceph-client-standalone/ceph.ko]
undefined!
  CC      /home/jeff/work/ceph-client-standalone/ceph.mod.o
  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.ko
make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-generic'
jeff@cephserver:~/work/ceph-client-standalone$ 

=====================================================

then  i change to master-backport, to make it ,
still get a warning messages : "task_dirty_inc" .

===============logs===================================

jeff@cephserver:~/work/ceph-client-standalone$ git checkout -b
master-backport origin/master-backport
Branch master-backport set up to track remote branch master-backport
from origin.
Switched to a new branch 'master-backport'
jeff@cephserver:~/work/ceph-client-standalone$ git pull
Already up-to-date.

jeff@cephserver:~/work/ceph-client-standalone$ make 

.........................................

  CC [M]  /home/jeff/work/ceph-client-standalone/osdmap.o
  CC [M]  /home/jeff/work/ceph-client-standalone/debugfs.o
  CC [M]  /home/jeff/work/ceph-client-standalone/auth.o
  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING:
"task_dirty_inc" [/home/jeff/work/ceph-client-standalone/ceph.ko]
undefined!
  CC      /home/jeff/work/ceph-client-standalone/ceph.mod.o
  LD [M]  /home/jeff/work/ceph-client-standalone/ceph.ko
make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-22-generic'
jeff@cephserver:~/work/ceph-client-standalone$ 

=========================================================

Is it a bug ? or i git wrong source package ? 

Thanks,
Jeff,Wu







