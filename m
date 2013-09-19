From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [ceph-users] Scaling RBD module
Date: Wed, 18 Sep 2013 18:10:19 -0700
Message-ID: <523A4EFB.8040601@inktank.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:48458 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab3ISBMy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Sep 2013 21:12:54 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so7692516pbb.38
        for <ceph-devel@vger.kernel.org>; Wed, 18 Sep 2013 18:12:54 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F0FC4A040@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Anirban Ray <Anirban.Ray@sandisk.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On 09/17/2013 03:30 PM, Somnath Roy wrote:
> Hi,
> I am running Ceph on a 3 node cluster and each of my server node is running 10 OSDs, one for each disk. I have one admin node and all the nodes are connected with 2 X 10G network. One network is for cluster and other one configured as public network.
>
> Here is the status of my cluster.
>
> ~/fio_test# ceph -s
>
>    cluster b2e0b4db-6342-490e-9c28-0aadf0188023
>     health HEALTH_WARN clock skew detected on mon. <server-name-2>, mon. <server-name-3>
>     monmap e1: 3 mons at {<server-name-1>=xxx.xxx.xxx.xxx:6789/0, <server-name-2>=xxx.xxx.xxx.xxx:6789/0, <server-name-3>=xxx.xxx.xxx.xxx:6789/0}, election epoch 64, quorum 0,1,2 <server-name-1>,<server-name-2>,<server-name-3>
>     osdmap e391: 30 osds: 30 up, 30 in
>      pgmap v5202: 30912 pgs: 30912 active+clean; 8494 MB data, 27912 MB used, 11145 GB / 11172 GB avail
>     mdsmap e1: 0/0/1 up
>
>
> I started with rados bench command to benchmark the read performance of this Cluster on a large pool (~10K PGs) and found that each rados client has a limitation. Each client can only drive up to a certain mark. Each server  node cpu utilization shows it is  around 85-90% idle and the admin node (from where rados client is running) is around ~80-85% idle. I am trying with 4K object size.

Note that rados bench with 4k objects is different from rbd with
4k-sized I/Os - rados bench sends each request to a new object,
while rbd objects are 4M by default.

> Now, I started running more clients on the admin node and the performance is scaling till it hits the client cpu limit. Server still has the cpu of 30-35% idle. With small object size I must say that the ceph per osd cpu utilization is not promising!
>
> After this, I started testing the rados block interface with kernel rbd module from my admin node.
> I have created 8 images mapped on the pool having around 10K PGs and I am not able to scale up the performance by running fio (either by creating a software raid or running on individual /dev/rbd* instances). For example, running multiple fio instances (one in /dev/rbd1 and the other in /dev/rbd2)  the performance I am getting is half of what I am getting if running one instance. Here is my fio job script.
>
> [random-reads]
> ioengine=libaio
> iodepth=32
> filename=/dev/rbd1
> rw=randread
> bs=4k
> direct=1
> size=2G
> numjobs=64
>
> Let me know if I am following the proper procedure or not.
>
> But, If my understanding is correct, kernel rbd module is acting as a client to the cluster and in one admin node I can run only one of such kernel instance.
> If so, I am then limited to the client bottleneck that I stated earlier. The cpu utilization of the server side is around 85-90% idle, so, it is clear that client is not driving.
>
> My question is, is there any way to hit the cluster  with more client from a single box while testing the rbd module ?

You can run multiple librbd instances easily (for example with
multiple runs of the rbd bench-write command).

The kernel rbd driver uses the same rados client instance for multiple
block devices by default. There's an option (noshare) to use a new
rados client instance for a newly mapped device, but it's not exposed
by the rbd cli. You need to use the sysfs interface that 'rbd map' uses
instead.

Once you've used rbd map once on a machine, the kernel will already
have the auth key stored, and you can use:

echo '1.2.3.4:6789 name=admin,key=client.admin,noshare poolname 
imagename' > /sys/bus/rbd/add

Where 1.2.3.4:6789 is the address of a monitor, and you're connecting
as client.admin.

You can use 'rbd unmap' as usual.

Josh
