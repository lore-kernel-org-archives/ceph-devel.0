From: Liu Yuan <namei.unix@gmail.com>
Subject: Re: Any concern about Ceph on CentOS
Date: Wed, 17 Jul 2013 15:25:05 +0800
Message-ID: <20130717072504.GA2811@ubuntu-precise>
References: <20130717065943.GC13122@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:57240 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab3GQHZQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jul 2013 03:25:16 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so1579898pbc.30
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jul 2013 00:25:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130717065943.GC13122@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Wed, Jul 17, 2013 at 08:59:43AM +0200, Kasper Dieter wrote:
> Hi Xiaoxi, Wheats,
> 
> you hit the right point: We are looking for an Enterprise Linux distribution as base for Ceph.
> RHEL and CentOS has a very broad distribution and a high acceptance in the Data Center due to our observation.
> 
> The pain of this distro (from Ceph point of view) is the old kernel.
> As you know a 'new' kernel ( >= 3.6) is mandatory for stability and features of the Kernel CephFS and RBD (and btrfs).
> 
> So, we decided to use a very stable distro (CentOS-6.4) and combine it with a new, but mature/stable kernel (3.8.13).
> 
> I'm running fedora on my Laptop:
> Linux oder 3.9.9-301.fc19.x86_64 #1 SMP Thu Jul 4 15:10:36 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
> but as you said it is "too aggressive".
> Another aspect might be our good knowledge on RHEL and small experience with Ubuntu.
> 
> It is our goal to run all three presentation layers Block/File/Object in one Ceph cluster.
> We have good experience with block and file and also the performance looks quit well:
> 
> [root@rx37-4 ~]# ceph osd dump | grep SAS-group-2
> pool 5 'SAS-group-2' rep size 2 min_size 1 crush_ruleset 4 object_hash rjenkins pg_num 3300 pgp_num 3300 last_change 306 owner 0
> 
> [root@rx37-2 cephfs]# dd if=/dev/zero of=/mnt/cephfs/sas-pool-5/file1 bs=4194304 count=10240
> 10240+0 records in
> 10240+0 records out
> 42949672960 bytes (43 GB) copied, 23.8877 s, 1.8 GB/s
> 

You were just testing memory performance, no? You can try append
'oflag=direct,sync' or 'oflag=direct' to your dd. This will give you real speed.

Thanks
Yuan
