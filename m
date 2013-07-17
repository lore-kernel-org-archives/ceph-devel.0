From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: Any concern about Ceph on CentOS
Date: Wed, 17 Jul 2013 08:59:43 +0200
Message-ID: <20130717065943.GC13122@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:46089 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab3GQHAA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jul 2013 03:00:00 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Xiaoxi, Wheats,

you hit the right point: We are looking for an Enterprise Linux distribution as base for Ceph.
RHEL and CentOS has a very broad distribution and a high acceptance in the Data Center due to our observation.

The pain of this distro (from Ceph point of view) is the old kernel.
As you know a 'new' kernel ( >= 3.6) is mandatory for stability and features of the Kernel CephFS and RBD (and btrfs).

So, we decided to use a very stable distro (CentOS-6.4) and combine it with a new, but mature/stable kernel (3.8.13).

I'm running fedora on my Laptop:
Linux oder 3.9.9-301.fc19.x86_64 #1 SMP Thu Jul 4 15:10:36 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
but as you said it is "too aggressive".
Another aspect might be our good knowledge on RHEL and small experience with Ubuntu.

It is our goal to run all three presentation layers Block/File/Object in one Ceph cluster.
We have good experience with block and file and also the performance looks quit well:

[root@rx37-4 ~]# ceph osd dump | grep SAS-group-2
pool 5 'SAS-group-2' rep size 2 min_size 1 crush_ruleset 4 object_hash rjenkins pg_num 3300 pgp_num 3300 last_change 306 owner 0

[root@rx37-2 cephfs]# dd if=/dev/zero of=/mnt/cephfs/sas-pool-5/file1 bs=4194304 count=10240
10240+0 records in
10240+0 records out
42949672960 bytes (43 GB) copied, 23.8877 s, 1.8 GB/s

[root@rx37-2 ~]# df -k | grep ceph
10.10.38.13:/        40253585408 2546787328 37706798080   7% /mnt/cephfs

Cheers,
-Dieter


On Wed, Jul 17, 2013 at 08:27:52AM +0200, Chen, Xiaoxi wrote:
> Hi Dieter,
>     Thanks a lot for the information. Could I learn more about your use case ? Would you care performance ?
>     And may I know why you want CentOS+ Custom kernel ? 
>     I thought people use CentOS for stability concern but if using CentOS + Custom Kernel, 
>     why don't you just use Ubuntu or Fedora(although Fedora is usually too aggressive).
>                                                                       Xiaoxi
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Kasper Dieter
> Sent: Wednesday, July 17, 2013 2:17 PM
> To: Chen, Xiaoxi
> Cc: ceph-devel@vger.kernel.org; ceph-users@ceph.com
> Subject: Re: Any concern about Ceph on CentOS
> 
> Hi Xiaoxi,
> 
> we are really running Ceph on CentOS-6.4
> (6 server nodes, 3 client nodes, 160 OSDs).
> 
> We put a 3.8.13 Kernel on top and installed the ceph-0.61.4 cluster with mkcephfs, because ceph-deploy seems to be still very buggy and has big dependencies to the newest python.
> 
> ceph.ko
> rbd.ko
> and ceph-fuse are running fast, well and stable (so far ;-) ).
> 
> Cheers,
> -Dieter
> 
> On Wed, Jul 17, 2013 at 03:18:22AM +0200, Chen, Xiaoxi wrote:
> > Hi list,
> >    I would like to ask if anyone really run Ceph on CentOS/RHEL? 
> >    Since the kernel version for Cent/RHEL is much older than that of Ubuntu, 
> >    I am thinking about whether we have some known performance/functionality issue?
> >    Thanks for everyone could share your insight for Ceph+CentOS.
> > 																												Xiaoxi
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
